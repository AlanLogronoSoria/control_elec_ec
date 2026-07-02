/// Constantes globales de la aplicación Control Electoral Ecuador 2026.
///
/// IMPORTANTE: Reemplaza los valores de Appwrite con los de tu proyecto real.
library;

class AppConstants {
  AppConstants._();

  // ── Appwrite Configuration ─────────────────────────────────────────────
  /// Endpoint del servidor Appwrite.
  /// Reemplaza con tu endpoint real: https://cloud.appwrite.io/v1
  static const String appwriteEndpoint = 'https://nyc.cloud.appwrite.io/v1';

  /// ID del proyecto en Appwrite.
  static const String appwriteProjectId = '6a45d7f90006381b65c3';

  /// ID de la base de datos en Appwrite.
  static const String appwriteDatabaseId = '6a45d891001f2abe7350';

  // ── Collection IDs ─────────────────────────────────────────────────────
  static const String colUsers = 'users';
  static const String colPrecincts = 'electoral_precincts';
  static const String colTables = 'electoral_tables';
  static const String colOrganizations = 'political_organizations';
  static const String colCandidates = 'candidates';
  static const String colActs = 'electoral_acts';
  static const String colVotes = 'votes';
  static const String colExtraVotes = 'extra_votes';
  static const String colOfflineQueue = 'offline_queue';

  // ── Appwrite Storage ───────────────────────────────────────────────────
  static const String storageActsBucketId = 'acts_photos';

  // ── Blur Detection ────────────────────────────────────────────────────
  /// Umbral de varianza del Laplaciano. Imágenes con varianza menor
  /// a este valor se consideran borrosas.
  static const double blurVarianceThreshold = 80.0;

  // ── Authentication ────────────────────────────────────────────────────
  /// Contraseña inicial asignada a todos los usuarios nuevos.
  static const String defaultPassword = 'Ecuador2026';

  // ── Roles ──────────────────────────────────────────────────────────────
  static const String roleProvincial = 'coordinador_provincial';
  static const String roleRecinto = 'coordinador_recinto';
  static const String roleVeedor = 'veedor_mesa';

  // ── Dignidades ────────────────────────────────────────────────────────
  static const String dignidadAlcalde = 'alcalde';
  static const String dignidadPrefecto = 'prefecto';

  // ── UI ─────────────────────────────────────────────────────────────────
  static const Duration splashDuration = Duration(seconds: 2);
  static const Duration syncInterval = Duration(seconds: 30);
  static const int paginationLimit = 25;

  // ── Database ───────────────────────────────────────────────────────────
  static const String localDbName = 'control_electoral.db';
  static const int localDbVersion = 1;

  // ── GPS ───────────────────────────────────────────────────────────────
  /// Tiempo máximo de espera para obtener posición GPS.
  static const Duration gpsTimeout = Duration(seconds: 15);
}
