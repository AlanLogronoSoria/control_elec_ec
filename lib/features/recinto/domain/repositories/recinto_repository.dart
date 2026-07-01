/// Contrato del repositorio para el módulo de Coordinador de Recinto.
library;

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/recinto_entities.dart';

abstract class RecintoRepository {
  /// Obtiene el progreso general de escrutinio del recinto asignado al coordinador.
  Future<Either<Failure, RecintoProgressEntity>> getProgress();

  /// Observa el progreso en tiempo real (para actualizaciones locales de Drift).
  Stream<RecintoProgressEntity> watchProgress();

  /// Obtiene la lista de veedores registrados en este recinto.
  Future<Either<Failure, List<VeedorAsignadoEntity>>> getVeedores();

  /// Asigna una mesa (JRV) a un veedor.
  Future<Either<Failure, void>> assignTableToVeedor({
    required String tableId,
    required String veedorId,
  });

  /// Remueve la asignación de una mesa a un veedor.
  Future<Either<Failure, void>> unassignTable({
    required String tableId,
  });
}
