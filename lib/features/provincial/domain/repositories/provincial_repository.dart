/// Contrato del repositorio para el módulo de Coordinador Provincial.
library;

import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/provincial_entities.dart';

abstract class ProvincialRepository {
  /// Obtiene un resumen consolidado a nivel provincial de todas las actas escrutadas.
  Future<Either<Failure, ResumenProvincialEntity>> getResumenGlobal();

  /// Observa el resumen global en tiempo real (útil para actualizaciones offline locales).
  Stream<ResumenProvincialEntity> watchResumenGlobal();

  /// Asigna un coordinador de recinto a un recinto electoral.
  Future<Either<Failure, void>> assignCoordinatorToPrecinct({
    required String precinctId,
    required String coordinatorId,
  });

  /// Obtiene el avance de escrutinio desglosado por recinto electoral.
  Future<Either<Failure, List<AvanceRecintoEntity>>> getAvancePorRecinto();

  /// Obtiene el detalle completo de un acta (solo lectura).
  Future<Either<Failure, ProvincialActaDetailEntity>> getActaDetail(
      String actId);

  /// Crea un recinto electoral con sus mesas JRV automáticas.
  Future<Either<Failure, void>> createPrecinct({
    required String provincia,
    required String canton,
    required String parroquia,
    required String nombreRecinto,
    required int numeroJrv,
  });

  /// Obtiene todos los recintos electorales registrados.
  Future<Either<Failure, List<AvanceRecintoEntity>>> getAllPrecincts();

  /// Obtiene los usuarios con rol coordinador de recinto.
  Future<Either<Failure, List<PrecinctCoordinatorEntity>>>
      getCoordinadoresRecinto();
}

/// Información resumida de un coordinador de recinto para asignación.
class PrecinctCoordinatorEntity extends Equatable {
  const PrecinctCoordinatorEntity({
    required this.id,
    required this.cedula,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    this.precinctId,
  });

  final String id;
  final String cedula;
  final String nombres;
  final String apellidos;
  final String correo;
  final String? precinctId;

  @override
  List<Object?> get props => [id, cedula, nombres, apellidos, correo, precinctId];
}
