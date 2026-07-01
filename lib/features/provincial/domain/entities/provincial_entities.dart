/// Entidades del dominio para el módulo Coordinador Provincial.
library;

import 'package:equatable/equatable.dart';

/// Representa una estadística agrupada por candidato/organización.
class EstadisticaVotosEntity extends Equatable {
  const EstadisticaVotosEntity({
    required this.candidatoNombre,
    required this.organizacionNombre,
    required this.colorHex,
    required this.totalVotos,
    required this.porcentaje,
  });

  final String candidatoNombre;
  final String organizacionNombre;
  final String colorHex;
  final int totalVotos;
  final double porcentaje;

  @override
  List<Object?> get props => [
        candidatoNombre,
        organizacionNombre,
        colorHex,
        totalVotos,
        porcentaje,
      ];
}

/// Representa el resumen global del progreso a nivel provincial.
class ResumenProvincialEntity extends Equatable {
  const ResumenProvincialEntity({
    required this.totalSufragantes,
    required this.actasEscrutadas,
    required this.totalActas,
    required this.estadisticasAlcalde,
    required this.estadisticasPrefecto,
  });

  final int totalSufragantes;
  final int actasEscrutadas;
  final int totalActas;
  
  final List<EstadisticaVotosEntity> estadisticasAlcalde;
  final List<EstadisticaVotosEntity> estadisticasPrefecto;

  double get porcentajeEscrutado =>
      totalActas == 0 ? 0 : (actasEscrutadas / totalActas) * 100;

  @override
  List<Object?> get props => [
        totalSufragantes,
        actasEscrutadas,
        totalActas,
        estadisticasAlcalde,
        estadisticasPrefecto,
      ];
}
