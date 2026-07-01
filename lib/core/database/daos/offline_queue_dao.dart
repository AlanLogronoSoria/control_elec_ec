/// DAO de la cola de sincronización offline.
library;

import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/offline_queue_table.dart';

part 'offline_queue_dao.g.dart';

@DriftAccessor(tables: [OfflineQueueTable])
class OfflineQueueDao extends DatabaseAccessor<AppDatabase>
    with _$OfflineQueueDaoMixin {
  OfflineQueueDao(super.db);

  /// Encola una operación offline.
  Future<int> enqueue({
    required String operation,
    required String collectionName,
    required String documentId,
    required String payload,
  }) async {
    return await into(offlineQueueTable).insert(
      OfflineQueueTableCompanion.insert(
        operation: operation,
        collectionName: collectionName,
        documentId: documentId,
        payload: payload,
      ),
    );
  }

  /// Obtiene todas las operaciones pendientes (FIFO).
  Future<List<OfflineQueueTableData>> getPendingOperations() =>
      (select(offlineQueueTable)
            ..where((t) => t.syncStatus.equals('pending'))
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .get();

  /// Observa el conteo de operaciones pendientes en tiempo real.
  Stream<int> watchPendingCount() {
    return (select(offlineQueueTable)
          ..where((t) => t.syncStatus.equals('pending')))
        .watch()
        .map((list) => list.length);
  }

  /// Marca una operación como en progreso.
  Future<void> markProcessing(int id) async {
    await (update(offlineQueueTable)..where((t) => t.id.equals(id))).write(
      OfflineQueueTableCompanion(
        syncStatus: const Value('processing'),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Marca una operación como exitosamente sincronizada y la elimina.
  Future<void> markSynced(int id) async {
    await (delete(offlineQueueTable)..where((t) => t.id.equals(id))).go();
  }

  /// Marca una operación como fallida con mensaje de error.
  Future<void> markFailed(int id, String errorMessage) async {
    await (update(offlineQueueTable)..where((t) => t.id.equals(id))).write(
      OfflineQueueTableCompanion(
        syncStatus: const Value('failed'),
        lastError: Value(errorMessage),
        retryCount: const Value.absent(), // Se incrementa en SyncService
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Incrementa el contador de reintentos y vuelve al estado pending.
  Future<void> scheduleRetry(int id, int currentRetryCount) async {
    await (update(offlineQueueTable)..where((t) => t.id.equals(id))).write(
      OfflineQueueTableCompanion(
        syncStatus: const Value('pending'),
        retryCount: Value(currentRetryCount + 1),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Elimina operaciones exitosas y fallidas con más de 3 reintentos.
  Future<void> cleanup() async {
    await (delete(offlineQueueTable)
          ..where(
            (t) =>
                t.syncStatus.equals('synced') |
                (t.syncStatus.equals('failed') & t.retryCount.isBiggerThanValue(3)),
          ))
        .go();
  }

  /// Cuenta total de operaciones pendientes.
  Future<int> countPending() async {
    final result = await (select(offlineQueueTable)
          ..where((t) => t.syncStatus.equals('pending')))
        .get();
    return result.length;
  }
}
