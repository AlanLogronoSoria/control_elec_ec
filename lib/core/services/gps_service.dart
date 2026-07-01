/// Servicio GPS que encapsula geolocator y manejo de permisos.
///
/// Responsabilidades:
/// - Verificar y solicitar permisos de ubicación
/// - Obtener posición actual con timeout
/// - Bloquear el proceso si el permiso es denegado
library;

import 'package:geolocator/geolocator.dart';
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

/// Resultado de captura GPS.
class GpsPosition {
  const GpsPosition({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.timestamp,
  });

  final double latitude;
  final double longitude;

  /// Precisión en metros.
  final double accuracy;

  final DateTime timestamp;

  @override
  String toString() =>
      'GpsPosition(lat: $latitude, lon: $longitude, accuracy: ${accuracy.toStringAsFixed(1)}m)';
}

/// Servicio de captura GPS con manejo de permisos.
class GpsService {
  GpsService._();

  static final GpsService _instance = GpsService._();

  /// Instancia singleton.
  static GpsService get instance => _instance;

  /// Verifica el estado actual de los permisos de ubicación.
  /// No solicita permiso — solo consulta el estado.
  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  /// Verifica y solicita permisos de ubicación si es necesario.
  ///
  /// Lanza [GpsPermissionException] si:
  /// - El usuario deniega el permiso
  /// - El permiso está denegado permanentemente
  /// - Los servicios de ubicación están desactivados
  Future<void> requestPermission() async {
    // Verificar si los servicios de ubicación están habilitados
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const GpsPermissionException(permanent: false);
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const GpsPermissionException(permanent: false);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const GpsPermissionException(permanent: true);
    }
  }

  /// Obtiene la posición GPS actual.
  ///
  /// Primero verifica y solicita permisos si es necesario.
  ///
  /// Lanza [GpsPermissionException] si el permiso fue denegado.
  /// Lanza [ServerException] si no se puede obtener la posición.
  Future<GpsPosition> getCurrentPosition() async {
    await requestPermission();

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: AppConstants.gpsTimeout,
        ),
      );

      return GpsPosition(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        timestamp: position.timestamp,
      );
    } on LocationServiceDisabledException {
      throw const GpsPermissionException(permanent: false);
    } catch (e) {
      throw ServerException(
        message: 'No se pudo obtener la posición GPS: ${e.toString()}',
      );
    }
  }

  /// Retorna `true` si los permisos de ubicación están concedidos.
  Future<bool> hasPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// Abre la configuración del dispositivo para que el usuario
  /// pueda habilitar los permisos manualmente.
  Future<bool> openSettings() => Geolocator.openLocationSettings();
}
