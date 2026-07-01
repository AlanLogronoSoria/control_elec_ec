/// DAO de actas electorales, votos y organizaciones.
library;

import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/acts_table.dart';

part 'acts_dao.g.dart';

@DriftAccessor(tables: [
  OrganizationsTable,
  CandidatesTable,
  ActsTable,
  VotesTable,
  ExtraVotesTable,
])
class ActsDao extends DatabaseAccessor<AppDatabase> with _$ActsDaoMixin {
  ActsDao(super.db);

  // ── Organizaciones ────────────────────────────────────────────────────

  /// Obtiene todas las organizaciones políticas.
  Future<List<OrganizationsTableData>> getAllOrganizations() =>
      select(organizationsTable).get();

  /// Obtiene organizaciones por dignidad.
  Future<List<OrganizationsTableData>> getOrganizationsByDignidad(
      String dignidad) =>
      (select(organizationsTable)
            ..where((t) => t.tipoDignidad.equals(dignidad))
            ..orderBy([(t) => OrderingTerm.asc(t.numeroLista)]))
          .get();

  // ── Candidatos ────────────────────────────────────────────────────────

  Future<List<CandidatesTableData>> getCandidatesByOrganization(
      String organizationId) =>
      (select(candidatesTable)
            ..where((t) => t.organizationId.equals(organizationId)))
          .get();

  // ── Actas ─────────────────────────────────────────────────────────────

  /// Obtiene todas las actas de una mesa.
  Future<List<ActsTableData>> getActsByTable(String tableId) =>
      (select(actsTable)..where((t) => t.tableId.equals(tableId))).get();

  /// Observa actas de una mesa en tiempo real.
  Stream<List<ActsTableData>> watchActsByTable(String tableId) =>
      (select(actsTable)..where((t) => t.tableId.equals(tableId))).watch();

  /// Obtiene un acta específica por mesa y dignidad.
  Future<ActsTableData?> getActByTableAndDignidad(
      String tableId, String dignidad) =>
      (select(actsTable)
            ..where(
              (t) =>
                  t.tableId.equals(tableId) & t.tipoDignidad.equals(dignidad),
            ))
          .getSingleOrNull();

  /// Obtiene un acta por ID.
  Future<ActsTableData?> getActById(String id) =>
      (select(actsTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Inserta o actualiza un acta.
  Future<void> upsertAct(ActsTableCompanion act) =>
      into(actsTable).insertOnConflictUpdate(act);

  /// Actualiza la URL de la foto de un acta (tras subir a Appwrite Storage).
  Future<void> updateActPhoto(String actId, String photoUrl) async {
    await (update(actsTable)..where((t) => t.id.equals(actId))).write(
      ActsTableCompanion(
        photoUrl: Value(photoUrl),
        localPhotoPath: const Value(null),
        estado: const Value('sincronizado'),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  // ── Votos ─────────────────────────────────────────────────────────────

  /// Obtiene todos los votos de un acta.
  Future<List<VotesTableData>> getVotesByAct(String actId) =>
      (select(votesTable)..where((t) => t.actId.equals(actId))).get();

  /// Inserta o actualiza un registro de votos.
  Future<void> upsertVote(VotesTableCompanion vote) =>
      into(votesTable).insertOnConflictUpdate(vote);

  /// Elimina los votos de un acta (para re-ingreso).
  Future<int> deleteVotesByAct(String actId) =>
      (delete(votesTable)..where((t) => t.actId.equals(actId))).go();

  // ── Votos Extra ───────────────────────────────────────────────────────

  /// Obtiene los votos extra de un acta.
  Future<ExtraVotesTableData?> getExtraVotesByAct(String actId) =>
      (select(extraVotesTable)..where((t) => t.actId.equals(actId)))
          .getSingleOrNull();

  /// Inserta o actualiza votos extra.
  Future<void> upsertExtraVotes(ExtraVotesTableCompanion extraVotes) =>
      into(extraVotesTable).insertOnConflictUpdate(extraVotes);

  // ── Estadísticas ──────────────────────────────────────────────────────

  /// Suma total de sufragantes de todas las actas sincronizadas.
  Future<int> getTotalSufragantes() async {
    final extras = await select(extraVotesTable).get();
    return extras.fold<int>(0, (sum, e) => sum + e.totalSufragantes);
  }

  /// Suma de votos por organización (para dashboard).
  Future<Map<String, int>> getVotesByOrganization(String dignidad) async {
    final orgs = await getOrganizationsByDignidad(dignidad);
    final Map<String, int> result = {};

    for (final org in orgs) {
      // Obtener candidatos de esta organización
      final candidates = await getCandidatesByOrganization(org.id);
      int total = 0;

      for (final candidate in candidates) {
        final votes = await (select(votesTable)
              ..where((v) => v.candidateId.equals(candidate.id)))
            .get();
        total += votes.fold<int>(0, (sum, v) => sum + v.cantidadVotos);
      }

      result[org.nombre] = total;
    }

    return result;
  }
}
