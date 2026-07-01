/// Casos de uso del módulo Veedor.
library;

import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/acta_entity.dart';
import '../repositories/veedor_repository.dart';

class GetAssignedTablesUseCase {
  const GetAssignedTablesUseCase(this._repository);
  final VeedorRepository _repository;

  Future<Either<Failure, List<MesaElectoralEntity>>> call() =>
      _repository.getAssignedTables();
}

class RegisterActaUseCase {
  const RegisterActaUseCase(this._repository);
  final VeedorRepository _repository;

  Future<Either<Failure, void>> call({
    required String tableId,
    required String tipoDignidad,
    required List<VotoCandidatoEntity> votos,
    required int votosBlancos,
    required int votosNulos,
    required int totalSufragantes,
    required Uint8List photoBytes,
    required double gpsLatitude,
    required double gpsLongitude,
  }) {
    // Validación de negocio adicional antes de guardar
    final sumaCandidatos = votos.fold<int>(0, (sum, v) => sum + v.cantidad);
    final totalCalculado = sumaCandidatos + votosBlancos + votosNulos;

    if (totalCalculado != totalSufragantes) {
      return Future.value(
        const Left(VoteSumMismatchFailure()),
      );
    }

    return _repository.registerActa(
      tableId: tableId,
      tipoDignidad: tipoDignidad,
      votos: votos,
      votosBlancos: votosBlancos,
      votosNulos: votosNulos,
      totalSufragantes: totalSufragantes,
      photoBytes: photoBytes,
      gpsLatitude: gpsLatitude,
      gpsLongitude: gpsLongitude,
    );
  }
}

class CorrectActaUseCase {
  const CorrectActaUseCase(this._repository);
  final VeedorRepository _repository;

  Future<Either<Failure, void>> call(ActaElectoralEntity acta) {
    if (!acta.isSumaValida) {
      return Future.value(
        const Left(VoteSumMismatchFailure()),
      );
    }
    return _repository.correctActa(acta);
  }
}
