/// Contrato del repositorio para el módulo del Veedor.
library;

import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/acta_entity.dart';

/// Interfaz del repositorio de operaciones de un Veedor.
abstract class VeedorRepository {
  /// Obtiene las mesas (JRV) asignadas al veedor actual.
  Future<Either<Failure, List<MesaElectoralEntity>>> getAssignedTables();

  /// Observa las mesas asignadas en tiempo real.
  Stream<List<MesaElectoralEntity>> watchAssignedTables();

  /// Obtiene el formulario (candidatos y organizaciones) para una dignidad.
  Future<Either<Failure, List<OrganizacionFormEntity>>> getFormularioForDignidad(String dignidad);

  /// Registra una nueva acta electoral de forma local y la encola para sincronización.
  /// 
  /// [tableId]: ID de la mesa.
  /// [tipoDignidad]: 'alcalde' | 'prefecto'.
  /// [votos]: Lista de votos por candidato.
  /// [votosBlancos]: Cantidad de votos en blanco.
  /// [votosNulos]: Cantidad de votos nulos.
  /// [totalSufragantes]: Total de personas que sufragaron.
  /// [photoBytes]: Imagen original capturada.
  /// [gpsLatitude]: Latitud capturada.
  /// [gpsLongitude]: Longitud capturada.
  Future<Either<Failure, void>> registerActa({
    required String tableId,
    required String tipoDignidad,
    required List<VotoCandidatoEntity> votos,
    required int votosBlancos,
    required int votosNulos,
    required int totalSufragantes,
    required Uint8List photoBytes,
    required double gpsLatitude,
    required double gpsLongitude,
  });

  /// Analiza una imagen para determinar si está borrosa usando el Laplacian.
  Future<Either<Failure, bool>> isImageBlurry(Uint8List imageBytes);
  
  /// Actualiza un acta existente. Acepta opcionalmente nuevos bytes de foto
  /// para reemplazar la fotografía del acta (con blur detection previo).
  Future<Either<Failure, void>> correctActa(ActaElectoralEntity acta,
      {Uint8List? photoBytes});
  
  /// Obtiene un acta específica si ya fue registrada.
  Future<Either<Failure, ActaElectoralEntity?>> getActa(String tableId, String dignidad);

  /// Obtiene los votos extra de un acta para corrección.
  Future<Either<Failure, Map<String, dynamic>>> getActVotesData(String actId);
}
