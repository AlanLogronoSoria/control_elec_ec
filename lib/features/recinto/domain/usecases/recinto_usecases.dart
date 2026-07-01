/// Casos de uso del módulo Coordinador de Recinto.
library;

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/recinto_entities.dart';
import '../repositories/recinto_repository.dart';

class GetRecintoProgressUseCase {
  const GetRecintoProgressUseCase(this._repository);
  final RecintoRepository _repository;

  Future<Either<Failure, RecintoProgressEntity>> call() =>
      _repository.getProgress();
}

class GetVeedoresUseCase {
  const GetVeedoresUseCase(this._repository);
  final RecintoRepository _repository;

  Future<Either<Failure, List<VeedorAsignadoEntity>>> call() =>
      _repository.getVeedores();
}

class AssignTableUseCase {
  const AssignTableUseCase(this._repository);
  final RecintoRepository _repository;

  Future<Either<Failure, void>> call({
    required String tableId,
    required String veedorId,
  }) =>
      _repository.assignTableToVeedor(tableId: tableId, veedorId: veedorId);
}
