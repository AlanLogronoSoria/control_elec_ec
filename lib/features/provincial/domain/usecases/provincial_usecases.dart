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

class GetAvancePorRecintoUseCase {
  const GetAvancePorRecintoUseCase(this._repository);
  final ProvincialRepository _repository;

  Future<Either<Failure, List<AvanceRecintoEntity>>> call() =>
      _repository.getAvancePorRecinto();
}

class GetActaDetailUseCase {
  const GetActaDetailUseCase(this._repository);
  final ProvincialRepository _repository;

  Future<Either<Failure, ProvincialActaDetailEntity>> call(String actId) =>
      _repository.getActaDetail(actId);
}

class CreatePrecinctUseCase {
  const CreatePrecinctUseCase(this._repository);
  final ProvincialRepository _repository;

  Future<Either<Failure, void>> call({
    required String provincia,
    required String canton,
    required String parroquia,
    required String nombreRecinto,
    required int numeroJrv,
  }) =>
      _repository.createPrecinct(
        provincia: provincia,
        canton: canton,
        parroquia: parroquia,
        nombreRecinto: nombreRecinto,
        numeroJrv: numeroJrv,
      );
}

class GetAllPrecinctsUseCase {
  const GetAllPrecinctsUseCase(this._repository);
  final ProvincialRepository _repository;

  Future<Either<Failure, List<AvanceRecintoEntity>>> call() =>
      _repository.getAllPrecincts();
}

class GetCoordinadoresRecintoUseCase {
  const GetCoordinadoresRecintoUseCase(this._repository);
  final ProvincialRepository _repository;

  Future<Either<Failure, List<PrecinctCoordinatorEntity>>> call() =>
      _repository.getCoordinadoresRecinto();
}
