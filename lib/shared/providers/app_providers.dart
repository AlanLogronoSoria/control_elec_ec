/// Providers globales que exponen casos de uso y servicios
/// inyectados por GetIt hacia Riverpod.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/injection_container.dart';
import '../../core/services/sync_service.dart';
import '../../features/authentication/domain/usecases/auth_usecases.dart';

// ── Auth Use Cases ────────────────────────────────────────────────────────

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return sl<LoginUseCase>();
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return sl<LogoutUseCase>();
});

final changePasswordUseCaseProvider = Provider<ChangePasswordUseCase>((ref) {
  return sl<ChangePasswordUseCase>();
});

final forgotPasswordUseCaseProvider = Provider<ForgotPasswordUseCase>((ref) {
  return sl<ForgotPasswordUseCase>();
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return sl<GetCurrentUserUseCase>();
});

final createUserUseCaseProvider = Provider<CreateUserUseCase>((ref) {
  return sl<CreateUserUseCase>();
});

// ── Sync Service ──────────────────────────────────────────────────────────

final syncServiceProvider = Provider<SyncService>((ref) {
  return sl<SyncService>();
});

/// Proveedor para escuchar la cantidad de operaciones pendientes offline.
final pendingSyncCountProvider = StreamProvider<int>((ref) {
  final syncService = ref.watch(syncServiceProvider);
  return syncService.pendingCountStream;
});
