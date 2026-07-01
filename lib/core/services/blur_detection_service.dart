/// Servicio de detección de nitidez de imágenes.
///
/// Implementa el algoritmo **Variance of Laplacian** en Dart puro
/// usando el paquete `image`. No requiere dependencias nativas.
///
/// Referencia académica:
/// "Blur Detection for Digital Images Using the Laplacian Operator"
/// Pech-Pacheco et al., 2000
library;

import 'dart:typed_data';
import 'package:image/image.dart' as img;
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

/// Resultado del análisis de nitidez de una imagen.
class BlurDetectionResult {
  const BlurDetectionResult({
    required this.isBlurry,
    required this.variance,
    required this.threshold,
  });

  /// Si la imagen se considera borrosa.
  final bool isBlurry;

  /// Varianza calculada del Laplaciano.
  final double variance;

  /// Umbral usado para la decisión.
  final double threshold;

  @override
  String toString() =>
      'BlurDetectionResult(isBlurry: $isBlurry, variance: ${variance.toStringAsFixed(2)}, threshold: $threshold)';
}

/// Servicio de detección de blur usando Variance of Laplacian.
class BlurDetectionService {
  BlurDetectionService._();

  static final BlurDetectionService _instance = BlurDetectionService._();

  /// Instancia singleton.
  static BlurDetectionService get instance => _instance;

  // ── Kernel Laplaciano 3x3 ──────────────────────────────────────────────
  // | 0  1  0 |
  // | 1 -4  1 |
  // | 0  1  0 |
  static const List<List<int>> _laplacianKernel = [
    [0, 1, 0],
    [1, -4, 1],
    [0, 1, 0],
  ];

  /// Analiza la nitidez de una imagen.
  ///
  /// [imageBytes] - bytes de la imagen (JPEG, PNG, etc.)
  /// [threshold] - umbral de varianza (default: AppConstants.blurVarianceThreshold)
  ///
  /// Retorna [BlurDetectionResult] con el análisis.
  ///
  /// Lanza [BlurryImageException] si la imagen está borrosa.
  Future<BlurDetectionResult> analyze(
    Uint8List imageBytes, {
    double threshold = AppConstants.blurVarianceThreshold,
  }) async {
    // 1. Decodificar la imagen
    final image = img.decodeImage(imageBytes);
    if (image == null) {
      throw const CacheException(message: 'No se pudo decodificar la imagen.');
    }

    // 2. Convertir a escala de grises
    final grayscale = img.grayscale(image);

    // 3. Aplicar el operador Laplaciano manualmente (sin FFI)
    final laplacianValues = _applyLaplacian(grayscale);

    // 4. Calcular la varianza de los valores Laplacianos
    final variance = _calculateVariance(laplacianValues);

    // 5. Comparar con el umbral
    final isBlurry = variance < threshold;

    return BlurDetectionResult(
      isBlurry: isBlurry,
      variance: variance,
      threshold: threshold,
    );
  }

  /// Aplica el kernel Laplaciano a la imagen en escala de grises.
  /// Retorna una lista de valores absolutos del resultado de la convolución.
  List<double> _applyLaplacian(img.Image grayscale) {
    final width = grayscale.width;
    final height = grayscale.height;
    final result = <double>[];

    // Recorrer los píxeles (excluyendo el borde de 1 píxel)
    for (int y = 1; y < height - 1; y++) {
      for (int x = 1; x < width - 1; x++) {
        double sum = 0;

        // Convolución con el kernel 3x3
        for (int ky = -1; ky <= 1; ky++) {
          for (int kx = -1; kx <= 1; kx++) {
            final pixel = grayscale.getPixel(x + kx, y + ky);
            // En escala de grises, los canales R=G=B, usamos el luminance
            final grayValue = img.getLuminance(pixel);
            final kernelValue = _laplacianKernel[ky + 1][kx + 1];
            sum += grayValue * kernelValue;
          }
        }

        result.add(sum.abs());
      }
    }

    return result;
  }

  /// Calcula la varianza de una lista de valores.
  double _calculateVariance(List<double> values) {
    if (values.isEmpty) return 0.0;

    // Media
    final mean = values.reduce((a, b) => a + b) / values.length;

    // Varianza = promedio de (valor - media)^2
    final variance = values
            .map((v) => (v - mean) * (v - mean))
            .reduce((a, b) => a + b) /
        values.length;

    return variance;
  }

  /// Método de conveniencia: retorna `true` si la imagen está borrosa.
  Future<bool> isBlurry(
    Uint8List imageBytes, {
    double? threshold,
  }) async {
    final result = await analyze(
      imageBytes,
      threshold: threshold ?? AppConstants.blurVarianceThreshold,
    );
    return result.isBlurry;
  }
}
