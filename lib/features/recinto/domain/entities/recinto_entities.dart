/// Entidades para el módulo del Coordinador de Recinto.
library;

import 'package:equatable/equatable.dart';
import '../../../authentication/domain/entities/user_entity.dart';

/// Representa el progreso general de un recinto.
class RecintoProgressEntity extends Equatable {
  const RecintoProgressEntity({
    required this.precinctId,
    required this.precinctName,
    required this.totalMesas,
    required this.mesasCompletadas,
    required this.mesasEnProgreso,
    required this.mesasPendientes,
  });

  final String precinctId;
  final String precinctName;
  final int totalMesas;
  final int mesasCompletadas;
  final int mesasEnProgreso;
  final int mesasPendientes;

  double get porcentajeCompletado =>
      totalMesas == 0 ? 0 : (mesasCompletadas / totalMesas) * 100;

  @override
  List<Object?> get props => [
        precinctId,
        precinctName,
        totalMesas,
        mesasCompletadas,
        mesasEnProgreso,
        mesasPendientes,
      ];
}

/// Representa un Veedor bajo el cargo de este coordinador.
class VeedorAsignadoEntity extends Equatable {
  const VeedorAsignadoEntity({
    required this.user,
    required this.mesasAsignadas,
  });

  final UserEntity user;
  
  /// Lista de números de JRV asignadas a este veedor.
  final List<int> mesasAsignadas;

  @override
  List<Object?> get props => [user, mesasAsignadas];
}
