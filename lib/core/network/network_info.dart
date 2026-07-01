/// Información de conectividad de red.
///
/// Abstracción sobre [connectivity_plus] para seguir el
/// Dependency Inversion Principle en Clean Architecture.
library;

import 'package:connectivity_plus/connectivity_plus.dart';

/// Contrato de la capa de dominio para consultar la red.
abstract class NetworkInfo {
  /// Retorna `true` si hay conexión activa.
  Future<bool> get isConnected;

  /// Stream de cambios en la conectividad.
  Stream<bool> get connectivityStream;
}

/// Implementación con [connectivity_plus].
class NetworkInfoImpl implements NetworkInfo {
  const NetworkInfoImpl(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return _hasConnection(results);
  }

  @override
  Stream<bool> get connectivityStream {
    return _connectivity.onConnectivityChanged.map(_hasConnection);
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.isNotEmpty &&
        results.any(
          (r) =>
              r == ConnectivityResult.mobile ||
              r == ConnectivityResult.wifi ||
              r == ConnectivityResult.ethernet,
        );
  }
}
