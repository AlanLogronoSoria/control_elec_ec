/// Entidades del dominio para el módulo del Veedor.
library;

import 'package:equatable/equatable.dart';

/// Representa una mesa electoral (JRV) asignada a un veedor.
class MesaElectoralEntity extends Equatable {
  const MesaElectoralEntity({
    required this.id,
    required this.jrvNumber,
    required this.precinctName,
    required this.parroquia,
    required this.estadoActa,
  });

  final String id;
  final int jrvNumber;
  final String precinctName;
  final String parroquia;
  
  /// 'pendiente' | 'en_progreso' | 'completado'
  final String estadoActa;

  @override
  List<Object?> get props => [id, jrvNumber, precinctName, parroquia, estadoActa];
}

/// Representa un acta electoral (una por dignidad por mesa).
class ActaElectoralEntity extends Equatable {
  const ActaElectoralEntity({
    required this.id,
    required this.tableId,
    required this.tipoDignidad, // 'alcalde' | 'prefecto'
    required this.votos,
    required this.votosBlancos,
    required this.votosNulos,
    required this.totalSufragantes,
    this.photoUrl,
    this.localPhotoPath,
    this.gpsLatitude,
    this.gpsLongitude,
  });

  final String id;
  final String tableId;
  final String tipoDignidad;
  final List<VotoCandidatoEntity> votos;
  final int votosBlancos;
  final int votosNulos;
  final int totalSufragantes;
  
  final String? photoUrl;
  final String? localPhotoPath;
  final double? gpsLatitude;
  final double? gpsLongitude;

  /// Valida si la suma de los votos coincide con el total de sufragantes.
  bool get isSumaValida {
    final sumaCandidatos = votos.fold<int>(0, (sum, v) => sum + v.cantidad);
    return (sumaCandidatos + votosBlancos + votosNulos) == totalSufragantes;
  }

  @override
  List<Object?> get props => [
        id,
        tableId,
        tipoDignidad,
        votos,
        votosBlancos,
        votosNulos,
        totalSufragantes,
        photoUrl,
        localPhotoPath,
        gpsLatitude,
        gpsLongitude,
      ];
}

/// Representa los votos obtenidos por un candidato/organización.
class VotoCandidatoEntity extends Equatable {
  const VotoCandidatoEntity({
    required this.candidateId,
    required this.candidateName,
    required this.organizationName,
    required this.cantidad,
  });

  final String candidateId;
  final String candidateName;
  final String organizationName;
  final int cantidad;

  @override
  List<Object?> get props => [candidateId, candidateName, organizationName, cantidad];
}

/// Organización política para los formularios.
class OrganizacionFormEntity extends Equatable {
  const OrganizacionFormEntity({
    required this.organizationId,
    required this.organizationName,
    required this.candidateId,
    required this.candidateName,
    required this.colorHex,
  });

  final String organizationId;
  final String organizationName;
  final String candidateId;
  final String candidateName;
  final String colorHex;

  @override
  List<Object?> get props => [
        organizationId,
        organizationName,
        candidateId,
        candidateName,
        colorHex,
      ];
}
