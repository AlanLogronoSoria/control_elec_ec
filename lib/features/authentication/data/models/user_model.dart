/// Modelo de usuario para la capa de datos.
///
/// Mapea entre Appwrite Documents, Drift rows y la entidad de dominio.
library;

import 'package:drift/drift.dart' show Value;
import '../../domain/entities/user_entity.dart';
import '../../../../core/database/app_database.dart';

/// Modelo de usuario — capa de datos.
class UserModel {
  const UserModel({
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
  final String rol;
  final bool passwordChanged;
  final bool emailVerified;
  final String? precinctId;

  // ── Appwrite ↔ Model ──────────────────────────────────────────────────

  /// Construye un [UserModel] desde un documento Appwrite.
  factory UserModel.fromAppwrite(Map<String, dynamic> data) {
    return UserModel(
      id: data['\$id'] as String,
      cedula: data['cedula'] as String,
      nombres: data['nombres'] as String,
      apellidos: data['apellidos'] as String,
      telefono: data['telefono'] as String,
      correo: data['correo'] as String,
      rol: data['rol'] as String,
      passwordChanged: data['password_changed'] as bool? ?? false,
      emailVerified: data['email_verified'] as bool? ?? false,
      precinctId: data['precinct_id'] as String?,
    );
  }

  /// Convierte el modelo a formato Appwrite (para crear/actualizar documentos).
  Map<String, dynamic> toAppwrite() => {
        'cedula': cedula,
        'nombres': nombres,
        'apellidos': apellidos,
        'telefono': telefono,
        'correo': correo,
        'rol': rol,
        'password_changed': passwordChanged,
        'email_verified': emailVerified,
        if (precinctId != null) 'precinct_id': precinctId,
      };

  // ── Drift ↔ Model ──────────────────────────────────────────────────────

  /// Construye un [UserModel] desde una fila de Drift.
  factory UserModel.fromDrift(UsersTableData row) {
    return UserModel(
      id: row.id,
      cedula: row.cedula,
      nombres: row.nombres,
      apellidos: row.apellidos,
      telefono: row.telefono,
      correo: row.correo,
      rol: row.rol,
      passwordChanged: row.passwordChanged,
      emailVerified: row.emailVerified,
      precinctId: row.precinctId,
    );
  }

  /// Convierte el modelo a un companion de Drift para inserción/actualización.
  UsersTableCompanion toDriftCompanion() {
    return UsersTableCompanion.insert(
      id: id,
      cedula: cedula,
      nombres: nombres,
      apellidos: apellidos,
      telefono: telefono,
      correo: correo,
      rol: rol,
      passwordChanged: drift_value(passwordChanged),
      emailVerified: drift_value(emailVerified),
      precinctId: drift_nullable(precinctId),
    );
  }

  // ── Model ↔ Entity ────────────────────────────────────────────────────

  /// Convierte a la entidad de dominio.
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      cedula: cedula,
      nombres: nombres,
      apellidos: apellidos,
      telefono: telefono,
      correo: correo,
      rol: UserRoleExtension.fromString(rol),
      passwordChanged: passwordChanged,
      emailVerified: emailVerified,
      precinctId: precinctId,
    );
  }

  /// Construye desde entidad de dominio.
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      cedula: entity.cedula,
      nombres: entity.nombres,
      apellidos: entity.apellidos,
      telefono: entity.telefono,
      correo: entity.correo,
      rol: entity.rol.value,
      passwordChanged: entity.passwordChanged,
      emailVerified: entity.emailVerified,
      precinctId: entity.precinctId,
    );
  }
}



Value<T> drift_value<T>(T v) => Value(v);
Value<T?> drift_nullable<T>(T? v) => Value(v);
