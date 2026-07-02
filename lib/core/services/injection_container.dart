/// Inyección de dependencias con GetIt.
///
/// Registra servicios, bases de datos, fuentes de datos,
/// repositorios y casos de uso.
library;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../database/app_database.dart';
import '../network/network_info.dart';
import 'appwrite_service.dart';
import 'blur_detection_service.dart';
import 'gps_service.dart';
import 'sync_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/authentication/domain/usecases/auth_usecases.dart';

import '../../features/veedor/domain/repositories/veedor_repository.dart';
import '../../features/veedor/data/repositories/veedor_repository_impl.dart';
import '../../features/veedor/domain/usecases/veedor_usecases.dart';

import '../../features/recinto/domain/repositories/recinto_repository.dart';
import '../../features/recinto/data/repositories/recinto_repository_impl.dart';
import '../../features/recinto/domain/usecases/recinto_usecases.dart';

import '../../features/provincial/domain/repositories/provincial_repository.dart';
import '../../features/provincial/data/repositories/provincial_repository_impl.dart';
import '../../features/provincial/domain/usecases/provincial_usecases.dart';

final sl = GetIt.instance; // Service Locator

/// Configura todas las dependencias de la aplicación.
Future<void> initDependencies() async {
  // ── 1. Core Services ───────────────────────────────────────────────────

  // Appwrite Service (Singleton)
  final appwrite = AppwriteService.instance;
  appwrite.initialize();
  sl.registerLazySingleton<AppwriteService>(() => appwrite);

  // Drift Database (Singleton)
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Secure Storage
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  // Network Info
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  // GPS Service
  sl.registerLazySingleton<GpsService>(() => GpsService.instance);

  // Blur Detection Service
  sl.registerLazySingleton<BlurDetectionService>(
    () => BlurDetectionService.instance,
  );

  // Sync Service
  sl.registerLazySingleton<SyncService>(
    () => SyncService(
      database: sl<AppDatabase>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // ── 2. Authentication Feature ──────────────────────────────────────────

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      database: sl<AppDatabase>(),
      networkInfo: sl<NetworkInfo>(),
      secureStorage: sl<FlutterSecureStorage>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmPasswordRecoveryUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(sl()));

  // Las features (Provincial, Recinto, Veedor) se registrarán aquí
  // a medida que las vayamos construyendo...

  // ── 3. Veedor Feature ──────────────────────────────────────────────────

  sl.registerLazySingleton<VeedorRepository>(
    () => VeedorRepositoryImpl(
      database: sl<AppDatabase>(),
      syncService: sl<SyncService>(),
      blurDetectionService: sl<BlurDetectionService>(),
      secureStorage: sl<FlutterSecureStorage>(),
    ),
  );

  sl.registerLazySingleton(() => GetAssignedTablesUseCase(sl()));
  sl.registerLazySingleton(() => RegisterActaUseCase(sl()));
  sl.registerLazySingleton(() => CorrectActaUseCase(sl()));
  // ── 4. Recinto Feature ───────────────────────────────────────────────────

  sl.registerLazySingleton<RecintoRepository>(
    () => RecintoRepositoryImpl(
      database: sl<AppDatabase>(),
      syncService: sl<SyncService>(),
      secureStorage: sl<FlutterSecureStorage>(),
    ),
  );

  sl.registerLazySingleton(() => GetRecintoProgressUseCase(sl()));
  sl.registerLazySingleton(() => GetVeedoresUseCase(sl()));
  sl.registerLazySingleton(() => AssignTableUseCase(sl()));
  // ── 5. Provincial Feature ──────────────────────────────────────────────────

  sl.registerLazySingleton<ProvincialRepository>(
    () => ProvincialRepositoryImpl(
      database: sl<AppDatabase>(),
    ),
  );

  sl.registerLazySingleton(() => GetResumenGlobalUseCase(sl()));
  sl.registerLazySingleton(() => AssignCoordinatorToPrecinctUseCase(sl()));
  sl.registerLazySingleton(() => GetAvancePorRecintoUseCase(sl()));
  sl.registerLazySingleton(() => GetActaDetailUseCase(sl()));
  sl.registerLazySingleton(() => CreatePrecinctUseCase(sl()));
  sl.registerLazySingleton(() => GetAllPrecinctsUseCase(sl()));
  sl.registerLazySingleton(() => GetCoordinadoresRecintoUseCase(sl()));
}
