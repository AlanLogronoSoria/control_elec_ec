/// DAO de usuarios — operaciones CRUD sobre la tabla de usuarios locales.
library;

import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/users_table.dart';

part 'users_dao.g.dart';

@DriftAccessor(tables: [UsersTable])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  UsersDao(super.db);

  // ── Consultas ─────────────────────────────────────────────────────────

  /// Obtiene todos los usuarios.
  Future<List<UsersTableData>> getAllUsers() => select(usersTable).get();

  /// Observa la lista de usuarios en tiempo real.
  Stream<List<UsersTableData>> watchAllUsers() => select(usersTable).watch();

  /// Busca un usuario por ID.
  Future<UsersTableData?> getUserById(String id) =>
      (select(usersTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  /// Busca un usuario por cédula.
  Future<UsersTableData?> getUserByCedula(String cedula) =>
      (select(usersTable)..where((t) => t.cedula.equals(cedula)))
          .getSingleOrNull();

  /// Obtiene usuarios por rol.
  Future<List<UsersTableData>> getUsersByRole(String rol) =>
      (select(usersTable)..where((t) => t.rol.equals(rol))).get();

  /// Obtiene usuarios de un recinto específico.
  Future<List<UsersTableData>> getUsersByPrecinct(String precinctId) =>
      (select(usersTable)
            ..where((t) => t.precinctId.equals(precinctId)))
          .get();

  // ── Escritura ─────────────────────────────────────────────────────────

  /// Inserta o actualiza un usuario (upsert).
  Future<void> upsertUser(UsersTableCompanion user) =>
      into(usersTable).insertOnConflictUpdate(user);

  /// Actualiza los flags de cambio de contraseña y verificación de email.
  Future<void> updateAuthFlags({
    required String userId,
    bool? passwordChanged,
    bool? emailVerified,
  }) async {
    await (update(usersTable)..where((t) => t.id.equals(userId))).write(
      UsersTableCompanion(
        passwordChanged: passwordChanged != null
            ? Value(passwordChanged)
            : const Value.absent(),
        emailVerified:
            emailVerified != null ? Value(emailVerified) : const Value.absent(),
      ),
    );
  }

  /// Elimina un usuario por ID.
  Future<int> deleteUser(String id) =>
      (delete(usersTable)..where((t) => t.id.equals(id))).go();
}
