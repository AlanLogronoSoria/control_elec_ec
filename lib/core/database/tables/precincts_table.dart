/// Tabla de recintos electorales.
library;

import 'package:drift/drift.dart';
import 'users_table.dart';

/// Recintos electorales (escuelas, coliseos, etc.).
class PrecinctsTable extends Table {
  @override
  String get tableName => 'electoral_precincts';

  TextColumn get id => text()();
  TextColumn get provincia => text()();
  TextColumn get canton => text()();
  TextColumn get parroquia => text()();
  TextColumn get nombreRecinto => text()();
  IntColumn get numeroJrv => integer()();

  /// ID del coordinador de recinto asignado.
  TextColumn get coordinadorRecintoId =>
      text().nullable().references(UsersTable, #id)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastSyncAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Tabla de mesas electorales (JRV).
class ElectoralTablesTable extends Table {
  @override
  String get tableName => 'electoral_tables';

  TextColumn get id => text()();
  IntColumn get jrvNumber => integer()();

  /// Recinto al que pertenece esta mesa.
  TextColumn get precinctId =>
      text().references(PrecinctsTable, #id)();

  /// Veedor asignado a esta mesa.
  TextColumn get veedorId =>
      text().nullable().references(UsersTable, #id)();

  /// Estado: pendiente | en_progreso | completado
  TextColumn get estadoActa =>
      text().withDefault(const Constant('pendiente'))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastSyncAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
