/// Implementación del repositorio de Coordinador Provincial.
///
/// Todas las estadísticas se calculan desde la base de datos local (Drift),
/// que es la fuente de verdad del sistema offline-first.
library;

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' show Value;
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/provincial_entities.dart';
import '../../domain/repositories/provincial_repository.dart';

class ProvincialRepositoryImpl implements ProvincialRepository {
  ProvincialRepositoryImpl({required AppDatabase database}) : _db = database;

  final AppDatabase _db;

  @override
  Future<Either<Failure, ResumenProvincialEntity>> getResumenGlobal() async {
    try {
      final tables = await _db.precinctsDao.getAllTables();
      final allActs = await _db.select(_db.actsTable).get();

      final actasEscrutadas = allActs
          .where((a) => a.estado == 'guardado' || a.estado == 'sincronizado')
          .length;
      final totalActas = tables.length * 2;

      final totalSufragantes = await _db.actsDao.getTotalSufragantes();
      final estadisticasAlcalde = await _buildEstadisticas('alcalde');
      final estadisticasPrefecto = await _buildEstadisticas('prefecto');

      return Right(ResumenProvincialEntity(
        totalSufragantes: totalSufragantes,
        actasEscrutadas: actasEscrutadas,
        totalActas: totalActas,
        estadisticasAlcalde: estadisticasAlcalde,
        estadisticasPrefecto: estadisticasPrefecto,
      ));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  Future<List<EstadisticaVotosEntity>> _buildEstadisticas(
      String dignidad) async {
    final orgs = await _db.actsDao.getOrganizationsByDignidad(dignidad);
    final results = <EstadisticaVotosEntity>[];

    int totalVotosDignidad = 0;
    final datos = <({
      String candidatoNombre,
      String orgNombre,
      String color,
      int votos
    })>[];

    for (final org in orgs) {
      final candidates =
          await _db.actsDao.getCandidatesByOrganization(org.id);
      for (final candidate in candidates) {
        final voteRows = await (_db.select(_db.votesTable)
              ..where((v) => v.candidateId.equals(candidate.id)))
            .get();
        final totalVotos =
            voteRows.fold<int>(0, (sum, v) => sum + v.cantidadVotos);
        datos.add((
          candidatoNombre: candidate.nombre,
          orgNombre: org.nombre,
          color: org.color,
          votos: totalVotos,
        ));
        totalVotosDignidad += totalVotos;
      }
    }

    for (final item in datos) {
      results.add(EstadisticaVotosEntity(
        candidatoNombre: item.candidatoNombre,
        organizacionNombre: item.orgNombre,
        colorHex: item.color,
        totalVotos: item.votos,
        porcentaje: totalVotosDignidad > 0
            ? (item.votos / totalVotosDignidad) * 100
            : 0.0,
      ));
    }

    return results;
  }

  @override
  Stream<ResumenProvincialEntity> watchResumenGlobal() async* {
    yield* Stream.fromFuture(getResumenGlobal().then(
      (res) => res.fold(
        (l) => throw Exception(l.message),
        (r) => r,
      ),
    ));
  }

  @override
  Future<Either<Failure, void>> assignCoordinatorToPrecinct({
    required String precinctId,
    required String coordinatorId,
  }) async {
    try {
      await (_db.update(_db.precinctsTable)
            ..where((t) => t.id.equals(precinctId)))
          .write(
        PrecinctsTableCompanion(
          coordinadorRecintoId: Value(coordinatorId),
        ),
      );
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AvanceRecintoEntity>>>
      getAvancePorRecinto() async {
    try {
      final precincts = await _db.precinctsDao.getAllPrecincts();
      final result = <AvanceRecintoEntity>[];

      for (final p in precincts) {
        final tables =
            await _db.precinctsDao.getTablesByPrecinct(p.id);
        final completadas =
            tables.where((t) => t.estadoActa == 'completado').length;
        final totalMesas = tables.length;
        final pendientes = totalMesas - completadas;

        int votosAlcalde = 0;
        int votosPrefecto = 0;

        for (final table in tables) {
          final acts =
              await _db.actsDao.getActsByTable(table.id);
          for (final act in acts.where(
            (a) => a.estado == 'guardado' || a.estado == 'sincronizado',
          )) {
            final extra =
                await _db.actsDao.getExtraVotesByAct(act.id);
            if (extra != null) {
              if (act.tipoDignidad == 'alcalde') {
                votosAlcalde += extra.totalSufragantes;
              } else if (act.tipoDignidad == 'prefecto') {
                votosPrefecto += extra.totalSufragantes;
              }
            }
          }
        }

        result.add(AvanceRecintoEntity(
          precinctId: p.id,
          precinctName: p.nombreRecinto,
          provincia: p.provincia,
          canton: p.canton,
          parroquia: p.parroquia,
          totalMesas: totalMesas,
          mesasCompletadas: completadas,
          mesasPendientes: pendientes,
          porcentajeCompletado: totalMesas == 0
              ? 0
              : (completadas / totalMesas) * 100,
          votosAlcalde: votosAlcalde,
          votosPrefecto: votosPrefecto,
        ));
      }

      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProvincialActaDetailEntity>> getActaDetail(
      String actId) async {
    try {
      final act = await _db.actsDao.getActById(actId);
      if (act == null) {
        return const Left(NotFoundFailure(message: 'Acta no encontrada.'));
      }

      final table =
          await _db.precinctsDao.getTableById(act.tableId);
      final precinct = table != null
          ? await _db.precinctsDao.getPrecinctById(table.precinctId)
          : null;

      final votesRows = await _db.actsDao.getVotesByAct(actId);
      final extraVotes =
          await _db.actsDao.getExtraVotesByAct(actId);

      final votosDetalle = <VotoCandidatoDetalleEntity>[];
      for (final v in votesRows) {
        final candidateRow = await (_db.select(_db.candidatesTable)
              ..where((c) => c.id.equals(v.candidateId)))
            .getSingleOrNull();
        final orgRow = candidateRow != null
            ? await (_db.select(_db.organizationsTable)
                  ..where((o) => o.id.equals(candidateRow.organizationId)))
                .getSingleOrNull()
            : null;

        votosDetalle.add(VotoCandidatoDetalleEntity(
          candidateName: candidateRow?.nombre ?? '—',
          organizationName: orgRow?.nombre ?? '—',
          colorHex: orgRow?.color ?? '#888888',
          cantidad: v.cantidadVotos,
        ));
      }

      String? veedorNombre;
      String? veedorCedula;
      if (table != null && table.veedorId != null) {
        final veedor =
            await _db.usersDao.getUserById(table.veedorId!);
        if (veedor != null) {
          veedorNombre = '${veedor.nombres} ${veedor.apellidos}';
          veedorCedula = veedor.cedula;
        }
      }

      return Right(ProvincialActaDetailEntity(
        actId: act.id,
        tipoDignidad: act.tipoDignidad,
        estado: act.estado,
        mesaJrv: table?.jrvNumber ?? 0,
        precinctName: precinct?.nombreRecinto ?? '—',
        votos: votosDetalle,
        votosBlancos: extraVotes?.votosBlancos ?? 0,
        votosNulos: extraVotes?.votosNulos ?? 0,
        totalSufragantes: extraVotes?.totalSufragantes ?? 0,
        photoUrl: act.photoUrl,
        localPhotoPath: act.localPhotoPath,
        gpsLatitude: act.gpsLatitude,
        gpsLongitude: act.gpsLongitude,
        createdAt: act.createdAt,
        updatedAt: act.updatedAt,
        veedorNombre: veedorNombre,
        veedorCedula: veedorCedula,
      ));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createPrecinct({
    required String provincia,
    required String canton,
    required String parroquia,
    required String nombreRecinto,
    required int numeroJrv,
  }) async {
    try {
      final id = const Uuid().v4();
      final now = DateTime.now();

      await _db.transaction(() async {
        await _db.precinctsDao.upsertPrecinct(
          PrecinctsTableCompanion.insert(
            id: id,
            provincia: provincia,
            canton: canton,
            parroquia: parroquia,
            nombreRecinto: nombreRecinto,
            numeroJrv: numeroJrv,
            createdAt: Value(now),
            updatedAt: Value(now),
          ),
        );

        await _db.precinctsDao.createTablesForPrecinct(
          precinctId: id,
          numeroJrv: numeroJrv,
        );
      });

      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AvanceRecintoEntity>>> getAllPrecincts() async {
    return getAvancePorRecinto();
  }

  @override
  Future<Either<Failure, List<PrecinctCoordinatorEntity>>>
      getCoordinadoresRecinto() async {
    try {
      final rows = await _db.usersDao.getUsersByRole(
        AppConstants.roleRecinto,
      );
      return Right(
        rows
            .map((u) => PrecinctCoordinatorEntity(
                  id: u.id,
                  cedula: u.cedula,
                  nombres: u.nombres,
                  apellidos: u.apellidos,
                  correo: u.correo,
                  precinctId: u.precinctId,
                ))
            .toList(),
      );
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
