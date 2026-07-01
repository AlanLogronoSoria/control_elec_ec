/// Tabla de cola de sincronización offline.
///
/// Implementa el patrón Transactional Outbox para garantizar
/// que las operaciones locales se sincronicen con Appwrite
/// cuando regrese la conectividad.
library;

import 'package:drift/drift.dart';

/// Estado de una entrada en la cola.
enum SyncStatus {
  /// Pendiente de enviar a Appwrite.
  pending,

  /// Actualmente siendo procesada.
  processing,

  /// Enviada exitosamente.
  synced,

  /// Falló después de múltiples intentos.
  failed,
}

/// Tipo de operación offline.
enum OfflineOperation {
  create,
  update,
  delete,
}

/// Tabla de cola de sincronización offline.
/// Cada registro representa una operación pendiente de sincronizar.
class OfflineQueueTable extends Table {
  @override
  String get tableName => 'offline_queue';

  /// ID único del registro en la cola.
  IntColumn get id => integer().autoIncrement()();

  /// Tipo de operación: create | update | delete
  TextColumn get operation => text()();

  /// Nombre de la colección Appwrite afectada.
  TextColumn get collectionName => text()();

  /// ID del documento Appwrite (generado client-side con UUID).
  TextColumn get documentId => text()();

  /// Payload JSON con los datos del documento.
  TextColumn get payload => text()();

  /// Estado de sincronización.
  TextColumn get syncStatus =>
      text().withDefault(const Constant('pending'))();

  /// Número de intentos fallidos.
  IntColumn get retryCount => integer().withDefault(const Constant(0))();

  /// Mensaje del último error (para debugging).
  TextColumn get lastError => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
