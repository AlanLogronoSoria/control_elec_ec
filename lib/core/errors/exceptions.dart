/// Excepciones de infraestructura que se convierten en [Failure] en
/// los repositorios. La capa de dominio nunca ve estas excepciones.
library;

/// Excepción de servidor (Appwrite, HTTP, etc.).
class ServerException implements Exception {
  const ServerException({this.message = 'Error de servidor.', this.code});
  final String message;
  final int? code;

  @override
  String toString() => 'ServerException(code: $code, message: $message)';
}

/// Excepción de base de datos local (Drift/SQLite).
class CacheException implements Exception {
  const CacheException({this.message = 'Error en base de datos local.'});
  final String message;

  @override
  String toString() => 'CacheException($message)';
}

/// Excepción de red (sin conectividad).
class NetworkException implements Exception {
  const NetworkException({this.message = 'Sin conexión a internet.'});
  final String message;

  @override
  String toString() => 'NetworkException($message)';
}

/// Excepción de autenticación (sesión inválida o expirada).
class AuthException implements Exception {
  const AuthException({this.message = 'Error de autenticación.', this.code});
  final String message;
  final int? code;

  @override
  String toString() => 'AuthException(code: $code, message: $message)';
}

/// Excepción de validación de datos de entrada.
class ValidationException implements Exception {
  const ValidationException({required this.message});
  final String message;

  @override
  String toString() => 'ValidationException($message)';
}

/// Excepción al detectar imagen borrosa.
class BlurryImageException implements Exception {
  const BlurryImageException();

  @override
  String toString() => 'BlurryImageException: La imagen está borrosa.';
}

/// Excepción cuando el permiso GPS fue denegado.
class GpsPermissionException implements Exception {
  const GpsPermissionException({this.permanent = false});
  final bool permanent;

  @override
  String toString() =>
      'GpsPermissionException(permanent: $permanent)';
}
