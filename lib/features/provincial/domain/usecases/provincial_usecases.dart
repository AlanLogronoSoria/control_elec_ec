/// Casos de uso para el Coordinador Provincial.
library;

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/provincial_entities.dart';
import '../repositories/provincial_repository.dart';

class GetResumenGlobalUseCase {
  const GetResumenGlobalUseCase(this._repository);
  final ProvincialRepository _repository;

  Future<Either<Failure, ResumenProvincialEntity>> call() =>
      _repository.getResumenGlobal();
}

class AssignCoordinatorToPrecinctUseCase {
  const AssignCoordinatorToPrecinctUseCase(this._repository);
  final ProvincialRepository _repository;

  Future<Either<Failure, void>> call({
    required String precinctId,
    required String coordinatorId,
  }) =>
      _repository.assignCoordinatorToPrecinct(
        precinctId: precinctId,
        coordinatorId: coordinatorId,
      );
}
