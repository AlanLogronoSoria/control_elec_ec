/// Singleton de Appwrite. Provee instancias de Client, Account,
/// Databases y Storage configuradas para el proyecto.
library;

import 'package:appwrite/appwrite.dart';
import '../constants/app_constants.dart';

/// Servicio de Appwrite — Singleton que inicializa el cliente
/// y expone los servicios necesarios.
class AppwriteService {
  AppwriteService._();

  static final AppwriteService _instance = AppwriteService._();

  /// Instancia singleton.
  static AppwriteService get instance => _instance;

  late final Client _client;
  late final Account _account;
  late final Databases _databases;
  late final Storage _storage;
  late final Teams _teams;

  bool _initialized = false;

  /// Inicializa el cliente de Appwrite. Debe llamarse antes de
  /// usar cualquier servicio.
  void initialize() {
    if (_initialized) return;

    _client = Client()
      ..setEndpoint(AppConstants.appwriteEndpoint)
      ..setProject(AppConstants.appwriteProjectId);

    _account = Account(_client);
    _databases = Databases(_client);
    _storage = Storage(_client);
    _teams = Teams(_client);

    _initialized = true;
  }

  /// Cliente Appwrite configurado.
  Client get client {
    _assertInitialized();
    return _client;
  }

  /// Servicio de autenticación y cuentas.
  Account get account {
    _assertInitialized();
    return _account;
  }

  /// Servicio de base de datos.
  Databases get databases {
    _assertInitialized();
    return _databases;
  }

  /// Servicio de almacenamiento de archivos.
  Storage get storage {
    _assertInitialized();
    return _storage;
  }

  /// Servicio de equipos/roles.
  Teams get teams {
    _assertInitialized();
    return _teams;
  }

  void _assertInitialized() {
    assert(_initialized,
        'AppwriteService no ha sido inicializado. Llama initialize() en main.dart.');
  }

  // ── RBAC / Permissions ─────────────────────────────────────────────────

  /// Construye permisos para un veedor: solo él lee y actualiza sus actas.
  static List<String> permissionsVeedor(String veedorUserId) => [
        Permission.read(Role.user(veedorUserId)),
        Permission.update(Role.user(veedorUserId)),
      ];

  /// Construye permisos para un coordinador de recinto.
  static List<String> permissionsRecintoCoordinator(String coordinatorId) => [
        Permission.read(Role.user(coordinatorId)),
        Permission.update(Role.user(coordinatorId)),
      ];

  /// Construye permisos para documento de usuario nuevo: el usuario creado
  /// podrá leer su propio documento tras iniciar sesión.
  static List<String> permissionsUserDocument(String newUserId) => [
        Permission.read(Role.user(newUserId)),
        Permission.update(Role.user(newUserId)),
      ];
}
