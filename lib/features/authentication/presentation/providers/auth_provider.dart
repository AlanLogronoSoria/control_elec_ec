/// Estado y notifier de autenticación (Riverpod).
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth_usecases.dart';
import '../../../../core/errors/failures.dart';
import '../../../../shared/providers/app_providers.dart';

// ── Estado ────────────────────────────────────────────────────────────────

/// Estado de autenticación.
class AuthState {
  const AuthState({
    this.user,
    this.isLoading = false,
    this.failure,
    this.isLoggedIn = false,
  });

  final UserEntity? user;
  final bool isLoading;
  final Failure? failure;
  final bool isLoggedIn;

  bool get hasError => failure != null;

  AuthState copyWith({
    UserEntity? user,
    bool? isLoading,
    Failure? failure,
    bool? isLoggedIn,
    bool clearFailure = false,
    bool clearUser = false,
  }) {
    return AuthState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      failure: clearFailure ? null : (failure ?? this.failure),
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

// ── Notifier ──────────────────────────────────────────────────────────────

/// Notifier de autenticación — gestiona el ciclo de vida de sesión.
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required ChangePasswordUseCase changePasswordUseCase,
    required ForgotPasswordUseCase forgotPasswordUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required CreateUserUseCase createUserUseCase,
  })  : _login = loginUseCase,
        _logout = logoutUseCase,
        _changePassword = changePasswordUseCase,
        _forgotPassword = forgotPasswordUseCase,
        _getCurrentUser = getCurrentUserUseCase,
        _createUser = createUserUseCase,
        super(const AuthState());

  final LoginUseCase _login;
  final LogoutUseCase _logout;
  final ChangePasswordUseCase _changePassword;
  final ForgotPasswordUseCase _forgotPassword;
  final GetCurrentUserUseCase _getCurrentUser;
  final CreateUserUseCase _createUser;

  /// Intenta restaurar la sesión al iniciar la app.
  Future<void> checkSession() async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _getCurrentUser();
    result.fold(
      (failure) => state = const AuthState(isLoggedIn: false),
      (user) => state = AuthState(user: user, isLoggedIn: true),
    );
  }

  /// Inicia sesión.
  Future<void> login({required String cedula, required String password}) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _login(cedula: cedula, password: password);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        failure: failure,
        isLoggedIn: false,
      ),
      (user) => state = AuthState(
        user: user,
        isLoggedIn: true,
        isLoading: false,
      ),
    );
  }

  /// Cierra sesión.
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);
    await _logout();
    state = const AuthState(isLoggedIn: false);
  }

  /// Cambia la contraseña del usuario actual.
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, failure: failure);
        return false;
      },
      (_) {
        // Actualizar el usuario con passwordChanged = true
        final updatedUser = state.user?.copyWith(passwordChanged: true);
        state = state.copyWith(
          isLoading: false,
          user: updatedUser,
          clearFailure: true,
        );
        return true;
      },
    );
  }

  /// Envía solicitud de recuperación de contraseña mediante cédula.
  Future<bool> sendForgotPassword({required String cedula}) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _forgotPassword(cedula: cedula);
    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, failure: failure);
        return false;
      },
      (_) {
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }

  /// Crea un nuevo usuario (coordinador o veedor).
  ///
  /// ATENCIÓN: account.create() cambia la sesión al nuevo usuario,
  /// por lo que después de crear hay que forzar logout.
  Future<bool> createUser({
    required String cedula,
    required String nombres,
    required String apellidos,
    required String telefono,
    required String correo,
    required UserRole rol,
    String? precinctId,
  }) async {
    state = state.copyWith(isLoading: true, clearFailure: true);
    final result = await _createUser(
      cedula: cedula,
      nombres: nombres,
      apellidos: apellidos,
      telefono: telefono,
      correo: correo,
      rol: rol,
      precinctId: precinctId,
    );
    return result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, failure: failure);
        return false;
      },
      (_) {
        // account.create() cambió la sesión — forzar logout
        state = const AuthState(isLoggedIn: false);
        return true;
      },
    );
  }

  /// Limpia el error del estado.
  void clearError() => state = state.copyWith(clearFailure: true);
}

// ── Providers ─────────────────────────────────────────────────────────────

/// Provider del AuthNotifier.
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    loginUseCase: ref.watch(loginUseCaseProvider),
    logoutUseCase: ref.watch(logoutUseCaseProvider),
    changePasswordUseCase: ref.watch(changePasswordUseCaseProvider),
    forgotPasswordUseCase: ref.watch(forgotPasswordUseCaseProvider),
    getCurrentUserUseCase: ref.watch(getCurrentUserUseCaseProvider),
    createUserUseCase: ref.watch(createUserUseCaseProvider),
  );
});
