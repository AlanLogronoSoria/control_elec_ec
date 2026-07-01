/// Base de datos principal de la aplicación (Drift).
///
/// Registra todas las tablas y DAOs. El archivo `.g.dart` es generado
/// por `build_runner` (`flutter pub run build_runner build`).
library;

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'tables/users_table.dart';
import 'tables/precincts_table.dart';
import 'tables/acts_table.dart';
import 'tables/offline_queue_table.dart';
import 'daos/users_dao.dart';
import 'daos/precincts_dao.dart';
import 'daos/acts_dao.dart';
import 'daos/offline_queue_dao.dart';
import '../../core/constants/app_constants.dart';

part 'app_database.g.dart';

/// Base de datos SQLite local de la aplicación.
///
/// Todas las operaciones de lectura/escritura pasan por los DAOs,
/// nunca directamente desde la UI o providers.
@DriftDatabase(
  tables: [
    UsersTable,
    PrecinctsTable,
    ElectoralTablesTable,
    OrganizationsTable,
    CandidatesTable,
    ActsTable,
    VotesTable,
    ExtraVotesTable,
    OfflineQueueTable,
  ],
  daos: [
    UsersDao,
    PrecinctsDao,
    ActsDao,
    OfflineQueueDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => AppConstants.localDbVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Seed datos iniciales de organizaciones políticas
          await _seedOrganizations();
        },
        onUpgrade: (m, from, to) async {
          // Futuras migraciones irán aquí
        },
      );

  /// Seed de organizaciones políticas y candidatos para alcaldía y prefectura.
  ///
  /// Datos realistas basados en el contexto electoral ecuatoriano.
  /// Cada organización tiene un candidato para la dignidad correspondiente.
  Future<void> _seedOrganizations() async {
    // ── ALCALDÍA ────────────────────────────────────────────────────────
    const alcaldeOrgs = [
      (
        id: 'alcalde_org_1',
        nombre: 'Movimiento Renovación Democrática',
        siglas: 'MRD',
        color: '#1565C0',
        lista: 1,
        candidato: 'Carlos Andrés Mendoza Vélez',
      ),
      (
        id: 'alcalde_org_2',
        nombre: 'Partido Unidad Ciudadana',
        siglas: 'PUC',
        color: '#C62828',
        lista: 2,
        candidato: 'María Fernanda Paredes López',
      ),
      (
        id: 'alcalde_org_3',
        nombre: 'Alianza por el Progreso Popular',
        siglas: 'APP',
        color: '#2E7D32',
        lista: 3,
        candidato: 'Luis Eduardo Gutiérrez Ramos',
      ),
      (
        id: 'alcalde_org_4',
        nombre: 'Frente de Integración Nacional',
        siglas: 'FIN',
        color: '#E65100',
        lista: 4,
        candidato: 'Ana Lucía Villacís Torres',
      ),
      (
        id: 'alcalde_org_5',
        nombre: 'Movimiento Justicia y Equidad',
        siglas: 'MJE',
        color: '#7B1FA2',
        lista: 5,
        candidato: 'Jorge Patricio Zambrano Cevallos',
      ),
    ];

    // ── PREFECTURA ──────────────────────────────────────────────────────
    const prefectoOrgs = [
      (
        id: 'prefecto_org_1',
        nombre: 'Movimiento Fuerza Provincial',
        siglas: 'MFP',
        color: '#0D47A1',
        lista: 1,
        candidato: 'Diana Carolina Espinoza Macías',
      ),
      (
        id: 'prefecto_org_2',
        nombre: 'Partido Desarrollo y Bienestar',
        siglas: 'PDB',
        color: '#B71C1C',
        lista: 2,
        candidato: 'Francisco Javier Almeida Solórzano',
      ),
      (
        id: 'prefecto_org_3',
        nombre: 'Coalición por el Cambio Social',
        siglas: 'CCS',
        color: '#1B5E20',
        lista: 3,
        candidato: 'Rosa Elena Morán Valencia',
      ),
      (
        id: 'prefecto_org_4',
        nombre: 'Unión por la Transformación Territorial',
        siglas: 'UTT',
        color: '#BF360C',
        lista: 4,
        candidato: 'Miguel Ángel Cárdenas Hidalgo',
      ),
      (
        id: 'prefecto_org_5',
        nombre: 'Movimiento Participación y Desarrollo',
        siglas: 'MPD',
        color: '#4A148C',
        lista: 5,
        candidato: 'Gabriela Estefanía Rivas Moreira',
      ),
    ];

    final todasLasOrgs = [...alcaldeOrgs, ...prefectoOrgs];

    for (final org in todasLasOrgs) {
      // Insertar organización política
      await into(organizationsTable).insertOnConflictUpdate(
        OrganizationsTableCompanion.insert(
          id: org.id,
          nombre: org.nombre,
          tipoDignidad:
              org.id.startsWith('alcalde') ? 'alcalde' : 'prefecto',
          numeroLista: org.lista,
          color: Value(org.color),
        ),
      );

      // Insertar candidato de la organización
      final candidateId = 'cand_${org.id}';
      await into(candidatesTable).insertOnConflictUpdate(
        CandidatesTableCompanion.insert(
          id: candidateId,
          nombre: org.candidato,
          organizationId: org.id,
          tipoDignidad:
              org.id.startsWith('alcalde') ? 'alcalde' : 'prefecto',
        ),
      );
    }
  }
}

/// Abre la conexión SQLite con drift_flutter.
QueryExecutor _openConnection() {
  return driftDatabase(name: AppConstants.localDbName);
}
