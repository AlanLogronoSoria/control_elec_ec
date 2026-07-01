/// Implementación del repositorio de Coordinador Provincial.
///
/// Todas las estadísticas se calculan desde la base de datos local (Drift),
/// que es la fuente de verdad del sistema offline-first.
library;

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' show Value;

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
}
