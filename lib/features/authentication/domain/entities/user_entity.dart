/// Entidad de usuario del dominio electoral.
///
/// Inmutable. No depende de Appwrite ni de Drift — es puro Dart.
library;

import 'package:equatable/equatable.dart';

/// Roles disponibles en el sistema.
enum UserRole {
  /// Acceso global: gestiona recintos, coordinadores, dashboard provincial.
  coordinadorProvincial,

  /// Acceso por recinto: gestiona mesas, veedores, actas de su recinto.
  coordinadorRecinto,

  /// Acceso limitado: solo ve y registra actas de sus mesas asignadas.
  veedorMesa,
}

/// Extensión para convertir strings de Appwrite a [UserRole].
extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.coordinadorProvincial:
        return 'coordinador_provincial';
      case UserRole.coordinadorRecinto:
        return 'coordinador_recinto';
      case UserRole.veedorMesa:
        return 'veedor_mesa';
    }
  }

  static UserRole fromString(String value) {
    switch (value) {
      case 'coordinador_provincial':
        return UserRole.coordinadorProvincial;
      case 'coordinador_recinto':
        return UserRole.coordinadorRecinto;
      case 'veedor_mesa':
        return UserRole.veedorMesa;
      default:
        throw ArgumentError('Rol desconocido: $value');
    }
  }

  String get displayName {
    switch (this) {
      case UserRole.coordinadorProvincial:
        return 'Coordinador Provincial';
      case UserRole.coordinadorRecinto:
        return 'Coordinador de Recinto';
      case UserRole.veedorMesa:
        return 'Veedor de Mesa';
    }
  }
}

/// Entidad de usuario del dominio.
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.cedula,
    required this.nombres,
    required this.apellidos,
    required this.telefono,
    required this.correo,
    required this.rol,
    required this.passwordChanged,
    required this.emailVerified,
    this.precinctId,
  });

  final String id;
  final String cedula;
  final String nombres;
  final String apellidos;
  final String telefono;
  final String correo;
  final UserRole rol;

  /// Si el usuario ya cambió la contraseña por defecto (Ecuador2026).
  final bool passwordChanged;

  /// Si el correo fue verificado.
  final bool emailVerified;

  /// ID del recinto (solo para coordinadores de recinto y veedores).
  final String? precinctId;

  /// Nombre completo.
  String get fullName => '$nombres $apellidos';

  /// Si el usuario necesita cambiar contraseña antes de continuar.
  bool get requiresPasswordChange => !passwordChanged;

  @override
  List<Object?> get props => [
        id,
        cedula,
        nombres,
        apellidos,
        telefono,
        correo,
        rol,
        passwordChanged,
        emailVerified,
        precinctId,
      ];

  UserEntity copyWith({
    String? id,
    String? cedula,
    String? nombres,
    String? apellidos,
    String? telefono,
    String? correo,
    UserRole? rol,
    bool? passwordChanged,
    bool? emailVerified,
    String? precinctId,
  }) {
    return UserEntity(
      id: id ?? this.id,
      cedula: cedula ?? this.cedula,
      nombres: nombres ?? this.nombres,
      apellidos: apellidos ?? this.apellidos,
      telefono: telefono ?? this.telefono,
      correo: correo ?? this.correo,
      rol: rol ?? this.rol,
      passwordChanged: passwordChanged ?? this.passwordChanged,
      emailVerified: emailVerified ?? this.emailVerified,
      precinctId: precinctId ?? this.precinctId,
    );
  }
}
