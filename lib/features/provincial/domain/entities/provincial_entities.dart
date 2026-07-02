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

/// Avance de escrutinio por recinto electoral.
class AvanceRecintoEntity extends Equatable {
  const AvanceRecintoEntity({
    required this.precinctId,
    required this.precinctName,
    required this.provincia,
    required this.canton,
    required this.parroquia,
    required this.totalMesas,
    required this.mesasCompletadas,
    required this.mesasPendientes,
    required this.porcentajeCompletado,
    required this.votosAlcalde,
    required this.votosPrefecto,
  });

  final String precinctId;
  final String precinctName;
  final String provincia;
  final String canton;
  final String parroquia;
  final int totalMesas;
  final int mesasCompletadas;
  final int mesasPendientes;
  final double porcentajeCompletado;
  final int votosAlcalde;
  final int votosPrefecto;

  @override
  List<Object?> get props => [
        precinctId,
        precinctName,
        provincia,
        canton,
        parroquia,
        totalMesas,
        mesasCompletadas,
        mesasPendientes,
        porcentajeCompletado,
        votosAlcalde,
        votosPrefecto,
      ];
}

/// Detalle completo de un acta electoral para consulta readonly.
class ProvincialActaDetailEntity extends Equatable {
  const ProvincialActaDetailEntity({
    required this.actId,
    required this.tipoDignidad,
    required this.estado,
    required this.mesaJrv,
    required this.precinctName,
    required this.votos,
    required this.votosBlancos,
    required this.votosNulos,
    required this.totalSufragantes,
    this.photoUrl,
    this.localPhotoPath,
    this.gpsLatitude,
    this.gpsLongitude,
    required this.createdAt,
    required this.updatedAt,
    this.veedorNombre,
    this.veedorCedula,
  });

  final String actId;
  final String tipoDignidad;
  final String estado;
  final int mesaJrv;
  final String precinctName;
  final List<VotoCandidatoDetalleEntity> votos;
  final int votosBlancos;
  final int votosNulos;
  final int totalSufragantes;
  final String? photoUrl;
  final String? localPhotoPath;
  final double? gpsLatitude;
  final double? gpsLongitude;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? veedorNombre;
  final String? veedorCedula;

  bool get sumatoriaValida =>
      (votos.fold<int>(0, (s, v) => s + v.cantidad) +
              votosBlancos +
              votosNulos) ==
          totalSufragantes;

  @override
  List<Object?> get props => [
        actId,
        tipoDignidad,
        estado,
        mesaJrv,
        precinctName,
        votos,
        votosBlancos,
        votosNulos,
        totalSufragantes,
        photoUrl,
        localPhotoPath,
        gpsLatitude,
        gpsLongitude,
        createdAt,
        updatedAt,
        veedorNombre,
        veedorCedula,
      ];
}

/// Votos de un candidato en el detalle de acta.
class VotoCandidatoDetalleEntity extends Equatable {
  const VotoCandidatoDetalleEntity({
    required this.candidateName,
    required this.organizationName,
    required this.colorHex,
    required this.cantidad,
  });

  final String candidateName;
  final String organizationName;
  final String colorHex;
  final int cantidad;

  @override
  List<Object?> get props => [candidateName, organizationName, colorHex, cantidad];
}
