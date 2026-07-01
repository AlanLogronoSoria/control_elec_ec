/// Jerarquía de fallos del dominio.
///
/// Todas las capas de datos mapean sus errores a uno de estos [Failure],
/// garantizando que la capa de presentación nunca conozca detalles
/// de infraestructura (Appwrite, SQLite, etc.).
library;

import 'package:equatable/equatable.dart';

/// Clase base abstracta para todos los fallos del dominio.
abstract class Failure extends Equatable {
  const Failure({this.message = '', this.code});

  /// Mensaje legible para el usuario o para logging.
  final String message;

  /// Código de error opcional (útil para Appwrite error codes).
  final int? code;

  @override
  List<Object?> get props => [message, code];
}

// ── Fallos de Servidor ──────────────────────────────────────────────────

/// Error de comunicación con el servidor Appwrite.
class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Error de servidor.', super.code});
}

/// El recurso no fue encontrado en el servidor.
class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Recurso no encontrado.', super.code});
}

/// El usuario no tiene permisos para la operación.
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message = 'No autorizado.', super.code});
}

/// Conflicto al actualizar (ej: versión desactualizada).
class ConflictFailure extends Failure {
  const ConflictFailure({super.message = 'Conflicto de datos.', super.code});
}

// ── Fallos de Caché/Local ───────────────────────────────────────────────

/// Error en la base de datos local (Drift/SQLite).
class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Error en base de datos local.', super.code});
}

/// No hay datos locales disponibles.
class NoLocalDataFailure extends Failure {
  const NoLocalDataFailure({super.message = 'Sin datos locales.', super.code});
}

// ── Fallos de Red ──────────────────────────────────────────────────────

/// No hay conexión a internet.
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Sin conexión a internet.', super.code});
}

// ── Fallos de Validación ───────────────────────────────────────────────

/// Datos de formulario inválidos.
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

/// Cédula ecuatoriana inválida.
class InvalidCedulaFailure extends Failure {
  const InvalidCedulaFailure({
    super.message = 'Cédula ecuatoriana inválida.',
    super.code,
  });
}

/// La sumatoria de votos no coincide con el total de sufragantes.
class VoteSumMismatchFailure extends Failure {
  const VoteSumMismatchFailure({
    super.message = 'La suma de votos no coincide con el total de sufragantes.',
    super.code,
  });
}

// ── Fallos de Permisos del Dispositivo ────────────────────────────────

/// El usuario denegó permisos de cámara/GPS/almacenamiento.
class PermissionFailure extends Failure {
  const PermissionFailure({required super.message, super.code});
}

/// El usuario denegó el permiso de GPS, bloqueando el proceso.
class GpsPermissionFailure extends Failure {
  const GpsPermissionFailure({
    super.message = 'Debe conceder permiso de ubicación para continuar.',
    super.code,
  });
}

// ── Fallos de Imagen ──────────────────────────────────────────────────

/// La imagen capturada está borrosa (varianza Laplaciana baja).
class BlurryImageFailure extends Failure {
  const BlurryImageFailure({
    super.message =
        'Imagen borrosa. Vuelva a tomar la fotografía con mejor iluminación.',
    super.code,
  });
}

// ── Fallos de Autenticación ───────────────────────────────────────────

/// Sesión no encontrada o expirada.
class SessionExpiredFailure extends Failure {
  const SessionExpiredFailure({
    super.message = 'Sesión expirada. Inicie sesión nuevamente.',
    super.code,
  });
}

/// El usuario debe cambiar su contraseña antes de continuar.
class PasswordChangePendingFailure extends Failure {
  const PasswordChangePendingFailure({
    super.message = 'Debes cambiar tu contraseña antes de continuar.',
    super.code,
  });
}
