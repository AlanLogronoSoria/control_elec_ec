/// DAO de recintos electorales y mesas electorales (JRV).
library;

import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/precincts_table.dart';

part 'precincts_dao.g.dart';

@DriftAccessor(tables: [PrecinctsTable, ElectoralTablesTable])
class PrecinctsDao extends DatabaseAccessor<AppDatabase>
    with _$PrecinctsDaoMixin {
  PrecinctsDao(super.db);

  // ── Recintos ──────────────────────────────────────────────────────────

  /// Obtiene todos los recintos.
  Future<List<PrecinctsTableData>> getAllPrecincts() =>
      select(precinctsTable).get();

  /// Observa todos los recintos en tiempo real.
  Stream<List<PrecinctsTableData>> watchAllPrecincts() =>
      select(precinctsTable).watch();

  /// Obtiene un recinto por ID.
  Future<PrecinctsTableData?> getPrecinctById(String id) =>
      (select(precinctsTable)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  /// Obtiene los recintos asignados a un coordinador específico.
  Future<List<PrecinctsTableData>> getPrecinctsByCoordinator(
      String coordinadorId) =>
      (select(precinctsTable)
            ..where((t) => t.coordinadorRecintoId.equals(coordinadorId)))
          .get();

  /// Inserta o actualiza un recinto.
  Future<void> upsertPrecinct(PrecinctsTableCompanion precinct) =>
      into(precinctsTable).insertOnConflictUpdate(precinct);

  /// Elimina un recinto.
  Future<int> deletePrecinct(String id) =>
      (delete(precinctsTable)..where((t) => t.id.equals(id))).go();

  // ── Mesas Electorales (JRV) ───────────────────────────────────────────

  /// Obtiene todas las mesas de un recinto.
  Future<List<ElectoralTablesTableData>> getTablesByPrecinct(
      String precinctId) =>
      (select(electoralTablesTable)
            ..where((t) => t.precinctId.equals(precinctId)))
          .get();

  /// Observa las mesas de un recinto en tiempo real.
  Stream<List<ElectoralTablesTableData>> watchTablesByPrecinct(
      String precinctId) =>
      (select(electoralTablesTable)
            ..where((t) => t.precinctId.equals(precinctId)))
          .watch();

  /// Obtiene las mesas asignadas a un veedor específico.
  Future<List<ElectoralTablesTableData>> getTablesByVeedor(
      String veedorId) =>
      (select(electoralTablesTable)
            ..where((t) => t.veedorId.equals(veedorId)))
          .get();

  /// Observa las mesas de un veedor en tiempo real.
  Stream<List<ElectoralTablesTableData>> watchTablesByVeedor(
      String veedorId) =>
      (select(electoralTablesTable)
            ..where((t) => t.veedorId.equals(veedorId)))
          .watch();

  /// Obtiene una mesa por ID.
  Future<ElectoralTablesTableData?> getTableById(String id) =>
      (select(electoralTablesTable)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  /// Inserta o actualiza una mesa.
  Future<void> upsertTable(ElectoralTablesTableCompanion table) =>
      into(electoralTablesTable).insertOnConflictUpdate(table);

  /// Actualiza el estado de una mesa.
  Future<void> updateTableStatus(String tableId, String estadoActa) async {
    await (update(electoralTablesTable)
          ..where((t) => t.id.equals(tableId)))
        .write(
      ElectoralTablesTableCompanion(estadoActa: Value(estadoActa)),
    );
  }

  /// Cuenta mesas completadas en un recinto.
  Future<int> countCompletedTables(String precinctId) async {
    final query = select(electoralTablesTable)
      ..where(
        (t) =>
            t.precinctId.equals(precinctId) &
            t.estadoActa.equals('completado'),
      );
    final result = await query.get();
    return result.length;
  }

  /// Obtiene todas las mesas electorales de todos los recintos.
  Future<List<ElectoralTablesTableData>> getAllTables() =>
      select(electoralTablesTable).get();

  /// Cuenta el total de mesas en todos los recintos.
  Future<int> countAllTables() async {
    final result = await select(electoralTablesTable).get();
    return result.length;
  }

  /// Asigna un veedor a una mesa electoral.
  Future<void> assignVeedorToTable(String tableId, String? veedorId) async {
    await (update(electoralTablesTable)
          ..where((t) => t.id.equals(tableId)))
        .write(
      ElectoralTablesTableCompanion(
        veedorId: Value(veedorId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Crea N mesas electorales (JRV) para un recinto recién creado.
  /// Genera una mesa por cada número del 1..numeroJrv.
  Future<void> createTablesForPrecinct({
    required String precinctId,
    required int numeroJrv,
  }) async {
    final now = DateTime.now();
    for (int i = 1; i <= numeroJrv; i++) {
      await into(electoralTablesTable).insert(
        ElectoralTablesTableCompanion.insert(
          id: '${precinctId}_jrv_$i',
          jrvNumber: i,
          precinctId: precinctId,
          estadoActa: const Value('pendiente'),
          createdAt: Value(now),
          updatedAt: Value(now),
        ),
      );
    }
  }

  /// Cuenta mesas completadas en todos los recintos.
  Future<int> countAllCompletedTables() async {
    final query = select(electoralTablesTable)
      ..where((t) => t.estadoActa.equals('completado'));
    final result = await query.get();
    return result.length;
  }
}
