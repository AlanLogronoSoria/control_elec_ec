/// Implementación del repositorio de autenticación.
///
/// Orquesta entre la fuente de datos remota (Appwrite) y la local (Drift).
/// La capa de presentación nunca ve Appwrite ni Drift — solo [AuthRepository].
library;

import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/services/appwrite_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

/// Claves de almacenamiento seguro.
const _kCurrentUserId = 'current_user_id';
const _kSessionId = 'session_id';

/// Implementación concreta del repositorio de autenticación.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AppDatabase database,
    required NetworkInfo networkInfo,
    required FlutterSecureStorage secureStorage,
  })  : _db = database,
        _networkInfo = networkInfo,
        _secureStorage = secureStorage,
        _logger = Logger();

  final AppDatabase _db;
  final NetworkInfo _networkInfo;
  final FlutterSecureStorage _secureStorage;
  final Logger _logger;

  final _appwrite = AppwriteService.instance;
  final _uuid = const Uuid();

  @override
  Future<Either<Failure, UserEntity>> login({
    required String cedula,
    required String password,
  }) async {
    try {
      // 1. Buscar email real del usuario por cédula
      final userDoc = await _appwrite.databases.listDocuments(
        databaseId: AppConstants.appwriteDatabaseId,
        collectionId: AppConstants.colUsers,
        queries: [Query.equal('cedula', cedula)],
      );

      if (userDoc.documents.isEmpty) {
        throw const AuthException(
          message: 'Usuario no encontrado en el sistema.',
          code: 404,
        );
      }

      final userModel = UserModel.fromAppwrite(userDoc.documents.first.data);

      // 2. Iniciar sesión con el email real del usuario
      final session = await _appwrite.account.createEmailPasswordSession(
        email: userModel.correo,
        password: password,
      );

      // 3. Guardar en caché local (Drift)
      await _db.usersDao.upsertUser(
        UsersTableCompanion.insert(
          id: userModel.id,
          cedula: userModel.cedula,
          nombres: userModel.nombres,
          apellidos: userModel.apellidos,
          telefono: userModel.telefono,
          correo: userModel.correo,
          rol: userModel.rol,
          passwordChanged: Value(userModel.passwordChanged),
          emailVerified: Value(userModel.emailVerified),
          precinctId: Value(userModel.precinctId),
        ),
      );

      // 4. Guardar ID de usuario en almacenamiento seguro
      await _secureStorage.write(key: _kCurrentUserId, value: userModel.id);
      await _secureStorage.write(key: _kSessionId, value: session.$id);

      _logger.i('[AuthRepo] Login exitoso: ${userModel.cedula}');
      return Right(userModel.toEntity());
    } on AppwriteException catch (e) {
      _logger.w('[AuthRepo] Login fallido: ${e.message}');
      if (e.code == 401) {
        return const Left(
          ServerFailure(message: 'Cédula o contraseña incorrectos.', code: 401),
        );
      }
      return Left(ServerFailure(message: e.message ?? 'Error de servidor.', code: e.code));
    } on AuthException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _appwrite.account.deleteSession(sessionId: 'current');
      await _secureStorage.delete(key: _kCurrentUserId);
      await _secureStorage.delete(key: _kSessionId);
      _logger.i('[AuthRepo] Logout exitoso.');
      return const Right(null);
    } on AppwriteException {
      // Si la sesión ya expiró, igual limpiamos local
      await _secureStorage.deleteAll();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      // 1. Cambiar contraseña en Appwrite
      await _appwrite.account.updatePassword(
        password: newPassword,
        oldPassword: oldPassword,
      );

      // 2. Actualizar flag password_changed en Appwrite
      final userId = await _secureStorage.read(key: _kCurrentUserId);
      if (userId != null) {
        await _appwrite.databases.updateDocument(
          databaseId: AppConstants.appwriteDatabaseId,
          collectionId: AppConstants.colUsers,
          documentId: userId,
          data: {'password_changed': true},
          permissions: AppwriteService.permissionsUserDocument(userId),
        );

        // 3. Actualizar Drift local
        await _db.usersDao.updateAuthFlags(
          userId: userId,
          passwordChanged: true,
        );
      }

      _logger.i('[AuthRepo] Contraseña cambiada exitosamente.');
      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Error al cambiar contraseña.', code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordRecovery({
    required String cedula,
  }) async {
    try {
      // 1. Buscar el correo real del usuario por cédula
      final userDoc = await _appwrite.databases.listDocuments(
        databaseId: AppConstants.appwriteDatabaseId,
        collectionId: AppConstants.colUsers,
        queries: [Query.equal('cedula', cedula)],
      );

      if (userDoc.documents.isEmpty) {
        return const Left(
          ServerFailure(message: 'No se encontró una cuenta con esa cédula.', code: 404),
        );
      }

      final correo = userDoc.documents.first.data['correo'] as String;

      // 2. Enviar recuperación al correo real
      await _appwrite.account.createRecovery(
        email: correo,
        url: 'https://control-electoral-ec.app/recovery',
      );
      _logger.i('[AuthRepo] Recuperación enviada a $correo para cédula $cedula');
      return const Right(null);
    } on AppwriteException catch (e) {
      if (e.code == 404) {
        return const Left(
          ServerFailure(message: 'No se encontró una cuenta con ese correo.', code: 404),
        );
      }
      return Left(ServerFailure(message: e.message ?? 'Error al enviar solicitud.', code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> confirmPasswordRecovery({
    required String userId,
    required String secret,
    required String newPassword,
  }) async {
    try {
      await _appwrite.account.updateRecovery(
        userId: userId,
        secret: secret,
        password: newPassword,
      );
      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Error al recuperar contraseña.', code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyEmail({
    required String userId,
    required String secret,
  }) async {
    try {
      await _appwrite.account.updateVerification(
        userId: userId,
        secret: secret,
      );

      // Actualizar flag local
      await _db.usersDao.updateAuthFlags(
        userId: userId,
        emailVerified: true,
      );

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Error al verificar email.', code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      // 1. Intentar desde caché local primero
      final userId = await _secureStorage.read(key: _kCurrentUserId);
      if (userId != null) {
        final localUser = await _db.usersDao.getUserById(userId);
        if (localUser != null) {
          return Right(UserModel.fromDrift(localUser).toEntity());
        }
      }

      // 2. Fallback: consultar Appwrite
      final isConnected = await _networkInfo.isConnected;
      if (!isConnected) {
        return const Left(
          SessionExpiredFailure(message: 'Sin sesión local. Inicie sesión nuevamente.'),
        );
      }

      final account = await _appwrite.account.get();
      final userDocs = await _appwrite.databases.listDocuments(
        databaseId: AppConstants.appwriteDatabaseId,
        collectionId: AppConstants.colUsers,
        queries: [Query.equal('\$id', account.$id)],
      );

      if (userDocs.documents.isEmpty) {
        return const Left(NotFoundFailure());
      }

      final userModel = UserModel.fromAppwrite(userDocs.documents.first.data);
      await _db.usersDao.upsertUser(
        UsersTableCompanion.insert(
          id: userModel.id,
          cedula: userModel.cedula,
          nombres: userModel.nombres,
          apellidos: userModel.apellidos,
          telefono: userModel.telefono,
          correo: userModel.correo,
          rol: userModel.rol,
          passwordChanged: Value(userModel.passwordChanged),
          emailVerified: Value(userModel.emailVerified),
          precinctId: Value(userModel.precinctId),
        ),
      );

      return Right(userModel.toEntity());
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        return const Left(SessionExpiredFailure());
      }
      return Left(ServerFailure(message: e.message ?? 'Error.', code: e.code));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      await _appwrite.account.getSession(sessionId: 'current');
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<Either<Failure, UserEntity>> createUser({
    required String cedula,
    required String nombres,
    required String apellidos,
    required String telefono,
    required String correo,
    required UserRole rol,
    String? precinctId,
  }) async {
    try {
      final userId = _uuid.v4();
      final model = UserModel(
        id: userId,
        cedula: cedula,
        nombres: nombres,
        apellidos: apellidos,
        telefono: telefono,
        correo: correo,
        rol: rol.value,
        passwordChanged: false,
        emailVerified: false,
        precinctId: precinctId,
      );

      // 1. Guardar documento en Appwrite DB primero (con sesión del coordinador activa)
      await _appwrite.databases.createDocument(
        databaseId: AppConstants.appwriteDatabaseId,
        collectionId: AppConstants.colUsers,
        documentId: userId,
        data: {
          'cedula': cedula,
          'nombres': nombres,
          'apellidos': apellidos,
          'telefono': telefono,
          'correo': correo,
          'rol': rol.value,
          'password_changed': false,
          'email_verified': false,
          if (precinctId != null) 'precinct_id': precinctId,
        },
        permissions: AppwriteService.permissionsUserDocument(userId),
      );

      // 2. Guardar en Drift local (antes del switch de sesión)
      await _db.usersDao.upsertUser(
        UsersTableCompanion.insert(
          id: model.id,
          cedula: model.cedula,
          nombres: model.nombres,
          apellidos: model.apellidos,
          telefono: model.telefono,
          correo: model.correo,
          rol: model.rol,
          passwordChanged: Value(model.passwordChanged),
          emailVerified: Value(model.emailVerified),
          precinctId: Value(model.precinctId),
        ),
      );

      // 3. Crear cuenta en Appwrite Auth con el correo real del usuario
      // ATENCIÓN: account.create() cambia la sesión actual al nuevo usuario.
      await _appwrite.account.create(
        userId: userId,
        email: correo,
        password: AppConstants.defaultPassword,
        name: '$nombres $apellidos',
      );

      // 4. Enviar verificación de email (se ejecuta bajo la sesión del nuevo usuario)
      try {
        final verificationAccount = Account(_appwrite.client);
        await verificationAccount.createVerification(
          url: 'https://control-electoral-ec.app/verify',
        );
      } catch (e) {
        _logger.w('[AuthRepo] No se pudo enviar verificación de email: $e');
      }

      // 5. Limpiar sesión del coordinador que se perdió con account.create()
      await _secureStorage.delete(key: _kCurrentUserId);
      await _secureStorage.delete(key: _kSessionId);

      _logger.i('[AuthRepo] Usuario creado: $cedula con rol ${rol.value}. Sesión restaurable.');
      return Right(model.toEntity());
    } on AppwriteException catch (e) {
      if (e.code == 409) {
        return const Left(
          ServerFailure(message: 'Ya existe un usuario con esa cédula o correo.', code: 409),
        );
      }
      return Left(ServerFailure(message: e.message ?? 'Error al crear usuario.', code: e.code));
    } on AuthException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


