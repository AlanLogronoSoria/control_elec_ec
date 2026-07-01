/// Validador oficial de cédula de identidad ecuatoriana.
///
/// Implementa el algoritmo del Módulo 10 usado por el
/// Registro Civil e Identificación del Ecuador.
///
/// Referencias:
/// - https://www.registrocivil.gob.ec/
/// - Algoritmo estándar de verificación de cédula ecuatoriana
library;

/// Resultado de la validación de cédula.
class CedulaValidationResult {
  const CedulaValidationResult({
    required this.isValid,
    this.errorMessage,
    this.provinceCode,
  });

  /// Si la cédula es válida.
  final bool isValid;

  /// Mensaje de error en caso de cédula inválida.
  final String? errorMessage;

  /// Código de provincia extraído (01-24).
  final String? provinceCode;
}

/// Validador de cédula ecuatoriana.
class CedulaValidator {
  CedulaValidator._();

  /// Valida una cédula de identidad ecuatoriana.
  ///
  /// [cedula] debe ser una cadena de 10 dígitos numéricos.
  ///
  /// Retorna [CedulaValidationResult] con el resultado de la validación.
  static CedulaValidationResult validate(String cedula) {
    // 1. Limpiar espacios
    final cleanCedula = cedula.trim().replaceAll(RegExp(r'\s+'), '');

    // 2. Verificar longitud
    if (cleanCedula.length != 10) {
      return const CedulaValidationResult(
        isValid: false,
        errorMessage: 'La cédula debe tener exactamente 10 dígitos.',
      );
    }

    // 3. Verificar que sean solo dígitos
    if (!RegExp(r'^\d{10}$').hasMatch(cleanCedula)) {
      return const CedulaValidationResult(
        isValid: false,
        errorMessage: 'La cédula solo puede contener dígitos.',
      );
    }

    // 4. Extraer y validar código de provincia (primeros 2 dígitos: 01-24)
    final provinceCode = cleanCedula.substring(0, 2);
    final province = int.parse(provinceCode);
    if (province < 1 || province > 24) {
      return const CedulaValidationResult(
        isValid: false,
        errorMessage: 'Código de provincia inválido (debe ser entre 01 y 24).',
      );
    }

    // 5. El tercer dígito debe ser entre 0 y 5 (persona natural)
    final thirdDigit = int.parse(cleanCedula[2]);
    if (thirdDigit > 5) {
      return const CedulaValidationResult(
        isValid: false,
        errorMessage: 'Tercer dígito inválido para persona natural.',
      );
    }

    // 6. Algoritmo Módulo 10
    // Los primeros 9 dígitos se procesan:
    // - Dígitos en posición par (índice 0,2,4,6,8) se multiplican por 2
    // - Dígitos en posición impar (índice 1,3,5,7) se multiplican por 1
    // - Si el producto > 9, se resta 9
    // - Se suman todos los resultados
    // - El dígito verificador = (10 - (suma % 10)) % 10
    // - Debe coincidir con el décimo dígito (índice 9)

    int sum = 0;
    for (int i = 0; i < 9; i++) {
      int digit = int.parse(cleanCedula[i]);
      if (i % 2 == 0) {
        // Posición par: multiplicar por 2
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
    }

    final verifierCalculated = (10 - (sum % 10)) % 10;
    final verifierActual = int.parse(cleanCedula[9]);

    if (verifierCalculated != verifierActual) {
      return const CedulaValidationResult(
        isValid: false,
        errorMessage: 'Cédula ecuatoriana inválida. Dígito verificador incorrecto.',
      );
    }

    return CedulaValidationResult(
      isValid: true,
      provinceCode: provinceCode,
    );
  }

  /// Retorna `true` si la cédula es válida, `false` si no.
  /// Método de conveniencia para uso en formularios.
  static bool isValid(String cedula) => validate(cedula).isValid;

  /// Retorna el mensaje de error, o null si la cédula es válida.
  static String? errorMessage(String cedula) => validate(cedula).errorMessage;
}
