/// Validadores reutilizables para formularios de la aplicación.
///
/// Se usan en [TextFormField.validator] en las capas de presentación.
/// Nunca contienen lógica de negocio — solo validación de formato.
library;

import '../utils/cedula_validator.dart';

/// Colección de validadores de campos de formulario.
class FormValidators {
  FormValidators._();

  // ── Cédula ─────────────────────────────────────────────────────────────

  /// Valida que el campo no esté vacío y contenga una cédula ecuatoriana válida.
  static String? cedula(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La cédula es requerida.';
    }
    final result = CedulaValidator.validate(value.trim());
    return result.isValid ? null : result.errorMessage;
  }

  // ── Email ──────────────────────────────────────────────────────────────

  /// Valida formato básico de correo electrónico.
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El correo electrónico es requerido.';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Ingrese un correo electrónico válido.';
    }
    return null;
  }

  // ── Teléfono ───────────────────────────────────────────────────────────

  /// Valida que el teléfono sea exactamente 10 dígitos (formato Ecuador).
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El teléfono es requerido.';
    }
    final clean = value.trim().replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (!RegExp(r'^\d{10}$').hasMatch(clean)) {
      return 'Ingrese un teléfono válido de 10 dígitos.';
    }
    return null;
  }

  // ── Contraseña ────────────────────────────────────────────────────────

  /// Valida que la contraseña cumpla requisitos mínimos de seguridad.
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida.';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Debe incluir al menos una letra mayúscula.';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Debe incluir al menos un número.';
    }
    return null;
  }

  /// Valida que la confirmación de contraseña coincida con la original.
  static String? Function(String?) confirmPassword(String password) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Confirme su contraseña.';
      }
      if (value != password) {
        return 'Las contraseñas no coinciden.';
      }
      return null;
    };
  }

  // ── Campos Generales ───────────────────────────────────────────────────

  /// Valida que el campo no esté vacío.
  static String? required(String? value, {String fieldName = 'Este campo'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName es requerido.';
    }
    return null;
  }

  /// Valida que el campo sea un número entero positivo.
  static String? positiveInteger(String? value, {String fieldName = 'El valor'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName es requerido.';
    }
    final parsed = int.tryParse(value.trim());
    if (parsed == null || parsed < 0) {
      return '$fieldName debe ser un número entero positivo.';
    }
    return null;
  }

  /// Valida que el número JRV (Junta Receptora de Votos) tenga formato válido.
  static String? jrvNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El número JRV es requerido.';
    }
    if (!RegExp(r'^\d{1,6}$').hasMatch(value.trim())) {
      return 'El número JRV debe ser un número entre 1 y 999999.';
    }
    return null;
  }

  /// Valida nombres (solo letras, espacios y acentos).
  static String? nombres(String? value, {String fieldName = 'El nombre'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName es requerido.';
    }
    if (!RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s'-]{2,60}$").hasMatch(value.trim())) {
      return '$fieldName solo puede contener letras y espacios.';
    }
    return null;
  }
}
