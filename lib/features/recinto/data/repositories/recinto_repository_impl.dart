/// Implementación del repositorio de Coordinador de Recinto.
library;

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/sync_service.dart';
import '../../../authentication/data/models/user_model.dart';
import '../../../authentication/domain/entities/user_entity.dart';
import '../../domain/entities/recinto_entities.dart';
import '../../domain/repositories/recinto_repository.dart';

class RecintoRepositoryImpl implements RecintoRepository {
  RecintoRepositoryImpl({
    required AppDatabase database,
    required SyncService syncService,
    required FlutterSecureStorage secureStorage,
  })  : _db = database,
        _syncService = syncService,
        _secureStorage = secureStorage;

  final AppDatabase _db;
  final SyncService _syncService;
  final FlutterSecureStorage _secureStorage;

  Future<String?> _getCurrentUserId() =>
      _secureStorage.read(key: 'current_user_id');

  Future<String?> _getCurrentPrecinctId() async {
    final userId = await _getCurrentUserId();
    if (userId == null) return null;
    final user = await _db.usersDao.getUserById(userId);
    return user?.precinctId;
  }

  @override
  Future<Either<Failure, RecintoProgressEntity>> getProgress() async {
    try {
      final precinctId = await _getCurrentPrecinctId();
      if (precinctId == null) {
        return const Left(CacheFailure(message: 'Recinto no encontrado para este usuario.'));
      }

      final precinct = await _db.precinctsDao.getPrecinctById(precinctId);
      final tables = await _db.precinctsDao.getTablesByPrecinct(precinctId);

      int completadas = 0;
      int enProgreso = 0;
      int pendientes = 0;

      for (final t in tables) {
        if (t.estadoActa == 'completado') completadas++;
        else if (t.estadoActa == 'en_progreso') enProgreso++;
        else pendientes++;
      }

      return Right(RecintoProgressEntity(
        precinctId: precinctId,
        precinctName: precinct?.nombreRecinto ?? 'Desconocido',
        totalMesas: tables.length,
        mesasCompletadas: completadas,
        mesasEnProgreso: enProgreso,
        mesasPendientes: pendientes,
      ));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Stream<RecintoProgressEntity> watchProgress() async* {
    final precinctId = await _getCurrentPrecinctId();
    if (precinctId == null) return;

    yield* _db.precinctsDao.watchTablesByPrecinct(precinctId).asyncMap((tables) async {
      final precinct = await _db.precinctsDao.getPrecinctById(precinctId);
      
      int completadas = 0;
      int enProgreso = 0;
      int pendientes = 0;

      for (final t in tables) {
        if (t.estadoActa == 'completado') completadas++;
        else if (t.estadoActa == 'en_progreso') enProgreso++;
        else pendientes++;
      }

      return RecintoProgressEntity(
        precinctId: precinctId,
        precinctName: precinct?.nombreRecinto ?? 'Desconocido',
        totalMesas: tables.length,
        mesasCompletadas: completadas,
        mesasEnProgreso: enProgreso,
        mesasPendientes: pendientes,
      );
    });
  }

  @override
  Future<Either<Failure, List<VeedorAsignadoEntity>>> getVeedores() async {
    try {
      final precinctId = await _getCurrentPrecinctId();
      if (precinctId == null) return const Right([]);

      final users = await _db.usersDao.getUsersByPrecinct(precinctId);
      final result = <VeedorAsignadoEntity>[];

      for (final u in users) {
        if (u.rol == UserRole.veedorMesa.value) {
          final tables = await _db.precinctsDao.getTablesByVeedor(u.id);
          result.add(VeedorAsignadoEntity(
            user: UserModel.fromDrift(u).toEntity(),
            mesasAsignadas: tables.map((t) => t.jrvNumber).toList(),
          ));
        }
      }

      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> assignTableToVeedor({
    required String tableId,
    required String veedorId,
  }) async {
    try {
      // 1. Actualizar DB Local
      await _db.precinctsDao.assignVeedorToTable(tableId, veedorId);

      // 2. Encolar actualización para Appwrite
      final payload = {
        'veedor_id': veedorId,
        'updated_at': DateTime.now().toIso8601String(),
      };

      await _syncService.enqueueUpdate(
        collectionName: AppConstants.colTables,
        documentId: tableId,
        payload: payload,
      );

      _syncService.syncNow();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unassignTable({required String tableId}) async {
    try {
      // Establecer veedorId a null en DB Local
      await _db.precinctsDao.assignVeedorToTable(tableId, null);

      // Encolar actualización para Appwrite
      final payload = {
        'veedor_id': null,
        'estado_acta': 'pendiente',
        'updated_at': DateTime.now().toIso8601String(),
      };

      await _syncService.enqueueUpdate(
        collectionName: AppConstants.colTables,
        documentId: tableId,
        payload: payload,
      );

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
