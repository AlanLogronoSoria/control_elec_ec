/// Contrato del repositorio para el módulo de Coordinador Provincial.
library;

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
}
