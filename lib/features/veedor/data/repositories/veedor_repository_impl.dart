/// Implementación del repositorio Veedor.
library;

import 'dart:io';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/blur_detection_service.dart';
import '../../../../core/services/sync_service.dart';
import '../../../../core/services/appwrite_service.dart';
import '../../domain/entities/acta_entity.dart';
import '../../domain/repositories/veedor_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VeedorRepositoryImpl implements VeedorRepository {
  VeedorRepositoryImpl({
    required AppDatabase database,
    required SyncService syncService,
    required BlurDetectionService blurDetectionService,
    required FlutterSecureStorage secureStorage,
  })  : _db = database,
        _syncService = syncService,
        _blurDetection = blurDetectionService,
        _secureStorage = secureStorage;

  final AppDatabase _db;
  final SyncService _syncService;
  final BlurDetectionService _blurDetection;
  final FlutterSecureStorage _secureStorage;
  final _uuid = const Uuid();

  Future<String?> _getCurrentUserId() =>
      _secureStorage.read(key: 'current_user_id');

  @override
  Future<Either<Failure, List<MesaElectoralEntity>>> getAssignedTables() async {
    try {
      final userId = await _getCurrentUserId();
      if (userId == null) throw const CacheException(message: 'No user ID');

      final tables = await _db.precinctsDao.getTablesByVeedor(userId);
      final entities = <MesaElectoralEntity>[];

      for (final table in tables) {
        final precinct = await _db.precinctsDao.getPrecinctById(table.precinctId);
        if (precinct != null) {
          entities.add(
            MesaElectoralEntity(
              id: table.id,
              jrvNumber: table.jrvNumber,
              precinctName: precinct.nombreRecinto,
              parroquia: precinct.parroquia,
              estadoActa: table.estadoActa,
            ),
          );
        }
      }

      return Right(entities);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<MesaElectoralEntity>> watchAssignedTables() async* {
    final userId = await _getCurrentUserId();
    if (userId == null) return;

    yield* _db.precinctsDao.watchTablesByVeedor(userId).asyncMap((tables) async {
      final entities = <MesaElectoralEntity>[];
      for (final table in tables) {
        final precinct = await _db.precinctsDao.getPrecinctById(table.precinctId);
        if (precinct != null) {
          entities.add(
            MesaElectoralEntity(
              id: table.id,
              jrvNumber: table.jrvNumber,
              precinctName: precinct.nombreRecinto,
              parroquia: precinct.parroquia,
              estadoActa: table.estadoActa,
            ),
          );
        }
      }
      return entities;
    });
  }

  @override
  Future<Either<Failure, List<OrganizacionFormEntity>>> getFormularioForDignidad(
      String dignidad) async {
    try {
      final orgs = await _db.actsDao.getOrganizationsByDignidad(dignidad);
      final forms = <OrganizacionFormEntity>[];

      for (final org in orgs) {
        final candidates = await _db.actsDao.getCandidatesByOrganization(org.id);
        if (candidates.isNotEmpty) {
          final candidate = candidates.first; // Suponiendo 1 candidato por dignidad/org
          forms.add(
            OrganizacionFormEntity(
              organizationId: org.id,
              organizationName: org.nombre,
              candidateId: candidate.id,
              candidateName: candidate.nombre,
              colorHex: org.color,
            ),
          );
        }
      }

      return Right(forms);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerActa({
    required String tableId,
    required String tipoDignidad,
    required List<VotoCandidatoEntity> votos,
    required int votosBlancos,
    required int votosNulos,
    required int totalSufragantes,
    required Uint8List photoBytes,
    required double gpsLatitude,
    required double gpsLongitude,
  }) async {
    try {
      // 1. Guardar la foto localmente
      final appDir = await getApplicationDocumentsDirectory();
      final photoId = _uuid.v4();
      final localPath = '${appDir.path}/acta_$photoId.jpg';
      await File(localPath).writeAsBytes(photoBytes);

      // 2. Intentar subir foto a Appwrite Storage (si hay conexión)
      String? photoUrl;
      try {
        photoUrl = await _uploadPhotoToStorage(localPath, photoId);
      } catch (_) {
        // Offline o error de red: la foto se encolará para subir después
      }

      // 3. Transacción en Drift
      final actId = _uuid.v4();
      final now = DateTime.now();

      await _db.transaction(() async {
        // Guardar Acta
        await _db.actsDao.upsertAct(
          ActsTableCompanion.insert(
            id: actId,
            tableId: tableId,
            tipoDignidad: tipoDignidad,
            localPhotoPath: Value(localPath),
            photoUrl: Value(photoUrl),
            gpsLatitude: Value(gpsLatitude),
            gpsLongitude: Value(gpsLongitude),
            estado: const Value('guardado'),
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );

        // Guardar Votos
        for (final voto in votos) {
          await _db.actsDao.upsertVote(
            VotesTableCompanion.insert(
              id: _uuid.v4(),
              actId: actId,
              candidateId: voto.candidateId,
              cantidadVotos: Value(voto.cantidad),
              updatedAt: Value(now),
            ),
          );
        }

        // Guardar Extra Votos
        await _db.actsDao.upsertExtraVotes(
          ExtraVotesTableCompanion.insert(
            id: _uuid.v4(),
            actId: actId,
            votosBlancos: Value(votosBlancos),
            votosNulos: Value(votosNulos),
            totalSufragantes: Value(totalSufragantes),
            updatedAt: Value(now),
          ),
        );

        // Recalcular estado de la mesa según actas completadas
        await _recalcularEstadoMesa(tableId);
      });

      // 4. Preparar payload y encolar sync de base de datos
      final payload = {
        'table_id': tableId,
        'tipo_dignidad': tipoDignidad,
        'gps_latitude': gpsLatitude,
        'gps_longitude': gpsLongitude,
        'votos_blancos': votosBlancos,
        'votos_nulos': votosNulos,
        'total_sufragantes': totalSufragantes,
        'votos': votos.map((v) => {
              'candidate_id': v.candidateId,
              'cantidad_votos': v.cantidad,
            }).toList(),
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
        if (photoUrl != null) 'photo_url': photoUrl,
      };

      await _syncService.enqueueCreate(
        collectionName: AppConstants.colActs,
        documentId: actId,
        payload: payload,
      );

      // 5. Si no se subió la foto, encolar upload pendiente
      if (photoUrl == null) {
        await _syncService.enqueueFileUpload(
          actId: actId,
          fileId: photoId,
          localPath: localPath,
        );
      }

      _syncService.syncNow();

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  /// Intenta subir una foto al bucket acts_photos de Appwrite Storage.
  /// Retorna la URL pública del archivo o lanza excepción si falla.
  Future<String> _uploadPhotoToStorage(
      String localPath, String photoId) async {
    final uploaded = await AppwriteService.instance.storage.createFile(
      bucketId: AppConstants.storageActsBucketId,
      fileId: photoId,
      file: InputFile.fromPath(
        path: localPath,
        filename: 'acta_$photoId.jpg',
      ),
    );

    return '${AppConstants.appwriteEndpoint}/storage/buckets/'
        '${AppConstants.storageActsBucketId}/files/'
        '${uploaded.$id}/view?project=${AppConstants.appwriteProjectId}';
  }

  /// Recalcula el estado de una mesa electoral en base a sus actas.
  ///
  /// - 'pendiente': sin actas registradas
  /// - 'en_progreso': solo existe un acta (alcalde o prefecto)
  /// - 'completado': existen ambas actas (alcalde y prefecto)
  Future<void> _recalcularEstadoMesa(String tableId) async {
    final actas = await _db.actsDao.getActsByTable(tableId);
    final completadas = actas.where(
      (a) => a.estado == 'guardado' || a.estado == 'sincronizado',
    );
    final tieneAlcalde =
        completadas.any((a) => a.tipoDignidad == 'alcalde');
    final tienePrefecto =
        completadas.any((a) => a.tipoDignidad == 'prefecto');

    if (tieneAlcalde && tienePrefecto) {
      await _db.precinctsDao.updateTableStatus(tableId, 'completado');
    } else if (tieneAlcalde || tienePrefecto) {
      await _db.precinctsDao.updateTableStatus(tableId, 'en_progreso');
    } else {
      await _db.precinctsDao.updateTableStatus(tableId, 'pendiente');
    }
  }

  @override
  Future<Either<Failure, bool>> isImageBlurry(Uint8List imageBytes) async {
    try {
      final isBlurry = await _blurDetection.isBlurry(imageBytes);
      return Right(isBlurry);
    } catch (e) {
      return Left(ServerFailure(message: 'Error al analizar la imagen: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> correctActa(ActaElectoralEntity acta,
      {Uint8List? photoBytes}) async {
    try {
      final now = DateTime.now();

      // Si se proporciona nueva foto, guardarla localmente e intentar subir
      String? photoUrl = acta.photoUrl;
      String? localPhotoPath = acta.localPhotoPath;

      if (photoBytes != null) {
        final appDir = await getApplicationDocumentsDirectory();
        final photoId = _uuid.v4();
        localPhotoPath = '${appDir.path}/acta_$photoId.jpg';
        await File(localPhotoPath).writeAsBytes(photoBytes);

        try {
          photoUrl = await _uploadPhotoToStorage(localPhotoPath, photoId);
        } catch (_) {
          // Offline: se encolará después
        }
      }

      await _db.transaction(() async {
        // Actualizar el acta
        await (_db.update(_db.actsTable)
              ..where((t) => t.id.equals(acta.id)))
            .write(
          ActsTableCompanion(
            gpsLatitude: acta.gpsLatitude != null
                ? Value(acta.gpsLatitude!)
                : const Value.absent(),
            gpsLongitude: acta.gpsLongitude != null
                ? Value(acta.gpsLongitude!)
                : const Value.absent(),
            photoUrl: Value(photoUrl),
            localPhotoPath: Value(localPhotoPath),
            estado: const Value('guardado'),
            updatedAt: Value(now),
          ),
        );

        // Reescribir votos
        await _db.actsDao.deleteVotesByAct(acta.id);
        for (final v in acta.votos) {
          await _db.actsDao.upsertVote(
            VotesTableCompanion.insert(
              id: _uuid.v4(),
              actId: acta.id,
              candidateId: v.candidateId,
              cantidadVotos: Value(v.cantidad),
              updatedAt: Value(now),
            ),
          );
        }

        // Actualizar extra votos
        await _db.actsDao.upsertExtraVotes(
          ExtraVotesTableCompanion.insert(
            id: _uuid.v4(),
            actId: acta.id,
            votosBlancos: Value(acta.votosBlancos),
            votosNulos: Value(acta.votosNulos),
            totalSufragantes: Value(acta.totalSufragantes),
            updatedAt: Value(now),
          ),
        );

        // Recalcular estado de la mesa tras la corrección
        await _recalcularEstadoMesa(acta.tableId);
      });

      // Encolar actualización para Appwrite
      final payload = {
        'votos_blancos': acta.votosBlancos,
        'votos_nulos': acta.votosNulos,
        'total_sufragantes': acta.totalSufragantes,
        'votos': acta.votos
            .map((v) => {
                  'candidate_id': v.candidateId,
                  'cantidad_votos': v.cantidad,
                })
            .toList(),
        if (photoUrl != null) 'photo_url': photoUrl,
        'updated_at': now.toIso8601String(),
      };

      await _syncService.enqueueUpdate(
        collectionName: AppConstants.colActs,
        documentId: acta.id,
        payload: payload,
      );

      // Si nueva foto no se subió, encolar
      if (photoBytes != null && photoUrl == null && localPhotoPath != null) {
        await _syncService.enqueueFileUpload(
          actId: acta.id,
          fileId: localPhotoPath.split('/').last.replaceAll('.jpg', ''),
          localPath: localPhotoPath,
        );
      }

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActaElectoralEntity?>> getActa(
      String tableId, String dignidad) async {
    try {
      final actRow = await _db.actsDao.getActByTableAndDignidad(tableId, dignidad);
      if (actRow == null) return const Right(null);

      final votesRow = await _db.actsDao.getVotesByAct(actRow.id);
      final extraVotesRow = await _db.actsDao.getExtraVotesByAct(actRow.id);

      final votosEntities = <VotoCandidatoEntity>[];
      for (final v in votesRow) {
        // En una implementación real, se harían JOINs en el DAO para evitar n+1 queries
        votosEntities.add(
          VotoCandidatoEntity(
            candidateId: v.candidateId,
            candidateName: 'Candidato', // Placeholder
            organizationName: 'Org', // Placeholder
            cantidad: v.cantidadVotos,
          ),
        );
      }

      return Right(
        ActaElectoralEntity(
          id: actRow.id,
          tableId: actRow.tableId,
          tipoDignidad: actRow.tipoDignidad,
          votos: votosEntities,
          votosBlancos: extraVotesRow?.votosBlancos ?? 0,
          votosNulos: extraVotesRow?.votosNulos ?? 0,
          totalSufragantes: extraVotesRow?.totalSufragantes ?? 0,
          photoUrl: actRow.photoUrl,
          localPhotoPath: actRow.localPhotoPath,
          gpsLatitude: actRow.gpsLatitude,
          gpsLongitude: actRow.gpsLongitude,
        ),
      );
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
