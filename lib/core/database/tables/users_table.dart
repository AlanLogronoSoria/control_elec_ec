/// Tabla de usuarios en la base de datos local.
library;

import 'package:drift/drift.dart';

/// Tabla local de usuarios del sistema electoral.
/// Refleja la colección `users` de Appwrite.
class UsersTable extends Table {
  @override
  String get tableName => 'users';

  /// ID único (sincronizado con Appwrite document ID).
  TextColumn get id => text()();

  /// Cédula ecuatoriana (se usa como username en Appwrite).
  TextColumn get cedula => text().unique()();

  /// Nombres completos.
  TextColumn get nombres => text()();

  /// Apellidos completos.
  TextColumn get apellidos => text()();

  /// Teléfono (10 dígitos).
  TextColumn get telefono => text()();

  /// Correo electrónico.
  TextColumn get correo => text().unique()();

  /// Rol: coordinador_provincial | coordinador_recinto | veedor_mesa
  TextColumn get rol => text()();

  /// Si el usuario ya cambió su contraseña inicial.
  BoolColumn get passwordChanged => boolean().withDefault(const Constant(false))();

  /// Si el correo ya fue verificado.
  BoolColumn get emailVerified => boolean().withDefault(const Constant(false))();

  /// ID del recinto (solo para coordinadores de recinto y veedores).
  TextColumn get precinctId => text().nullable()();

  /// Timestamp de última sincronización con Appwrite.
  DateTimeColumn get lastSyncAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
