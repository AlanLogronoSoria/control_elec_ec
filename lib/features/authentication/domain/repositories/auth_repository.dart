/// Contrato del repositorio de autenticación (capa de dominio).
///
/// La capa de presentación solo conoce esta interfaz — nunca
/// los detalles de Appwrite o Drift.
library;

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

/// Interfaz del repositorio de autenticación.
abstract class AuthRepository {
  /// Inicia sesión con cédula y contraseña.
  ///
  /// Retorna [UserEntity] en éxito, [Failure] en error.
  Future<Either<Failure, UserEntity>> login({
    required String cedula,
    required String password,
  });

  /// Cierra la sesión actual.
  Future<Either<Failure, void>> logout();

  /// Cambia la contraseña del usuario actual.
  ///
  /// Actualiza también el flag `password_changed` en Appwrite.
  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  /// Registra solicitud de restablecimiento de contraseña por cédula.
  /// El restablecimiento real lo ejecuta el coordinador provincial.
  Future<Either<Failure, void>> sendPasswordRecovery({
    required String cedula,
  });

  /// Completa la recuperación de contraseña con el token del email.
  Future<Either<Failure, void>> confirmPasswordRecovery({
    required String userId,
    required String secret,
    required String newPassword,
  });

  /// Verifica el email del usuario con el token recibido.
  Future<Either<Failure, void>> verifyEmail({
    required String userId,
    required String secret,
  });

  /// Obtiene el usuario actualmente autenticado (desde caché local).
  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// Retorna `true` si hay una sesión activa.
  Future<bool> isLoggedIn();

  /// Crea un nuevo usuario (solo Coordinador Provincial/Recinto pueden hacer esto).
  Future<Either<Failure, UserEntity>> createUser({
    required String cedula,
    required String nombres,
    required String apellidos,
    required String telefono,
    required String correo,
    required UserRole rol,
    String? precinctId,
  });
}
