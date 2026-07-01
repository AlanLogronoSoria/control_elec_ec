/// Casos de uso de autenticación.
///
/// Cada clase encapsula una sola operación de negocio.
/// La capa de presentación solo invoca use cases, nunca repositorios directamente.
library;

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

// ────────────────────────────────────────────────────────────────────────────
// Login Use Case
// ────────────────────────────────────────────────────────────────────────────

/// Caso de uso: Inicio de sesión.
class LoginUseCase {
  const LoginUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, UserEntity>> call({
    required String cedula,
    required String password,
  }) =>
      _repository.login(cedula: cedula, password: password);
}

// ────────────────────────────────────────────────────────────────────────────
// Logout Use Case
// ────────────────────────────────────────────────────────────────────────────

/// Caso de uso: Cierre de sesión.
class LogoutUseCase {
  const LogoutUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, void>> call() => _repository.logout();
}

// ────────────────────────────────────────────────────────────────────────────
// Change Password Use Case
// ────────────────────────────────────────────────────────────────────────────

/// Caso de uso: Cambio de contraseña (primer login obligatorio).
class ChangePasswordUseCase {
  const ChangePasswordUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, void>> call({
    required String oldPassword,
    required String newPassword,
  }) =>
      _repository.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
}

// ────────────────────────────────────────────────────────────────────────────
// Forgot Password Use Case
// ────────────────────────────────────────────────────────────────────────────

/// Caso de uso: Solicitud de recuperación de contraseña.
class ForgotPasswordUseCase {
  const ForgotPasswordUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, void>> call({required String cedula}) =>
      _repository.sendPasswordRecovery(cedula: cedula);
}

// ────────────────────────────────────────────────────────────────────────────
// Confirm Password Recovery Use Case
// ────────────────────────────────────────────────────────────────────────────

/// Caso de uso: Confirmar recuperación de contraseña con token de email.
class ConfirmPasswordRecoveryUseCase {
  const ConfirmPasswordRecoveryUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, void>> call({
    required String userId,
    required String secret,
    required String newPassword,
  }) =>
      _repository.confirmPasswordRecovery(
        userId: userId,
        secret: secret,
        newPassword: newPassword,
      );
}

// ────────────────────────────────────────────────────────────────────────────
// Get Current User Use Case
// ────────────────────────────────────────────────────────────────────────────

/// Caso de uso: Obtener usuario actualmente autenticado.
class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, UserEntity>> call() => _repository.getCurrentUser();
}

// ────────────────────────────────────────────────────────────────────────────
// Create User Use Case
// ────────────────────────────────────────────────────────────────────────────

/// Caso de uso: Creación de nuevo usuario (jerárquica).
/// Solo coordinadores pueden crear usuarios del siguiente nivel.
class CreateUserUseCase {
  const CreateUserUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, UserEntity>> call({
    required String cedula,
    required String nombres,
    required String apellidos,
    required String telefono,
    required String correo,
    required UserRole rol,
    String? precinctId,
  }) =>
      _repository.createUser(
        cedula: cedula,
        nombres: nombres,
        apellidos: apellidos,
        telefono: telefono,
        correo: correo,
        rol: rol,
        precinctId: precinctId,
      );
}
