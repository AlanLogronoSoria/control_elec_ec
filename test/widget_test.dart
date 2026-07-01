import 'package:flutter_test/flutter_test.dart';
import 'package:control_electoral_ec/core/utils/cedula_validator.dart';

void main() {
  group('Cédula Validator', () {
    test('debe rechazar cédulas vacías', () {
      final result = CedulaValidator.validate('');
      expect(result.isValid, false);
    });

    test('debe rechazar cédulas con letras', () {
      final result = CedulaValidator.validate('12345678AB');
      expect(result.isValid, false);
    });

    test('debe rechazar cédulas con longitud incorrecta', () {
      final result = CedulaValidator.validate('123456789');
      expect(result.isValid, false);
    });

    test('debe rechazar código de provincia inválido', () {
      final result = CedulaValidator.validate('9912345678');
      expect(result.isValid, false);
    });

    test('debe validar una cédula real correcta', () {
      // Cédula de prueba con algoritmo módulo 10 válido
      final result = CedulaValidator.validate('1710034065');
      expect(result.isValid, true);
    });
  });
}
