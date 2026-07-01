/// Tablas de organizaciones políticas, candidatos y actas electorales.
library;

import 'package:drift/drift.dart';
import 'precincts_table.dart';

/// Organizaciones políticas participantes.
class OrganizationsTable extends Table {
  @override
  String get tableName => 'political_organizations';

  TextColumn get id => text()();

  /// Nombre oficial de la organización.
  TextColumn get nombre => text()();

  /// Dignidad: alcalde | prefecto
  TextColumn get tipoDignidad => text()();

  /// Número de lista (1-5).
  IntColumn get numeroLista => integer()();

  /// Color representativo (hex, ej: #1565C0).
  TextColumn get color => text().withDefault(const Constant('#1565C0'))();

  DateTimeColumn get lastSyncAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Candidatos por organización.
class CandidatesTable extends Table {
  @override
  String get tableName => 'candidates';

  TextColumn get id => text()();
  TextColumn get nombre => text()();

  TextColumn get organizationId =>
      text().references(OrganizationsTable, #id)();

  /// alcalde | prefecto
  TextColumn get tipoDignidad => text()();

  DateTimeColumn get lastSyncAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Actas electorales (una por dignidad por mesa).
class ActsTable extends Table {
  @override
  String get tableName => 'electoral_acts';

  TextColumn get id => text()();

  TextColumn get tableId =>
      text().references(ElectoralTablesTable, #id)();

  /// alcalde | prefecto
  TextColumn get tipoDignidad => text()();

  /// URL de la foto del acta en Appwrite Storage (null si aún no subida).
  TextColumn get photoUrl => text().nullable()();

  /// Ruta local de la foto pendiente de subir.
  TextColumn get localPhotoPath => text().nullable()();

  /// Coordenada GPS — latitud.
  RealColumn get gpsLatitude => real().nullable()();

  /// Coordenada GPS — longitud.
  RealColumn get gpsLongitude => real().nullable()();

  /// Estado: borrador | guardado | sincronizado
  TextColumn get estado =>
      text().withDefault(const Constant('borrador'))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastSyncAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Votos por candidato por acta.
class VotesTable extends Table {
  @override
  String get tableName => 'votes';

  TextColumn get id => text()();
  TextColumn get actId => text().references(ActsTable, #id)();
  TextColumn get candidateId => text().references(CandidatesTable, #id)();
  IntColumn get cantidadVotos => integer().withDefault(const Constant(0))();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Votos extra por acta (blancos, nulos, total sufragantes).
class ExtraVotesTable extends Table {
  @override
  String get tableName => 'extra_votes';

  TextColumn get id => text()();
  TextColumn get actId => text().references(ActsTable, #id).unique()();
  IntColumn get votosBlancos => integer().withDefault(const Constant(0))();
  IntColumn get votosNulos => integer().withDefault(const Constant(0))();
  IntColumn get totalSufragantes => integer().withDefault(const Constant(0))();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
