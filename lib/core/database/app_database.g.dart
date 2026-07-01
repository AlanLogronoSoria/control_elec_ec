// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTableTable extends UsersTable
    with TableInfo<$UsersTableTable, UsersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cedulaMeta = const VerificationMeta('cedula');
  @override
  late final GeneratedColumn<String> cedula = GeneratedColumn<String>(
      'cedula', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nombresMeta =
      const VerificationMeta('nombres');
  @override
  late final GeneratedColumn<String> nombres = GeneratedColumn<String>(
      'nombres', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _apellidosMeta =
      const VerificationMeta('apellidos');
  @override
  late final GeneratedColumn<String> apellidos = GeneratedColumn<String>(
      'apellidos', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _telefonoMeta =
      const VerificationMeta('telefono');
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
      'telefono', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _correoMeta = const VerificationMeta('correo');
  @override
  late final GeneratedColumn<String> correo = GeneratedColumn<String>(
      'correo', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
      'rol', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passwordChangedMeta =
      const VerificationMeta('passwordChanged');
  @override
  late final GeneratedColumn<bool> passwordChanged = GeneratedColumn<bool>(
      'password_changed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("password_changed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _emailVerifiedMeta =
      const VerificationMeta('emailVerified');
  @override
  late final GeneratedColumn<bool> emailVerified = GeneratedColumn<bool>(
      'email_verified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("email_verified" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _precinctIdMeta =
      const VerificationMeta('precinctId');
  @override
  late final GeneratedColumn<String> precinctId = GeneratedColumn<String>(
      'precinct_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastSyncAtMeta =
      const VerificationMeta('lastSyncAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncAt = GeneratedColumn<DateTime>(
      'last_sync_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
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
        lastSyncAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<UsersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('cedula')) {
      context.handle(_cedulaMeta,
          cedula.isAcceptableOrUnknown(data['cedula']!, _cedulaMeta));
    } else if (isInserting) {
      context.missing(_cedulaMeta);
    }
    if (data.containsKey('nombres')) {
      context.handle(_nombresMeta,
          nombres.isAcceptableOrUnknown(data['nombres']!, _nombresMeta));
    } else if (isInserting) {
      context.missing(_nombresMeta);
    }
    if (data.containsKey('apellidos')) {
      context.handle(_apellidosMeta,
          apellidos.isAcceptableOrUnknown(data['apellidos']!, _apellidosMeta));
    } else if (isInserting) {
      context.missing(_apellidosMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta));
    } else if (isInserting) {
      context.missing(_telefonoMeta);
    }
    if (data.containsKey('correo')) {
      context.handle(_correoMeta,
          correo.isAcceptableOrUnknown(data['correo']!, _correoMeta));
    } else if (isInserting) {
      context.missing(_correoMeta);
    }
    if (data.containsKey('rol')) {
      context.handle(
          _rolMeta, rol.isAcceptableOrUnknown(data['rol']!, _rolMeta));
    } else if (isInserting) {
      context.missing(_rolMeta);
    }
    if (data.containsKey('password_changed')) {
      context.handle(
          _passwordChangedMeta,
          passwordChanged.isAcceptableOrUnknown(
              data['password_changed']!, _passwordChangedMeta));
    }
    if (data.containsKey('email_verified')) {
      context.handle(
          _emailVerifiedMeta,
          emailVerified.isAcceptableOrUnknown(
              data['email_verified']!, _emailVerifiedMeta));
    }
    if (data.containsKey('precinct_id')) {
      context.handle(
          _precinctIdMeta,
          precinctId.isAcceptableOrUnknown(
              data['precinct_id']!, _precinctIdMeta));
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
          _lastSyncAtMeta,
          lastSyncAt.isAcceptableOrUnknown(
              data['last_sync_at']!, _lastSyncAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      cedula: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cedula'])!,
      nombres: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombres'])!,
      apellidos: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}apellidos'])!,
      telefono: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefono'])!,
      correo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}correo'])!,
      rol: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rol'])!,
      passwordChanged: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}password_changed'])!,
      emailVerified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}email_verified'])!,
      precinctId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}precinct_id']),
      lastSyncAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync_at']),
    );
  }

  @override
  $UsersTableTable createAlias(String alias) {
    return $UsersTableTable(attachedDatabase, alias);
  }
}

class UsersTableData extends DataClass implements Insertable<UsersTableData> {
  /// ID único (sincronizado con Appwrite document ID).
  final String id;

  /// Cédula ecuatoriana (se usa como username en Appwrite).
  final String cedula;

  /// Nombres completos.
  final String nombres;

  /// Apellidos completos.
  final String apellidos;

  /// Teléfono (10 dígitos).
  final String telefono;

  /// Correo electrónico.
  final String correo;

  /// Rol: coordinador_provincial | coordinador_recinto | veedor_mesa
  final String rol;

  /// Si el usuario ya cambió su contraseña inicial.
  final bool passwordChanged;

  /// Si el correo ya fue verificado.
  final bool emailVerified;

  /// ID del recinto (solo para coordinadores de recinto y veedores).
  final String? precinctId;

  /// Timestamp de última sincronización con Appwrite.
  final DateTime? lastSyncAt;
  const UsersTableData(
      {required this.id,
      required this.cedula,
      required this.nombres,
      required this.apellidos,
      required this.telefono,
      required this.correo,
      required this.rol,
      required this.passwordChanged,
      required this.emailVerified,
      this.precinctId,
      this.lastSyncAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['cedula'] = Variable<String>(cedula);
    map['nombres'] = Variable<String>(nombres);
    map['apellidos'] = Variable<String>(apellidos);
    map['telefono'] = Variable<String>(telefono);
    map['correo'] = Variable<String>(correo);
    map['rol'] = Variable<String>(rol);
    map['password_changed'] = Variable<bool>(passwordChanged);
    map['email_verified'] = Variable<bool>(emailVerified);
    if (!nullToAbsent || precinctId != null) {
      map['precinct_id'] = Variable<String>(precinctId);
    }
    if (!nullToAbsent || lastSyncAt != null) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt);
    }
    return map;
  }

  UsersTableCompanion toCompanion(bool nullToAbsent) {
    return UsersTableCompanion(
      id: Value(id),
      cedula: Value(cedula),
      nombres: Value(nombres),
      apellidos: Value(apellidos),
      telefono: Value(telefono),
      correo: Value(correo),
      rol: Value(rol),
      passwordChanged: Value(passwordChanged),
      emailVerified: Value(emailVerified),
      precinctId: precinctId == null && nullToAbsent
          ? const Value.absent()
          : Value(precinctId),
      lastSyncAt: lastSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAt),
    );
  }

  factory UsersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersTableData(
      id: serializer.fromJson<String>(json['id']),
      cedula: serializer.fromJson<String>(json['cedula']),
      nombres: serializer.fromJson<String>(json['nombres']),
      apellidos: serializer.fromJson<String>(json['apellidos']),
      telefono: serializer.fromJson<String>(json['telefono']),
      correo: serializer.fromJson<String>(json['correo']),
      rol: serializer.fromJson<String>(json['rol']),
      passwordChanged: serializer.fromJson<bool>(json['passwordChanged']),
      emailVerified: serializer.fromJson<bool>(json['emailVerified']),
      precinctId: serializer.fromJson<String?>(json['precinctId']),
      lastSyncAt: serializer.fromJson<DateTime?>(json['lastSyncAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cedula': serializer.toJson<String>(cedula),
      'nombres': serializer.toJson<String>(nombres),
      'apellidos': serializer.toJson<String>(apellidos),
      'telefono': serializer.toJson<String>(telefono),
      'correo': serializer.toJson<String>(correo),
      'rol': serializer.toJson<String>(rol),
      'passwordChanged': serializer.toJson<bool>(passwordChanged),
      'emailVerified': serializer.toJson<bool>(emailVerified),
      'precinctId': serializer.toJson<String?>(precinctId),
      'lastSyncAt': serializer.toJson<DateTime?>(lastSyncAt),
    };
  }

  UsersTableData copyWith(
          {String? id,
          String? cedula,
          String? nombres,
          String? apellidos,
          String? telefono,
          String? correo,
          String? rol,
          bool? passwordChanged,
          bool? emailVerified,
          Value<String?> precinctId = const Value.absent(),
          Value<DateTime?> lastSyncAt = const Value.absent()}) =>
      UsersTableData(
        id: id ?? this.id,
        cedula: cedula ?? this.cedula,
        nombres: nombres ?? this.nombres,
        apellidos: apellidos ?? this.apellidos,
        telefono: telefono ?? this.telefono,
        correo: correo ?? this.correo,
        rol: rol ?? this.rol,
        passwordChanged: passwordChanged ?? this.passwordChanged,
        emailVerified: emailVerified ?? this.emailVerified,
        precinctId: precinctId.present ? precinctId.value : this.precinctId,
        lastSyncAt: lastSyncAt.present ? lastSyncAt.value : this.lastSyncAt,
      );
  UsersTableData copyWithCompanion(UsersTableCompanion data) {
    return UsersTableData(
      id: data.id.present ? data.id.value : this.id,
      cedula: data.cedula.present ? data.cedula.value : this.cedula,
      nombres: data.nombres.present ? data.nombres.value : this.nombres,
      apellidos: data.apellidos.present ? data.apellidos.value : this.apellidos,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      correo: data.correo.present ? data.correo.value : this.correo,
      rol: data.rol.present ? data.rol.value : this.rol,
      passwordChanged: data.passwordChanged.present
          ? data.passwordChanged.value
          : this.passwordChanged,
      emailVerified: data.emailVerified.present
          ? data.emailVerified.value
          : this.emailVerified,
      precinctId:
          data.precinctId.present ? data.precinctId.value : this.precinctId,
      lastSyncAt:
          data.lastSyncAt.present ? data.lastSyncAt.value : this.lastSyncAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableData(')
          ..write('id: $id, ')
          ..write('cedula: $cedula, ')
          ..write('nombres: $nombres, ')
          ..write('apellidos: $apellidos, ')
          ..write('telefono: $telefono, ')
          ..write('correo: $correo, ')
          ..write('rol: $rol, ')
          ..write('passwordChanged: $passwordChanged, ')
          ..write('emailVerified: $emailVerified, ')
          ..write('precinctId: $precinctId, ')
          ..write('lastSyncAt: $lastSyncAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cedula, nombres, apellidos, telefono,
      correo, rol, passwordChanged, emailVerified, precinctId, lastSyncAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersTableData &&
          other.id == this.id &&
          other.cedula == this.cedula &&
          other.nombres == this.nombres &&
          other.apellidos == this.apellidos &&
          other.telefono == this.telefono &&
          other.correo == this.correo &&
          other.rol == this.rol &&
          other.passwordChanged == this.passwordChanged &&
          other.emailVerified == this.emailVerified &&
          other.precinctId == this.precinctId &&
          other.lastSyncAt == this.lastSyncAt);
}

class UsersTableCompanion extends UpdateCompanion<UsersTableData> {
  final Value<String> id;
  final Value<String> cedula;
  final Value<String> nombres;
  final Value<String> apellidos;
  final Value<String> telefono;
  final Value<String> correo;
  final Value<String> rol;
  final Value<bool> passwordChanged;
  final Value<bool> emailVerified;
  final Value<String?> precinctId;
  final Value<DateTime?> lastSyncAt;
  final Value<int> rowid;
  const UsersTableCompanion({
    this.id = const Value.absent(),
    this.cedula = const Value.absent(),
    this.nombres = const Value.absent(),
    this.apellidos = const Value.absent(),
    this.telefono = const Value.absent(),
    this.correo = const Value.absent(),
    this.rol = const Value.absent(),
    this.passwordChanged = const Value.absent(),
    this.emailVerified = const Value.absent(),
    this.precinctId = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersTableCompanion.insert({
    required String id,
    required String cedula,
    required String nombres,
    required String apellidos,
    required String telefono,
    required String correo,
    required String rol,
    this.passwordChanged = const Value.absent(),
    this.emailVerified = const Value.absent(),
    this.precinctId = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        cedula = Value(cedula),
        nombres = Value(nombres),
        apellidos = Value(apellidos),
        telefono = Value(telefono),
        correo = Value(correo),
        rol = Value(rol);
  static Insertable<UsersTableData> custom({
    Expression<String>? id,
    Expression<String>? cedula,
    Expression<String>? nombres,
    Expression<String>? apellidos,
    Expression<String>? telefono,
    Expression<String>? correo,
    Expression<String>? rol,
    Expression<bool>? passwordChanged,
    Expression<bool>? emailVerified,
    Expression<String>? precinctId,
    Expression<DateTime>? lastSyncAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cedula != null) 'cedula': cedula,
      if (nombres != null) 'nombres': nombres,
      if (apellidos != null) 'apellidos': apellidos,
      if (telefono != null) 'telefono': telefono,
      if (correo != null) 'correo': correo,
      if (rol != null) 'rol': rol,
      if (passwordChanged != null) 'password_changed': passwordChanged,
      if (emailVerified != null) 'email_verified': emailVerified,
      if (precinctId != null) 'precinct_id': precinctId,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? cedula,
      Value<String>? nombres,
      Value<String>? apellidos,
      Value<String>? telefono,
      Value<String>? correo,
      Value<String>? rol,
      Value<bool>? passwordChanged,
      Value<bool>? emailVerified,
      Value<String?>? precinctId,
      Value<DateTime?>? lastSyncAt,
      Value<int>? rowid}) {
    return UsersTableCompanion(
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
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cedula.present) {
      map['cedula'] = Variable<String>(cedula.value);
    }
    if (nombres.present) {
      map['nombres'] = Variable<String>(nombres.value);
    }
    if (apellidos.present) {
      map['apellidos'] = Variable<String>(apellidos.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (correo.present) {
      map['correo'] = Variable<String>(correo.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    if (passwordChanged.present) {
      map['password_changed'] = Variable<bool>(passwordChanged.value);
    }
    if (emailVerified.present) {
      map['email_verified'] = Variable<bool>(emailVerified.value);
    }
    if (precinctId.present) {
      map['precinct_id'] = Variable<String>(precinctId.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersTableCompanion(')
          ..write('id: $id, ')
          ..write('cedula: $cedula, ')
          ..write('nombres: $nombres, ')
          ..write('apellidos: $apellidos, ')
          ..write('telefono: $telefono, ')
          ..write('correo: $correo, ')
          ..write('rol: $rol, ')
          ..write('passwordChanged: $passwordChanged, ')
          ..write('emailVerified: $emailVerified, ')
          ..write('precinctId: $precinctId, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrecinctsTableTable extends PrecinctsTable
    with TableInfo<$PrecinctsTableTable, PrecinctsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrecinctsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _provinciaMeta =
      const VerificationMeta('provincia');
  @override
  late final GeneratedColumn<String> provincia = GeneratedColumn<String>(
      'provincia', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cantonMeta = const VerificationMeta('canton');
  @override
  late final GeneratedColumn<String> canton = GeneratedColumn<String>(
      'canton', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parroquiaMeta =
      const VerificationMeta('parroquia');
  @override
  late final GeneratedColumn<String> parroquia = GeneratedColumn<String>(
      'parroquia', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreRecintoMeta =
      const VerificationMeta('nombreRecinto');
  @override
  late final GeneratedColumn<String> nombreRecinto = GeneratedColumn<String>(
      'nombre_recinto', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numeroJrvMeta =
      const VerificationMeta('numeroJrv');
  @override
  late final GeneratedColumn<int> numeroJrv = GeneratedColumn<int>(
      'numero_jrv', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _coordinadorRecintoIdMeta =
      const VerificationMeta('coordinadorRecintoId');
  @override
  late final GeneratedColumn<String> coordinadorRecintoId =
      GeneratedColumn<String>(
          'coordinador_recinto_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints:
              GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastSyncAtMeta =
      const VerificationMeta('lastSyncAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncAt = GeneratedColumn<DateTime>(
      'last_sync_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        provincia,
        canton,
        parroquia,
        nombreRecinto,
        numeroJrv,
        coordinadorRecintoId,
        createdAt,
        updatedAt,
        lastSyncAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'electoral_precincts';
  @override
  VerificationContext validateIntegrity(Insertable<PrecinctsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('provincia')) {
      context.handle(_provinciaMeta,
          provincia.isAcceptableOrUnknown(data['provincia']!, _provinciaMeta));
    } else if (isInserting) {
      context.missing(_provinciaMeta);
    }
    if (data.containsKey('canton')) {
      context.handle(_cantonMeta,
          canton.isAcceptableOrUnknown(data['canton']!, _cantonMeta));
    } else if (isInserting) {
      context.missing(_cantonMeta);
    }
    if (data.containsKey('parroquia')) {
      context.handle(_parroquiaMeta,
          parroquia.isAcceptableOrUnknown(data['parroquia']!, _parroquiaMeta));
    } else if (isInserting) {
      context.missing(_parroquiaMeta);
    }
    if (data.containsKey('nombre_recinto')) {
      context.handle(
          _nombreRecintoMeta,
          nombreRecinto.isAcceptableOrUnknown(
              data['nombre_recinto']!, _nombreRecintoMeta));
    } else if (isInserting) {
      context.missing(_nombreRecintoMeta);
    }
    if (data.containsKey('numero_jrv')) {
      context.handle(_numeroJrvMeta,
          numeroJrv.isAcceptableOrUnknown(data['numero_jrv']!, _numeroJrvMeta));
    } else if (isInserting) {
      context.missing(_numeroJrvMeta);
    }
    if (data.containsKey('coordinador_recinto_id')) {
      context.handle(
          _coordinadorRecintoIdMeta,
          coordinadorRecintoId.isAcceptableOrUnknown(
              data['coordinador_recinto_id']!, _coordinadorRecintoIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
          _lastSyncAtMeta,
          lastSyncAt.isAcceptableOrUnknown(
              data['last_sync_at']!, _lastSyncAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrecinctsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrecinctsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      provincia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provincia'])!,
      canton: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}canton'])!,
      parroquia: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parroquia'])!,
      nombreRecinto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre_recinto'])!,
      numeroJrv: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}numero_jrv'])!,
      coordinadorRecintoId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}coordinador_recinto_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      lastSyncAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync_at']),
    );
  }

  @override
  $PrecinctsTableTable createAlias(String alias) {
    return $PrecinctsTableTable(attachedDatabase, alias);
  }
}

class PrecinctsTableData extends DataClass
    implements Insertable<PrecinctsTableData> {
  final String id;
  final String provincia;
  final String canton;
  final String parroquia;
  final String nombreRecinto;
  final int numeroJrv;

  /// ID del coordinador de recinto asignado.
  final String? coordinadorRecintoId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastSyncAt;
  const PrecinctsTableData(
      {required this.id,
      required this.provincia,
      required this.canton,
      required this.parroquia,
      required this.nombreRecinto,
      required this.numeroJrv,
      this.coordinadorRecintoId,
      required this.createdAt,
      required this.updatedAt,
      this.lastSyncAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['provincia'] = Variable<String>(provincia);
    map['canton'] = Variable<String>(canton);
    map['parroquia'] = Variable<String>(parroquia);
    map['nombre_recinto'] = Variable<String>(nombreRecinto);
    map['numero_jrv'] = Variable<int>(numeroJrv);
    if (!nullToAbsent || coordinadorRecintoId != null) {
      map['coordinador_recinto_id'] = Variable<String>(coordinadorRecintoId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastSyncAt != null) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt);
    }
    return map;
  }

  PrecinctsTableCompanion toCompanion(bool nullToAbsent) {
    return PrecinctsTableCompanion(
      id: Value(id),
      provincia: Value(provincia),
      canton: Value(canton),
      parroquia: Value(parroquia),
      nombreRecinto: Value(nombreRecinto),
      numeroJrv: Value(numeroJrv),
      coordinadorRecintoId: coordinadorRecintoId == null && nullToAbsent
          ? const Value.absent()
          : Value(coordinadorRecintoId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastSyncAt: lastSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAt),
    );
  }

  factory PrecinctsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrecinctsTableData(
      id: serializer.fromJson<String>(json['id']),
      provincia: serializer.fromJson<String>(json['provincia']),
      canton: serializer.fromJson<String>(json['canton']),
      parroquia: serializer.fromJson<String>(json['parroquia']),
      nombreRecinto: serializer.fromJson<String>(json['nombreRecinto']),
      numeroJrv: serializer.fromJson<int>(json['numeroJrv']),
      coordinadorRecintoId:
          serializer.fromJson<String?>(json['coordinadorRecintoId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncAt: serializer.fromJson<DateTime?>(json['lastSyncAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'provincia': serializer.toJson<String>(provincia),
      'canton': serializer.toJson<String>(canton),
      'parroquia': serializer.toJson<String>(parroquia),
      'nombreRecinto': serializer.toJson<String>(nombreRecinto),
      'numeroJrv': serializer.toJson<int>(numeroJrv),
      'coordinadorRecintoId': serializer.toJson<String?>(coordinadorRecintoId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncAt': serializer.toJson<DateTime?>(lastSyncAt),
    };
  }

  PrecinctsTableData copyWith(
          {String? id,
          String? provincia,
          String? canton,
          String? parroquia,
          String? nombreRecinto,
          int? numeroJrv,
          Value<String?> coordinadorRecintoId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> lastSyncAt = const Value.absent()}) =>
      PrecinctsTableData(
        id: id ?? this.id,
        provincia: provincia ?? this.provincia,
        canton: canton ?? this.canton,
        parroquia: parroquia ?? this.parroquia,
        nombreRecinto: nombreRecinto ?? this.nombreRecinto,
        numeroJrv: numeroJrv ?? this.numeroJrv,
        coordinadorRecintoId: coordinadorRecintoId.present
            ? coordinadorRecintoId.value
            : this.coordinadorRecintoId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lastSyncAt: lastSyncAt.present ? lastSyncAt.value : this.lastSyncAt,
      );
  PrecinctsTableData copyWithCompanion(PrecinctsTableCompanion data) {
    return PrecinctsTableData(
      id: data.id.present ? data.id.value : this.id,
      provincia: data.provincia.present ? data.provincia.value : this.provincia,
      canton: data.canton.present ? data.canton.value : this.canton,
      parroquia: data.parroquia.present ? data.parroquia.value : this.parroquia,
      nombreRecinto: data.nombreRecinto.present
          ? data.nombreRecinto.value
          : this.nombreRecinto,
      numeroJrv: data.numeroJrv.present ? data.numeroJrv.value : this.numeroJrv,
      coordinadorRecintoId: data.coordinadorRecintoId.present
          ? data.coordinadorRecintoId.value
          : this.coordinadorRecintoId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncAt:
          data.lastSyncAt.present ? data.lastSyncAt.value : this.lastSyncAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrecinctsTableData(')
          ..write('id: $id, ')
          ..write('provincia: $provincia, ')
          ..write('canton: $canton, ')
          ..write('parroquia: $parroquia, ')
          ..write('nombreRecinto: $nombreRecinto, ')
          ..write('numeroJrv: $numeroJrv, ')
          ..write('coordinadorRecintoId: $coordinadorRecintoId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncAt: $lastSyncAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      provincia,
      canton,
      parroquia,
      nombreRecinto,
      numeroJrv,
      coordinadorRecintoId,
      createdAt,
      updatedAt,
      lastSyncAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrecinctsTableData &&
          other.id == this.id &&
          other.provincia == this.provincia &&
          other.canton == this.canton &&
          other.parroquia == this.parroquia &&
          other.nombreRecinto == this.nombreRecinto &&
          other.numeroJrv == this.numeroJrv &&
          other.coordinadorRecintoId == this.coordinadorRecintoId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncAt == this.lastSyncAt);
}

class PrecinctsTableCompanion extends UpdateCompanion<PrecinctsTableData> {
  final Value<String> id;
  final Value<String> provincia;
  final Value<String> canton;
  final Value<String> parroquia;
  final Value<String> nombreRecinto;
  final Value<int> numeroJrv;
  final Value<String?> coordinadorRecintoId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastSyncAt;
  final Value<int> rowid;
  const PrecinctsTableCompanion({
    this.id = const Value.absent(),
    this.provincia = const Value.absent(),
    this.canton = const Value.absent(),
    this.parroquia = const Value.absent(),
    this.nombreRecinto = const Value.absent(),
    this.numeroJrv = const Value.absent(),
    this.coordinadorRecintoId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PrecinctsTableCompanion.insert({
    required String id,
    required String provincia,
    required String canton,
    required String parroquia,
    required String nombreRecinto,
    required int numeroJrv,
    this.coordinadorRecintoId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        provincia = Value(provincia),
        canton = Value(canton),
        parroquia = Value(parroquia),
        nombreRecinto = Value(nombreRecinto),
        numeroJrv = Value(numeroJrv);
  static Insertable<PrecinctsTableData> custom({
    Expression<String>? id,
    Expression<String>? provincia,
    Expression<String>? canton,
    Expression<String>? parroquia,
    Expression<String>? nombreRecinto,
    Expression<int>? numeroJrv,
    Expression<String>? coordinadorRecintoId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (provincia != null) 'provincia': provincia,
      if (canton != null) 'canton': canton,
      if (parroquia != null) 'parroquia': parroquia,
      if (nombreRecinto != null) 'nombre_recinto': nombreRecinto,
      if (numeroJrv != null) 'numero_jrv': numeroJrv,
      if (coordinadorRecintoId != null)
        'coordinador_recinto_id': coordinadorRecintoId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PrecinctsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? provincia,
      Value<String>? canton,
      Value<String>? parroquia,
      Value<String>? nombreRecinto,
      Value<int>? numeroJrv,
      Value<String?>? coordinadorRecintoId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? lastSyncAt,
      Value<int>? rowid}) {
    return PrecinctsTableCompanion(
      id: id ?? this.id,
      provincia: provincia ?? this.provincia,
      canton: canton ?? this.canton,
      parroquia: parroquia ?? this.parroquia,
      nombreRecinto: nombreRecinto ?? this.nombreRecinto,
      numeroJrv: numeroJrv ?? this.numeroJrv,
      coordinadorRecintoId: coordinadorRecintoId ?? this.coordinadorRecintoId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (provincia.present) {
      map['provincia'] = Variable<String>(provincia.value);
    }
    if (canton.present) {
      map['canton'] = Variable<String>(canton.value);
    }
    if (parroquia.present) {
      map['parroquia'] = Variable<String>(parroquia.value);
    }
    if (nombreRecinto.present) {
      map['nombre_recinto'] = Variable<String>(nombreRecinto.value);
    }
    if (numeroJrv.present) {
      map['numero_jrv'] = Variable<int>(numeroJrv.value);
    }
    if (coordinadorRecintoId.present) {
      map['coordinador_recinto_id'] =
          Variable<String>(coordinadorRecintoId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrecinctsTableCompanion(')
          ..write('id: $id, ')
          ..write('provincia: $provincia, ')
          ..write('canton: $canton, ')
          ..write('parroquia: $parroquia, ')
          ..write('nombreRecinto: $nombreRecinto, ')
          ..write('numeroJrv: $numeroJrv, ')
          ..write('coordinadorRecintoId: $coordinadorRecintoId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ElectoralTablesTableTable extends ElectoralTablesTable
    with TableInfo<$ElectoralTablesTableTable, ElectoralTablesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ElectoralTablesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jrvNumberMeta =
      const VerificationMeta('jrvNumber');
  @override
  late final GeneratedColumn<int> jrvNumber = GeneratedColumn<int>(
      'jrv_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _precinctIdMeta =
      const VerificationMeta('precinctId');
  @override
  late final GeneratedColumn<String> precinctId = GeneratedColumn<String>(
      'precinct_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES electoral_precincts (id)'));
  static const VerificationMeta _veedorIdMeta =
      const VerificationMeta('veedorId');
  @override
  late final GeneratedColumn<String> veedorId = GeneratedColumn<String>(
      'veedor_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _estadoActaMeta =
      const VerificationMeta('estadoActa');
  @override
  late final GeneratedColumn<String> estadoActa = GeneratedColumn<String>(
      'estado_acta', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pendiente'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastSyncAtMeta =
      const VerificationMeta('lastSyncAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncAt = GeneratedColumn<DateTime>(
      'last_sync_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        jrvNumber,
        precinctId,
        veedorId,
        estadoActa,
        createdAt,
        updatedAt,
        lastSyncAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'electoral_tables';
  @override
  VerificationContext validateIntegrity(
      Insertable<ElectoralTablesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('jrv_number')) {
      context.handle(_jrvNumberMeta,
          jrvNumber.isAcceptableOrUnknown(data['jrv_number']!, _jrvNumberMeta));
    } else if (isInserting) {
      context.missing(_jrvNumberMeta);
    }
    if (data.containsKey('precinct_id')) {
      context.handle(
          _precinctIdMeta,
          precinctId.isAcceptableOrUnknown(
              data['precinct_id']!, _precinctIdMeta));
    } else if (isInserting) {
      context.missing(_precinctIdMeta);
    }
    if (data.containsKey('veedor_id')) {
      context.handle(_veedorIdMeta,
          veedorId.isAcceptableOrUnknown(data['veedor_id']!, _veedorIdMeta));
    }
    if (data.containsKey('estado_acta')) {
      context.handle(
          _estadoActaMeta,
          estadoActa.isAcceptableOrUnknown(
              data['estado_acta']!, _estadoActaMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
          _lastSyncAtMeta,
          lastSyncAt.isAcceptableOrUnknown(
              data['last_sync_at']!, _lastSyncAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ElectoralTablesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ElectoralTablesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      jrvNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}jrv_number'])!,
      precinctId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}precinct_id'])!,
      veedorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}veedor_id']),
      estadoActa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado_acta'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      lastSyncAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync_at']),
    );
  }

  @override
  $ElectoralTablesTableTable createAlias(String alias) {
    return $ElectoralTablesTableTable(attachedDatabase, alias);
  }
}

class ElectoralTablesTableData extends DataClass
    implements Insertable<ElectoralTablesTableData> {
  final String id;
  final int jrvNumber;

  /// Recinto al que pertenece esta mesa.
  final String precinctId;

  /// Veedor asignado a esta mesa.
  final String? veedorId;

  /// Estado: pendiente | en_progreso | completado
  final String estadoActa;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastSyncAt;
  const ElectoralTablesTableData(
      {required this.id,
      required this.jrvNumber,
      required this.precinctId,
      this.veedorId,
      required this.estadoActa,
      required this.createdAt,
      required this.updatedAt,
      this.lastSyncAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['jrv_number'] = Variable<int>(jrvNumber);
    map['precinct_id'] = Variable<String>(precinctId);
    if (!nullToAbsent || veedorId != null) {
      map['veedor_id'] = Variable<String>(veedorId);
    }
    map['estado_acta'] = Variable<String>(estadoActa);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastSyncAt != null) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt);
    }
    return map;
  }

  ElectoralTablesTableCompanion toCompanion(bool nullToAbsent) {
    return ElectoralTablesTableCompanion(
      id: Value(id),
      jrvNumber: Value(jrvNumber),
      precinctId: Value(precinctId),
      veedorId: veedorId == null && nullToAbsent
          ? const Value.absent()
          : Value(veedorId),
      estadoActa: Value(estadoActa),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastSyncAt: lastSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAt),
    );
  }

  factory ElectoralTablesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ElectoralTablesTableData(
      id: serializer.fromJson<String>(json['id']),
      jrvNumber: serializer.fromJson<int>(json['jrvNumber']),
      precinctId: serializer.fromJson<String>(json['precinctId']),
      veedorId: serializer.fromJson<String?>(json['veedorId']),
      estadoActa: serializer.fromJson<String>(json['estadoActa']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncAt: serializer.fromJson<DateTime?>(json['lastSyncAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'jrvNumber': serializer.toJson<int>(jrvNumber),
      'precinctId': serializer.toJson<String>(precinctId),
      'veedorId': serializer.toJson<String?>(veedorId),
      'estadoActa': serializer.toJson<String>(estadoActa),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncAt': serializer.toJson<DateTime?>(lastSyncAt),
    };
  }

  ElectoralTablesTableData copyWith(
          {String? id,
          int? jrvNumber,
          String? precinctId,
          Value<String?> veedorId = const Value.absent(),
          String? estadoActa,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> lastSyncAt = const Value.absent()}) =>
      ElectoralTablesTableData(
        id: id ?? this.id,
        jrvNumber: jrvNumber ?? this.jrvNumber,
        precinctId: precinctId ?? this.precinctId,
        veedorId: veedorId.present ? veedorId.value : this.veedorId,
        estadoActa: estadoActa ?? this.estadoActa,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lastSyncAt: lastSyncAt.present ? lastSyncAt.value : this.lastSyncAt,
      );
  ElectoralTablesTableData copyWithCompanion(
      ElectoralTablesTableCompanion data) {
    return ElectoralTablesTableData(
      id: data.id.present ? data.id.value : this.id,
      jrvNumber: data.jrvNumber.present ? data.jrvNumber.value : this.jrvNumber,
      precinctId:
          data.precinctId.present ? data.precinctId.value : this.precinctId,
      veedorId: data.veedorId.present ? data.veedorId.value : this.veedorId,
      estadoActa:
          data.estadoActa.present ? data.estadoActa.value : this.estadoActa,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncAt:
          data.lastSyncAt.present ? data.lastSyncAt.value : this.lastSyncAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ElectoralTablesTableData(')
          ..write('id: $id, ')
          ..write('jrvNumber: $jrvNumber, ')
          ..write('precinctId: $precinctId, ')
          ..write('veedorId: $veedorId, ')
          ..write('estadoActa: $estadoActa, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncAt: $lastSyncAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jrvNumber, precinctId, veedorId,
      estadoActa, createdAt, updatedAt, lastSyncAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ElectoralTablesTableData &&
          other.id == this.id &&
          other.jrvNumber == this.jrvNumber &&
          other.precinctId == this.precinctId &&
          other.veedorId == this.veedorId &&
          other.estadoActa == this.estadoActa &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncAt == this.lastSyncAt);
}

class ElectoralTablesTableCompanion
    extends UpdateCompanion<ElectoralTablesTableData> {
  final Value<String> id;
  final Value<int> jrvNumber;
  final Value<String> precinctId;
  final Value<String?> veedorId;
  final Value<String> estadoActa;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastSyncAt;
  final Value<int> rowid;
  const ElectoralTablesTableCompanion({
    this.id = const Value.absent(),
    this.jrvNumber = const Value.absent(),
    this.precinctId = const Value.absent(),
    this.veedorId = const Value.absent(),
    this.estadoActa = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ElectoralTablesTableCompanion.insert({
    required String id,
    required int jrvNumber,
    required String precinctId,
    this.veedorId = const Value.absent(),
    this.estadoActa = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        jrvNumber = Value(jrvNumber),
        precinctId = Value(precinctId);
  static Insertable<ElectoralTablesTableData> custom({
    Expression<String>? id,
    Expression<int>? jrvNumber,
    Expression<String>? precinctId,
    Expression<String>? veedorId,
    Expression<String>? estadoActa,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jrvNumber != null) 'jrv_number': jrvNumber,
      if (precinctId != null) 'precinct_id': precinctId,
      if (veedorId != null) 'veedor_id': veedorId,
      if (estadoActa != null) 'estado_acta': estadoActa,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ElectoralTablesTableCompanion copyWith(
      {Value<String>? id,
      Value<int>? jrvNumber,
      Value<String>? precinctId,
      Value<String?>? veedorId,
      Value<String>? estadoActa,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? lastSyncAt,
      Value<int>? rowid}) {
    return ElectoralTablesTableCompanion(
      id: id ?? this.id,
      jrvNumber: jrvNumber ?? this.jrvNumber,
      precinctId: precinctId ?? this.precinctId,
      veedorId: veedorId ?? this.veedorId,
      estadoActa: estadoActa ?? this.estadoActa,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (jrvNumber.present) {
      map['jrv_number'] = Variable<int>(jrvNumber.value);
    }
    if (precinctId.present) {
      map['precinct_id'] = Variable<String>(precinctId.value);
    }
    if (veedorId.present) {
      map['veedor_id'] = Variable<String>(veedorId.value);
    }
    if (estadoActa.present) {
      map['estado_acta'] = Variable<String>(estadoActa.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ElectoralTablesTableCompanion(')
          ..write('id: $id, ')
          ..write('jrvNumber: $jrvNumber, ')
          ..write('precinctId: $precinctId, ')
          ..write('veedorId: $veedorId, ')
          ..write('estadoActa: $estadoActa, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrganizationsTableTable extends OrganizationsTable
    with TableInfo<$OrganizationsTableTable, OrganizationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrganizationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tipoDignidadMeta =
      const VerificationMeta('tipoDignidad');
  @override
  late final GeneratedColumn<String> tipoDignidad = GeneratedColumn<String>(
      'tipo_dignidad', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numeroListaMeta =
      const VerificationMeta('numeroLista');
  @override
  late final GeneratedColumn<int> numeroLista = GeneratedColumn<int>(
      'numero_lista', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#1565C0'));
  static const VerificationMeta _lastSyncAtMeta =
      const VerificationMeta('lastSyncAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncAt = GeneratedColumn<DateTime>(
      'last_sync_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nombre, tipoDignidad, numeroLista, color, lastSyncAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'political_organizations';
  @override
  VerificationContext validateIntegrity(
      Insertable<OrganizationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('tipo_dignidad')) {
      context.handle(
          _tipoDignidadMeta,
          tipoDignidad.isAcceptableOrUnknown(
              data['tipo_dignidad']!, _tipoDignidadMeta));
    } else if (isInserting) {
      context.missing(_tipoDignidadMeta);
    }
    if (data.containsKey('numero_lista')) {
      context.handle(
          _numeroListaMeta,
          numeroLista.isAcceptableOrUnknown(
              data['numero_lista']!, _numeroListaMeta));
    } else if (isInserting) {
      context.missing(_numeroListaMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
          _lastSyncAtMeta,
          lastSyncAt.isAcceptableOrUnknown(
              data['last_sync_at']!, _lastSyncAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrganizationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrganizationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      tipoDignidad: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo_dignidad'])!,
      numeroLista: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}numero_lista'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      lastSyncAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync_at']),
    );
  }

  @override
  $OrganizationsTableTable createAlias(String alias) {
    return $OrganizationsTableTable(attachedDatabase, alias);
  }
}

class OrganizationsTableData extends DataClass
    implements Insertable<OrganizationsTableData> {
  final String id;

  /// Nombre oficial de la organización.
  final String nombre;

  /// Dignidad: alcalde | prefecto
  final String tipoDignidad;

  /// Número de lista (1-5).
  final int numeroLista;

  /// Color representativo (hex, ej: #1565C0).
  final String color;
  final DateTime? lastSyncAt;
  const OrganizationsTableData(
      {required this.id,
      required this.nombre,
      required this.tipoDignidad,
      required this.numeroLista,
      required this.color,
      this.lastSyncAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    map['tipo_dignidad'] = Variable<String>(tipoDignidad);
    map['numero_lista'] = Variable<int>(numeroLista);
    map['color'] = Variable<String>(color);
    if (!nullToAbsent || lastSyncAt != null) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt);
    }
    return map;
  }

  OrganizationsTableCompanion toCompanion(bool nullToAbsent) {
    return OrganizationsTableCompanion(
      id: Value(id),
      nombre: Value(nombre),
      tipoDignidad: Value(tipoDignidad),
      numeroLista: Value(numeroLista),
      color: Value(color),
      lastSyncAt: lastSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAt),
    );
  }

  factory OrganizationsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrganizationsTableData(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      tipoDignidad: serializer.fromJson<String>(json['tipoDignidad']),
      numeroLista: serializer.fromJson<int>(json['numeroLista']),
      color: serializer.fromJson<String>(json['color']),
      lastSyncAt: serializer.fromJson<DateTime?>(json['lastSyncAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'tipoDignidad': serializer.toJson<String>(tipoDignidad),
      'numeroLista': serializer.toJson<int>(numeroLista),
      'color': serializer.toJson<String>(color),
      'lastSyncAt': serializer.toJson<DateTime?>(lastSyncAt),
    };
  }

  OrganizationsTableData copyWith(
          {String? id,
          String? nombre,
          String? tipoDignidad,
          int? numeroLista,
          String? color,
          Value<DateTime?> lastSyncAt = const Value.absent()}) =>
      OrganizationsTableData(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        tipoDignidad: tipoDignidad ?? this.tipoDignidad,
        numeroLista: numeroLista ?? this.numeroLista,
        color: color ?? this.color,
        lastSyncAt: lastSyncAt.present ? lastSyncAt.value : this.lastSyncAt,
      );
  OrganizationsTableData copyWithCompanion(OrganizationsTableCompanion data) {
    return OrganizationsTableData(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      tipoDignidad: data.tipoDignidad.present
          ? data.tipoDignidad.value
          : this.tipoDignidad,
      numeroLista:
          data.numeroLista.present ? data.numeroLista.value : this.numeroLista,
      color: data.color.present ? data.color.value : this.color,
      lastSyncAt:
          data.lastSyncAt.present ? data.lastSyncAt.value : this.lastSyncAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrganizationsTableData(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipoDignidad: $tipoDignidad, ')
          ..write('numeroLista: $numeroLista, ')
          ..write('color: $color, ')
          ..write('lastSyncAt: $lastSyncAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, tipoDignidad, numeroLista, color, lastSyncAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrganizationsTableData &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.tipoDignidad == this.tipoDignidad &&
          other.numeroLista == this.numeroLista &&
          other.color == this.color &&
          other.lastSyncAt == this.lastSyncAt);
}

class OrganizationsTableCompanion
    extends UpdateCompanion<OrganizationsTableData> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String> tipoDignidad;
  final Value<int> numeroLista;
  final Value<String> color;
  final Value<DateTime?> lastSyncAt;
  final Value<int> rowid;
  const OrganizationsTableCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.tipoDignidad = const Value.absent(),
    this.numeroLista = const Value.absent(),
    this.color = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrganizationsTableCompanion.insert({
    required String id,
    required String nombre,
    required String tipoDignidad,
    required int numeroLista,
    this.color = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nombre = Value(nombre),
        tipoDignidad = Value(tipoDignidad),
        numeroLista = Value(numeroLista);
  static Insertable<OrganizationsTableData> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? tipoDignidad,
    Expression<int>? numeroLista,
    Expression<String>? color,
    Expression<DateTime>? lastSyncAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (tipoDignidad != null) 'tipo_dignidad': tipoDignidad,
      if (numeroLista != null) 'numero_lista': numeroLista,
      if (color != null) 'color': color,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrganizationsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? nombre,
      Value<String>? tipoDignidad,
      Value<int>? numeroLista,
      Value<String>? color,
      Value<DateTime?>? lastSyncAt,
      Value<int>? rowid}) {
    return OrganizationsTableCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tipoDignidad: tipoDignidad ?? this.tipoDignidad,
      numeroLista: numeroLista ?? this.numeroLista,
      color: color ?? this.color,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (tipoDignidad.present) {
      map['tipo_dignidad'] = Variable<String>(tipoDignidad.value);
    }
    if (numeroLista.present) {
      map['numero_lista'] = Variable<int>(numeroLista.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrganizationsTableCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipoDignidad: $tipoDignidad, ')
          ..write('numeroLista: $numeroLista, ')
          ..write('color: $color, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CandidatesTableTable extends CandidatesTable
    with TableInfo<$CandidatesTableTable, CandidatesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CandidatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _organizationIdMeta =
      const VerificationMeta('organizationId');
  @override
  late final GeneratedColumn<String> organizationId = GeneratedColumn<String>(
      'organization_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES political_organizations (id)'));
  static const VerificationMeta _tipoDignidadMeta =
      const VerificationMeta('tipoDignidad');
  @override
  late final GeneratedColumn<String> tipoDignidad = GeneratedColumn<String>(
      'tipo_dignidad', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastSyncAtMeta =
      const VerificationMeta('lastSyncAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncAt = GeneratedColumn<DateTime>(
      'last_sync_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nombre, organizationId, tipoDignidad, lastSyncAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'candidates';
  @override
  VerificationContext validateIntegrity(
      Insertable<CandidatesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('organization_id')) {
      context.handle(
          _organizationIdMeta,
          organizationId.isAcceptableOrUnknown(
              data['organization_id']!, _organizationIdMeta));
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('tipo_dignidad')) {
      context.handle(
          _tipoDignidadMeta,
          tipoDignidad.isAcceptableOrUnknown(
              data['tipo_dignidad']!, _tipoDignidadMeta));
    } else if (isInserting) {
      context.missing(_tipoDignidadMeta);
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
          _lastSyncAtMeta,
          lastSyncAt.isAcceptableOrUnknown(
              data['last_sync_at']!, _lastSyncAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CandidatesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CandidatesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      organizationId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}organization_id'])!,
      tipoDignidad: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo_dignidad'])!,
      lastSyncAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync_at']),
    );
  }

  @override
  $CandidatesTableTable createAlias(String alias) {
    return $CandidatesTableTable(attachedDatabase, alias);
  }
}

class CandidatesTableData extends DataClass
    implements Insertable<CandidatesTableData> {
  final String id;
  final String nombre;
  final String organizationId;

  /// alcalde | prefecto
  final String tipoDignidad;
  final DateTime? lastSyncAt;
  const CandidatesTableData(
      {required this.id,
      required this.nombre,
      required this.organizationId,
      required this.tipoDignidad,
      this.lastSyncAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    map['organization_id'] = Variable<String>(organizationId);
    map['tipo_dignidad'] = Variable<String>(tipoDignidad);
    if (!nullToAbsent || lastSyncAt != null) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt);
    }
    return map;
  }

  CandidatesTableCompanion toCompanion(bool nullToAbsent) {
    return CandidatesTableCompanion(
      id: Value(id),
      nombre: Value(nombre),
      organizationId: Value(organizationId),
      tipoDignidad: Value(tipoDignidad),
      lastSyncAt: lastSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAt),
    );
  }

  factory CandidatesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CandidatesTableData(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      organizationId: serializer.fromJson<String>(json['organizationId']),
      tipoDignidad: serializer.fromJson<String>(json['tipoDignidad']),
      lastSyncAt: serializer.fromJson<DateTime?>(json['lastSyncAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'organizationId': serializer.toJson<String>(organizationId),
      'tipoDignidad': serializer.toJson<String>(tipoDignidad),
      'lastSyncAt': serializer.toJson<DateTime?>(lastSyncAt),
    };
  }

  CandidatesTableData copyWith(
          {String? id,
          String? nombre,
          String? organizationId,
          String? tipoDignidad,
          Value<DateTime?> lastSyncAt = const Value.absent()}) =>
      CandidatesTableData(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        organizationId: organizationId ?? this.organizationId,
        tipoDignidad: tipoDignidad ?? this.tipoDignidad,
        lastSyncAt: lastSyncAt.present ? lastSyncAt.value : this.lastSyncAt,
      );
  CandidatesTableData copyWithCompanion(CandidatesTableCompanion data) {
    return CandidatesTableData(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      organizationId: data.organizationId.present
          ? data.organizationId.value
          : this.organizationId,
      tipoDignidad: data.tipoDignidad.present
          ? data.tipoDignidad.value
          : this.tipoDignidad,
      lastSyncAt:
          data.lastSyncAt.present ? data.lastSyncAt.value : this.lastSyncAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CandidatesTableData(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('organizationId: $organizationId, ')
          ..write('tipoDignidad: $tipoDignidad, ')
          ..write('lastSyncAt: $lastSyncAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, organizationId, tipoDignidad, lastSyncAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CandidatesTableData &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.organizationId == this.organizationId &&
          other.tipoDignidad == this.tipoDignidad &&
          other.lastSyncAt == this.lastSyncAt);
}

class CandidatesTableCompanion extends UpdateCompanion<CandidatesTableData> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String> organizationId;
  final Value<String> tipoDignidad;
  final Value<DateTime?> lastSyncAt;
  final Value<int> rowid;
  const CandidatesTableCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.tipoDignidad = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CandidatesTableCompanion.insert({
    required String id,
    required String nombre,
    required String organizationId,
    required String tipoDignidad,
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nombre = Value(nombre),
        organizationId = Value(organizationId),
        tipoDignidad = Value(tipoDignidad);
  static Insertable<CandidatesTableData> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? organizationId,
    Expression<String>? tipoDignidad,
    Expression<DateTime>? lastSyncAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (organizationId != null) 'organization_id': organizationId,
      if (tipoDignidad != null) 'tipo_dignidad': tipoDignidad,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CandidatesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? nombre,
      Value<String>? organizationId,
      Value<String>? tipoDignidad,
      Value<DateTime?>? lastSyncAt,
      Value<int>? rowid}) {
    return CandidatesTableCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      organizationId: organizationId ?? this.organizationId,
      tipoDignidad: tipoDignidad ?? this.tipoDignidad,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<String>(organizationId.value);
    }
    if (tipoDignidad.present) {
      map['tipo_dignidad'] = Variable<String>(tipoDignidad.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CandidatesTableCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('organizationId: $organizationId, ')
          ..write('tipoDignidad: $tipoDignidad, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActsTableTable extends ActsTable
    with TableInfo<$ActsTableTable, ActsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tableIdMeta =
      const VerificationMeta('tableId');
  @override
  late final GeneratedColumn<String> tableId = GeneratedColumn<String>(
      'table_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES electoral_tables (id)'));
  static const VerificationMeta _tipoDignidadMeta =
      const VerificationMeta('tipoDignidad');
  @override
  late final GeneratedColumn<String> tipoDignidad = GeneratedColumn<String>(
      'tipo_dignidad', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _photoUrlMeta =
      const VerificationMeta('photoUrl');
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
      'photo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _localPhotoPathMeta =
      const VerificationMeta('localPhotoPath');
  @override
  late final GeneratedColumn<String> localPhotoPath = GeneratedColumn<String>(
      'local_photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _gpsLatitudeMeta =
      const VerificationMeta('gpsLatitude');
  @override
  late final GeneratedColumn<double> gpsLatitude = GeneratedColumn<double>(
      'gps_latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _gpsLongitudeMeta =
      const VerificationMeta('gpsLongitude');
  @override
  late final GeneratedColumn<double> gpsLongitude = GeneratedColumn<double>(
      'gps_longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('borrador'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastSyncAtMeta =
      const VerificationMeta('lastSyncAt');
  @override
  late final GeneratedColumn<DateTime> lastSyncAt = GeneratedColumn<DateTime>(
      'last_sync_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tableId,
        tipoDignidad,
        photoUrl,
        localPhotoPath,
        gpsLatitude,
        gpsLongitude,
        estado,
        createdAt,
        updatedAt,
        lastSyncAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'electoral_acts';
  @override
  VerificationContext validateIntegrity(Insertable<ActsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('table_id')) {
      context.handle(_tableIdMeta,
          tableId.isAcceptableOrUnknown(data['table_id']!, _tableIdMeta));
    } else if (isInserting) {
      context.missing(_tableIdMeta);
    }
    if (data.containsKey('tipo_dignidad')) {
      context.handle(
          _tipoDignidadMeta,
          tipoDignidad.isAcceptableOrUnknown(
              data['tipo_dignidad']!, _tipoDignidadMeta));
    } else if (isInserting) {
      context.missing(_tipoDignidadMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(_photoUrlMeta,
          photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta));
    }
    if (data.containsKey('local_photo_path')) {
      context.handle(
          _localPhotoPathMeta,
          localPhotoPath.isAcceptableOrUnknown(
              data['local_photo_path']!, _localPhotoPathMeta));
    }
    if (data.containsKey('gps_latitude')) {
      context.handle(
          _gpsLatitudeMeta,
          gpsLatitude.isAcceptableOrUnknown(
              data['gps_latitude']!, _gpsLatitudeMeta));
    }
    if (data.containsKey('gps_longitude')) {
      context.handle(
          _gpsLongitudeMeta,
          gpsLongitude.isAcceptableOrUnknown(
              data['gps_longitude']!, _gpsLongitudeMeta));
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('last_sync_at')) {
      context.handle(
          _lastSyncAtMeta,
          lastSyncAt.isAcceptableOrUnknown(
              data['last_sync_at']!, _lastSyncAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tableId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}table_id'])!,
      tipoDignidad: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo_dignidad'])!,
      photoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_url']),
      localPhotoPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}local_photo_path']),
      gpsLatitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_latitude']),
      gpsLongitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}gps_longitude']),
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      lastSyncAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync_at']),
    );
  }

  @override
  $ActsTableTable createAlias(String alias) {
    return $ActsTableTable(attachedDatabase, alias);
  }
}

class ActsTableData extends DataClass implements Insertable<ActsTableData> {
  final String id;
  final String tableId;

  /// alcalde | prefecto
  final String tipoDignidad;

  /// URL de la foto del acta en Appwrite Storage (null si aún no subida).
  final String? photoUrl;

  /// Ruta local de la foto pendiente de subir.
  final String? localPhotoPath;

  /// Coordenada GPS — latitud.
  final double? gpsLatitude;

  /// Coordenada GPS — longitud.
  final double? gpsLongitude;

  /// Estado: borrador | guardado | sincronizado
  final String estado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastSyncAt;
  const ActsTableData(
      {required this.id,
      required this.tableId,
      required this.tipoDignidad,
      this.photoUrl,
      this.localPhotoPath,
      this.gpsLatitude,
      this.gpsLongitude,
      required this.estado,
      required this.createdAt,
      required this.updatedAt,
      this.lastSyncAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['table_id'] = Variable<String>(tableId);
    map['tipo_dignidad'] = Variable<String>(tipoDignidad);
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || localPhotoPath != null) {
      map['local_photo_path'] = Variable<String>(localPhotoPath);
    }
    if (!nullToAbsent || gpsLatitude != null) {
      map['gps_latitude'] = Variable<double>(gpsLatitude);
    }
    if (!nullToAbsent || gpsLongitude != null) {
      map['gps_longitude'] = Variable<double>(gpsLongitude);
    }
    map['estado'] = Variable<String>(estado);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || lastSyncAt != null) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt);
    }
    return map;
  }

  ActsTableCompanion toCompanion(bool nullToAbsent) {
    return ActsTableCompanion(
      id: Value(id),
      tableId: Value(tableId),
      tipoDignidad: Value(tipoDignidad),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      localPhotoPath: localPhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPhotoPath),
      gpsLatitude: gpsLatitude == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLatitude),
      gpsLongitude: gpsLongitude == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLongitude),
      estado: Value(estado),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      lastSyncAt: lastSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncAt),
    );
  }

  factory ActsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActsTableData(
      id: serializer.fromJson<String>(json['id']),
      tableId: serializer.fromJson<String>(json['tableId']),
      tipoDignidad: serializer.fromJson<String>(json['tipoDignidad']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      localPhotoPath: serializer.fromJson<String?>(json['localPhotoPath']),
      gpsLatitude: serializer.fromJson<double?>(json['gpsLatitude']),
      gpsLongitude: serializer.fromJson<double?>(json['gpsLongitude']),
      estado: serializer.fromJson<String>(json['estado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      lastSyncAt: serializer.fromJson<DateTime?>(json['lastSyncAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tableId': serializer.toJson<String>(tableId),
      'tipoDignidad': serializer.toJson<String>(tipoDignidad),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'localPhotoPath': serializer.toJson<String?>(localPhotoPath),
      'gpsLatitude': serializer.toJson<double?>(gpsLatitude),
      'gpsLongitude': serializer.toJson<double?>(gpsLongitude),
      'estado': serializer.toJson<String>(estado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'lastSyncAt': serializer.toJson<DateTime?>(lastSyncAt),
    };
  }

  ActsTableData copyWith(
          {String? id,
          String? tableId,
          String? tipoDignidad,
          Value<String?> photoUrl = const Value.absent(),
          Value<String?> localPhotoPath = const Value.absent(),
          Value<double?> gpsLatitude = const Value.absent(),
          Value<double?> gpsLongitude = const Value.absent(),
          String? estado,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> lastSyncAt = const Value.absent()}) =>
      ActsTableData(
        id: id ?? this.id,
        tableId: tableId ?? this.tableId,
        tipoDignidad: tipoDignidad ?? this.tipoDignidad,
        photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
        localPhotoPath:
            localPhotoPath.present ? localPhotoPath.value : this.localPhotoPath,
        gpsLatitude: gpsLatitude.present ? gpsLatitude.value : this.gpsLatitude,
        gpsLongitude:
            gpsLongitude.present ? gpsLongitude.value : this.gpsLongitude,
        estado: estado ?? this.estado,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        lastSyncAt: lastSyncAt.present ? lastSyncAt.value : this.lastSyncAt,
      );
  ActsTableData copyWithCompanion(ActsTableCompanion data) {
    return ActsTableData(
      id: data.id.present ? data.id.value : this.id,
      tableId: data.tableId.present ? data.tableId.value : this.tableId,
      tipoDignidad: data.tipoDignidad.present
          ? data.tipoDignidad.value
          : this.tipoDignidad,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      localPhotoPath: data.localPhotoPath.present
          ? data.localPhotoPath.value
          : this.localPhotoPath,
      gpsLatitude:
          data.gpsLatitude.present ? data.gpsLatitude.value : this.gpsLatitude,
      gpsLongitude: data.gpsLongitude.present
          ? data.gpsLongitude.value
          : this.gpsLongitude,
      estado: data.estado.present ? data.estado.value : this.estado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      lastSyncAt:
          data.lastSyncAt.present ? data.lastSyncAt.value : this.lastSyncAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActsTableData(')
          ..write('id: $id, ')
          ..write('tableId: $tableId, ')
          ..write('tipoDignidad: $tipoDignidad, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('localPhotoPath: $localPhotoPath, ')
          ..write('gpsLatitude: $gpsLatitude, ')
          ..write('gpsLongitude: $gpsLongitude, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncAt: $lastSyncAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tableId,
      tipoDignidad,
      photoUrl,
      localPhotoPath,
      gpsLatitude,
      gpsLongitude,
      estado,
      createdAt,
      updatedAt,
      lastSyncAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActsTableData &&
          other.id == this.id &&
          other.tableId == this.tableId &&
          other.tipoDignidad == this.tipoDignidad &&
          other.photoUrl == this.photoUrl &&
          other.localPhotoPath == this.localPhotoPath &&
          other.gpsLatitude == this.gpsLatitude &&
          other.gpsLongitude == this.gpsLongitude &&
          other.estado == this.estado &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.lastSyncAt == this.lastSyncAt);
}

class ActsTableCompanion extends UpdateCompanion<ActsTableData> {
  final Value<String> id;
  final Value<String> tableId;
  final Value<String> tipoDignidad;
  final Value<String?> photoUrl;
  final Value<String?> localPhotoPath;
  final Value<double?> gpsLatitude;
  final Value<double?> gpsLongitude;
  final Value<String> estado;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> lastSyncAt;
  final Value<int> rowid;
  const ActsTableCompanion({
    this.id = const Value.absent(),
    this.tableId = const Value.absent(),
    this.tipoDignidad = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.localPhotoPath = const Value.absent(),
    this.gpsLatitude = const Value.absent(),
    this.gpsLongitude = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActsTableCompanion.insert({
    required String id,
    required String tableId,
    required String tipoDignidad,
    this.photoUrl = const Value.absent(),
    this.localPhotoPath = const Value.absent(),
    this.gpsLatitude = const Value.absent(),
    this.gpsLongitude = const Value.absent(),
    this.estado = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.lastSyncAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tableId = Value(tableId),
        tipoDignidad = Value(tipoDignidad);
  static Insertable<ActsTableData> custom({
    Expression<String>? id,
    Expression<String>? tableId,
    Expression<String>? tipoDignidad,
    Expression<String>? photoUrl,
    Expression<String>? localPhotoPath,
    Expression<double>? gpsLatitude,
    Expression<double>? gpsLongitude,
    Expression<String>? estado,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? lastSyncAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tableId != null) 'table_id': tableId,
      if (tipoDignidad != null) 'tipo_dignidad': tipoDignidad,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (localPhotoPath != null) 'local_photo_path': localPhotoPath,
      if (gpsLatitude != null) 'gps_latitude': gpsLatitude,
      if (gpsLongitude != null) 'gps_longitude': gpsLongitude,
      if (estado != null) 'estado': estado,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (lastSyncAt != null) 'last_sync_at': lastSyncAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? tableId,
      Value<String>? tipoDignidad,
      Value<String?>? photoUrl,
      Value<String?>? localPhotoPath,
      Value<double?>? gpsLatitude,
      Value<double?>? gpsLongitude,
      Value<String>? estado,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? lastSyncAt,
      Value<int>? rowid}) {
    return ActsTableCompanion(
      id: id ?? this.id,
      tableId: tableId ?? this.tableId,
      tipoDignidad: tipoDignidad ?? this.tipoDignidad,
      photoUrl: photoUrl ?? this.photoUrl,
      localPhotoPath: localPhotoPath ?? this.localPhotoPath,
      gpsLatitude: gpsLatitude ?? this.gpsLatitude,
      gpsLongitude: gpsLongitude ?? this.gpsLongitude,
      estado: estado ?? this.estado,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tableId.present) {
      map['table_id'] = Variable<String>(tableId.value);
    }
    if (tipoDignidad.present) {
      map['tipo_dignidad'] = Variable<String>(tipoDignidad.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (localPhotoPath.present) {
      map['local_photo_path'] = Variable<String>(localPhotoPath.value);
    }
    if (gpsLatitude.present) {
      map['gps_latitude'] = Variable<double>(gpsLatitude.value);
    }
    if (gpsLongitude.present) {
      map['gps_longitude'] = Variable<double>(gpsLongitude.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (lastSyncAt.present) {
      map['last_sync_at'] = Variable<DateTime>(lastSyncAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActsTableCompanion(')
          ..write('id: $id, ')
          ..write('tableId: $tableId, ')
          ..write('tipoDignidad: $tipoDignidad, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('localPhotoPath: $localPhotoPath, ')
          ..write('gpsLatitude: $gpsLatitude, ')
          ..write('gpsLongitude: $gpsLongitude, ')
          ..write('estado: $estado, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('lastSyncAt: $lastSyncAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VotesTableTable extends VotesTable
    with TableInfo<$VotesTableTable, VotesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VotesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actIdMeta = const VerificationMeta('actId');
  @override
  late final GeneratedColumn<String> actId = GeneratedColumn<String>(
      'act_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES electoral_acts (id)'));
  static const VerificationMeta _candidateIdMeta =
      const VerificationMeta('candidateId');
  @override
  late final GeneratedColumn<String> candidateId = GeneratedColumn<String>(
      'candidate_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES candidates (id)'));
  static const VerificationMeta _cantidadVotosMeta =
      const VerificationMeta('cantidadVotos');
  @override
  late final GeneratedColumn<int> cantidadVotos = GeneratedColumn<int>(
      'cantidad_votos', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, actId, candidateId, cantidadVotos, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'votes';
  @override
  VerificationContext validateIntegrity(Insertable<VotesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('act_id')) {
      context.handle(
          _actIdMeta, actId.isAcceptableOrUnknown(data['act_id']!, _actIdMeta));
    } else if (isInserting) {
      context.missing(_actIdMeta);
    }
    if (data.containsKey('candidate_id')) {
      context.handle(
          _candidateIdMeta,
          candidateId.isAcceptableOrUnknown(
              data['candidate_id']!, _candidateIdMeta));
    } else if (isInserting) {
      context.missing(_candidateIdMeta);
    }
    if (data.containsKey('cantidad_votos')) {
      context.handle(
          _cantidadVotosMeta,
          cantidadVotos.isAcceptableOrUnknown(
              data['cantidad_votos']!, _cantidadVotosMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VotesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VotesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      actId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}act_id'])!,
      candidateId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}candidate_id'])!,
      cantidadVotos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad_votos'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $VotesTableTable createAlias(String alias) {
    return $VotesTableTable(attachedDatabase, alias);
  }
}

class VotesTableData extends DataClass implements Insertable<VotesTableData> {
  final String id;
  final String actId;
  final String candidateId;
  final int cantidadVotos;
  final DateTime updatedAt;
  const VotesTableData(
      {required this.id,
      required this.actId,
      required this.candidateId,
      required this.cantidadVotos,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['act_id'] = Variable<String>(actId);
    map['candidate_id'] = Variable<String>(candidateId);
    map['cantidad_votos'] = Variable<int>(cantidadVotos);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VotesTableCompanion toCompanion(bool nullToAbsent) {
    return VotesTableCompanion(
      id: Value(id),
      actId: Value(actId),
      candidateId: Value(candidateId),
      cantidadVotos: Value(cantidadVotos),
      updatedAt: Value(updatedAt),
    );
  }

  factory VotesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VotesTableData(
      id: serializer.fromJson<String>(json['id']),
      actId: serializer.fromJson<String>(json['actId']),
      candidateId: serializer.fromJson<String>(json['candidateId']),
      cantidadVotos: serializer.fromJson<int>(json['cantidadVotos']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'actId': serializer.toJson<String>(actId),
      'candidateId': serializer.toJson<String>(candidateId),
      'cantidadVotos': serializer.toJson<int>(cantidadVotos),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  VotesTableData copyWith(
          {String? id,
          String? actId,
          String? candidateId,
          int? cantidadVotos,
          DateTime? updatedAt}) =>
      VotesTableData(
        id: id ?? this.id,
        actId: actId ?? this.actId,
        candidateId: candidateId ?? this.candidateId,
        cantidadVotos: cantidadVotos ?? this.cantidadVotos,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  VotesTableData copyWithCompanion(VotesTableCompanion data) {
    return VotesTableData(
      id: data.id.present ? data.id.value : this.id,
      actId: data.actId.present ? data.actId.value : this.actId,
      candidateId:
          data.candidateId.present ? data.candidateId.value : this.candidateId,
      cantidadVotos: data.cantidadVotos.present
          ? data.cantidadVotos.value
          : this.cantidadVotos,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VotesTableData(')
          ..write('id: $id, ')
          ..write('actId: $actId, ')
          ..write('candidateId: $candidateId, ')
          ..write('cantidadVotos: $cantidadVotos, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, actId, candidateId, cantidadVotos, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VotesTableData &&
          other.id == this.id &&
          other.actId == this.actId &&
          other.candidateId == this.candidateId &&
          other.cantidadVotos == this.cantidadVotos &&
          other.updatedAt == this.updatedAt);
}

class VotesTableCompanion extends UpdateCompanion<VotesTableData> {
  final Value<String> id;
  final Value<String> actId;
  final Value<String> candidateId;
  final Value<int> cantidadVotos;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const VotesTableCompanion({
    this.id = const Value.absent(),
    this.actId = const Value.absent(),
    this.candidateId = const Value.absent(),
    this.cantidadVotos = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VotesTableCompanion.insert({
    required String id,
    required String actId,
    required String candidateId,
    this.cantidadVotos = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        actId = Value(actId),
        candidateId = Value(candidateId);
  static Insertable<VotesTableData> custom({
    Expression<String>? id,
    Expression<String>? actId,
    Expression<String>? candidateId,
    Expression<int>? cantidadVotos,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (actId != null) 'act_id': actId,
      if (candidateId != null) 'candidate_id': candidateId,
      if (cantidadVotos != null) 'cantidad_votos': cantidadVotos,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VotesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? actId,
      Value<String>? candidateId,
      Value<int>? cantidadVotos,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return VotesTableCompanion(
      id: id ?? this.id,
      actId: actId ?? this.actId,
      candidateId: candidateId ?? this.candidateId,
      cantidadVotos: cantidadVotos ?? this.cantidadVotos,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (actId.present) {
      map['act_id'] = Variable<String>(actId.value);
    }
    if (candidateId.present) {
      map['candidate_id'] = Variable<String>(candidateId.value);
    }
    if (cantidadVotos.present) {
      map['cantidad_votos'] = Variable<int>(cantidadVotos.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VotesTableCompanion(')
          ..write('id: $id, ')
          ..write('actId: $actId, ')
          ..write('candidateId: $candidateId, ')
          ..write('cantidadVotos: $cantidadVotos, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExtraVotesTableTable extends ExtraVotesTable
    with TableInfo<$ExtraVotesTableTable, ExtraVotesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExtraVotesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actIdMeta = const VerificationMeta('actId');
  @override
  late final GeneratedColumn<String> actId = GeneratedColumn<String>(
      'act_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES electoral_acts (id)'));
  static const VerificationMeta _votosBlancosMeta =
      const VerificationMeta('votosBlancos');
  @override
  late final GeneratedColumn<int> votosBlancos = GeneratedColumn<int>(
      'votos_blancos', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _votosNulosMeta =
      const VerificationMeta('votosNulos');
  @override
  late final GeneratedColumn<int> votosNulos = GeneratedColumn<int>(
      'votos_nulos', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalSufragantesMeta =
      const VerificationMeta('totalSufragantes');
  @override
  late final GeneratedColumn<int> totalSufragantes = GeneratedColumn<int>(
      'total_sufragantes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, actId, votosBlancos, votosNulos, totalSufragantes, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'extra_votes';
  @override
  VerificationContext validateIntegrity(
      Insertable<ExtraVotesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('act_id')) {
      context.handle(
          _actIdMeta, actId.isAcceptableOrUnknown(data['act_id']!, _actIdMeta));
    } else if (isInserting) {
      context.missing(_actIdMeta);
    }
    if (data.containsKey('votos_blancos')) {
      context.handle(
          _votosBlancosMeta,
          votosBlancos.isAcceptableOrUnknown(
              data['votos_blancos']!, _votosBlancosMeta));
    }
    if (data.containsKey('votos_nulos')) {
      context.handle(
          _votosNulosMeta,
          votosNulos.isAcceptableOrUnknown(
              data['votos_nulos']!, _votosNulosMeta));
    }
    if (data.containsKey('total_sufragantes')) {
      context.handle(
          _totalSufragantesMeta,
          totalSufragantes.isAcceptableOrUnknown(
              data['total_sufragantes']!, _totalSufragantesMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExtraVotesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExtraVotesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      actId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}act_id'])!,
      votosBlancos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}votos_blancos'])!,
      votosNulos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}votos_nulos'])!,
      totalSufragantes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_sufragantes'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ExtraVotesTableTable createAlias(String alias) {
    return $ExtraVotesTableTable(attachedDatabase, alias);
  }
}

class ExtraVotesTableData extends DataClass
    implements Insertable<ExtraVotesTableData> {
  final String id;
  final String actId;
  final int votosBlancos;
  final int votosNulos;
  final int totalSufragantes;
  final DateTime updatedAt;
  const ExtraVotesTableData(
      {required this.id,
      required this.actId,
      required this.votosBlancos,
      required this.votosNulos,
      required this.totalSufragantes,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['act_id'] = Variable<String>(actId);
    map['votos_blancos'] = Variable<int>(votosBlancos);
    map['votos_nulos'] = Variable<int>(votosNulos);
    map['total_sufragantes'] = Variable<int>(totalSufragantes);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExtraVotesTableCompanion toCompanion(bool nullToAbsent) {
    return ExtraVotesTableCompanion(
      id: Value(id),
      actId: Value(actId),
      votosBlancos: Value(votosBlancos),
      votosNulos: Value(votosNulos),
      totalSufragantes: Value(totalSufragantes),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExtraVotesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExtraVotesTableData(
      id: serializer.fromJson<String>(json['id']),
      actId: serializer.fromJson<String>(json['actId']),
      votosBlancos: serializer.fromJson<int>(json['votosBlancos']),
      votosNulos: serializer.fromJson<int>(json['votosNulos']),
      totalSufragantes: serializer.fromJson<int>(json['totalSufragantes']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'actId': serializer.toJson<String>(actId),
      'votosBlancos': serializer.toJson<int>(votosBlancos),
      'votosNulos': serializer.toJson<int>(votosNulos),
      'totalSufragantes': serializer.toJson<int>(totalSufragantes),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExtraVotesTableData copyWith(
          {String? id,
          String? actId,
          int? votosBlancos,
          int? votosNulos,
          int? totalSufragantes,
          DateTime? updatedAt}) =>
      ExtraVotesTableData(
        id: id ?? this.id,
        actId: actId ?? this.actId,
        votosBlancos: votosBlancos ?? this.votosBlancos,
        votosNulos: votosNulos ?? this.votosNulos,
        totalSufragantes: totalSufragantes ?? this.totalSufragantes,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ExtraVotesTableData copyWithCompanion(ExtraVotesTableCompanion data) {
    return ExtraVotesTableData(
      id: data.id.present ? data.id.value : this.id,
      actId: data.actId.present ? data.actId.value : this.actId,
      votosBlancos: data.votosBlancos.present
          ? data.votosBlancos.value
          : this.votosBlancos,
      votosNulos:
          data.votosNulos.present ? data.votosNulos.value : this.votosNulos,
      totalSufragantes: data.totalSufragantes.present
          ? data.totalSufragantes.value
          : this.totalSufragantes,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExtraVotesTableData(')
          ..write('id: $id, ')
          ..write('actId: $actId, ')
          ..write('votosBlancos: $votosBlancos, ')
          ..write('votosNulos: $votosNulos, ')
          ..write('totalSufragantes: $totalSufragantes, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, actId, votosBlancos, votosNulos, totalSufragantes, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExtraVotesTableData &&
          other.id == this.id &&
          other.actId == this.actId &&
          other.votosBlancos == this.votosBlancos &&
          other.votosNulos == this.votosNulos &&
          other.totalSufragantes == this.totalSufragantes &&
          other.updatedAt == this.updatedAt);
}

class ExtraVotesTableCompanion extends UpdateCompanion<ExtraVotesTableData> {
  final Value<String> id;
  final Value<String> actId;
  final Value<int> votosBlancos;
  final Value<int> votosNulos;
  final Value<int> totalSufragantes;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ExtraVotesTableCompanion({
    this.id = const Value.absent(),
    this.actId = const Value.absent(),
    this.votosBlancos = const Value.absent(),
    this.votosNulos = const Value.absent(),
    this.totalSufragantes = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExtraVotesTableCompanion.insert({
    required String id,
    required String actId,
    this.votosBlancos = const Value.absent(),
    this.votosNulos = const Value.absent(),
    this.totalSufragantes = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        actId = Value(actId);
  static Insertable<ExtraVotesTableData> custom({
    Expression<String>? id,
    Expression<String>? actId,
    Expression<int>? votosBlancos,
    Expression<int>? votosNulos,
    Expression<int>? totalSufragantes,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (actId != null) 'act_id': actId,
      if (votosBlancos != null) 'votos_blancos': votosBlancos,
      if (votosNulos != null) 'votos_nulos': votosNulos,
      if (totalSufragantes != null) 'total_sufragantes': totalSufragantes,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExtraVotesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? actId,
      Value<int>? votosBlancos,
      Value<int>? votosNulos,
      Value<int>? totalSufragantes,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ExtraVotesTableCompanion(
      id: id ?? this.id,
      actId: actId ?? this.actId,
      votosBlancos: votosBlancos ?? this.votosBlancos,
      votosNulos: votosNulos ?? this.votosNulos,
      totalSufragantes: totalSufragantes ?? this.totalSufragantes,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (actId.present) {
      map['act_id'] = Variable<String>(actId.value);
    }
    if (votosBlancos.present) {
      map['votos_blancos'] = Variable<int>(votosBlancos.value);
    }
    if (votosNulos.present) {
      map['votos_nulos'] = Variable<int>(votosNulos.value);
    }
    if (totalSufragantes.present) {
      map['total_sufragantes'] = Variable<int>(totalSufragantes.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExtraVotesTableCompanion(')
          ..write('id: $id, ')
          ..write('actId: $actId, ')
          ..write('votosBlancos: $votosBlancos, ')
          ..write('votosNulos: $votosNulos, ')
          ..write('totalSufragantes: $totalSufragantes, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OfflineQueueTableTable extends OfflineQueueTable
    with TableInfo<$OfflineQueueTableTable, OfflineQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfflineQueueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _collectionNameMeta =
      const VerificationMeta('collectionName');
  @override
  late final GeneratedColumn<String> collectionName = GeneratedColumn<String>(
      'collection_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _documentIdMeta =
      const VerificationMeta('documentId');
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
      'document_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastErrorMeta =
      const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
      'last_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        operation,
        collectionName,
        documentId,
        payload,
        syncStatus,
        retryCount,
        lastError,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'offline_queue';
  @override
  VerificationContext validateIntegrity(
      Insertable<OfflineQueueTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('collection_name')) {
      context.handle(
          _collectionNameMeta,
          collectionName.isAcceptableOrUnknown(
              data['collection_name']!, _collectionNameMeta));
    } else if (isInserting) {
      context.missing(_collectionNameMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
          _documentIdMeta,
          documentId.isAcceptableOrUnknown(
              data['document_id']!, _documentIdMeta));
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta,
          lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OfflineQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OfflineQueueTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      collectionName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}collection_name'])!,
      documentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}document_id'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      lastError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $OfflineQueueTableTable createAlias(String alias) {
    return $OfflineQueueTableTable(attachedDatabase, alias);
  }
}

class OfflineQueueTableData extends DataClass
    implements Insertable<OfflineQueueTableData> {
  /// ID único del registro en la cola.
  final int id;

  /// Tipo de operación: create | update | delete
  final String operation;

  /// Nombre de la colección Appwrite afectada.
  final String collectionName;

  /// ID del documento Appwrite (generado client-side con UUID).
  final String documentId;

  /// Payload JSON con los datos del documento.
  final String payload;

  /// Estado de sincronización.
  final String syncStatus;

  /// Número de intentos fallidos.
  final int retryCount;

  /// Mensaje del último error (para debugging).
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;
  const OfflineQueueTableData(
      {required this.id,
      required this.operation,
      required this.collectionName,
      required this.documentId,
      required this.payload,
      required this.syncStatus,
      required this.retryCount,
      this.lastError,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['operation'] = Variable<String>(operation);
    map['collection_name'] = Variable<String>(collectionName);
    map['document_id'] = Variable<String>(documentId);
    map['payload'] = Variable<String>(payload);
    map['sync_status'] = Variable<String>(syncStatus);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OfflineQueueTableCompanion toCompanion(bool nullToAbsent) {
    return OfflineQueueTableCompanion(
      id: Value(id),
      operation: Value(operation),
      collectionName: Value(collectionName),
      documentId: Value(documentId),
      payload: Value(payload),
      syncStatus: Value(syncStatus),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory OfflineQueueTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OfflineQueueTableData(
      id: serializer.fromJson<int>(json['id']),
      operation: serializer.fromJson<String>(json['operation']),
      collectionName: serializer.fromJson<String>(json['collectionName']),
      documentId: serializer.fromJson<String>(json['documentId']),
      payload: serializer.fromJson<String>(json['payload']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'operation': serializer.toJson<String>(operation),
      'collectionName': serializer.toJson<String>(collectionName),
      'documentId': serializer.toJson<String>(documentId),
      'payload': serializer.toJson<String>(payload),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  OfflineQueueTableData copyWith(
          {int? id,
          String? operation,
          String? collectionName,
          String? documentId,
          String? payload,
          String? syncStatus,
          int? retryCount,
          Value<String?> lastError = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      OfflineQueueTableData(
        id: id ?? this.id,
        operation: operation ?? this.operation,
        collectionName: collectionName ?? this.collectionName,
        documentId: documentId ?? this.documentId,
        payload: payload ?? this.payload,
        syncStatus: syncStatus ?? this.syncStatus,
        retryCount: retryCount ?? this.retryCount,
        lastError: lastError.present ? lastError.value : this.lastError,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  OfflineQueueTableData copyWithCompanion(OfflineQueueTableCompanion data) {
    return OfflineQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      operation: data.operation.present ? data.operation.value : this.operation,
      collectionName: data.collectionName.present
          ? data.collectionName.value
          : this.collectionName,
      documentId:
          data.documentId.present ? data.documentId.value : this.documentId,
      payload: data.payload.present ? data.payload.value : this.payload,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OfflineQueueTableData(')
          ..write('id: $id, ')
          ..write('operation: $operation, ')
          ..write('collectionName: $collectionName, ')
          ..write('documentId: $documentId, ')
          ..write('payload: $payload, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, operation, collectionName, documentId,
      payload, syncStatus, retryCount, lastError, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfflineQueueTableData &&
          other.id == this.id &&
          other.operation == this.operation &&
          other.collectionName == this.collectionName &&
          other.documentId == this.documentId &&
          other.payload == this.payload &&
          other.syncStatus == this.syncStatus &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OfflineQueueTableCompanion
    extends UpdateCompanion<OfflineQueueTableData> {
  final Value<int> id;
  final Value<String> operation;
  final Value<String> collectionName;
  final Value<String> documentId;
  final Value<String> payload;
  final Value<String> syncStatus;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const OfflineQueueTableCompanion({
    this.id = const Value.absent(),
    this.operation = const Value.absent(),
    this.collectionName = const Value.absent(),
    this.documentId = const Value.absent(),
    this.payload = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  OfflineQueueTableCompanion.insert({
    this.id = const Value.absent(),
    required String operation,
    required String collectionName,
    required String documentId,
    required String payload,
    this.syncStatus = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : operation = Value(operation),
        collectionName = Value(collectionName),
        documentId = Value(documentId),
        payload = Value(payload);
  static Insertable<OfflineQueueTableData> custom({
    Expression<int>? id,
    Expression<String>? operation,
    Expression<String>? collectionName,
    Expression<String>? documentId,
    Expression<String>? payload,
    Expression<String>? syncStatus,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operation != null) 'operation': operation,
      if (collectionName != null) 'collection_name': collectionName,
      if (documentId != null) 'document_id': documentId,
      if (payload != null) 'payload': payload,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  OfflineQueueTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? operation,
      Value<String>? collectionName,
      Value<String>? documentId,
      Value<String>? payload,
      Value<String>? syncStatus,
      Value<int>? retryCount,
      Value<String?>? lastError,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return OfflineQueueTableCompanion(
      id: id ?? this.id,
      operation: operation ?? this.operation,
      collectionName: collectionName ?? this.collectionName,
      documentId: documentId ?? this.documentId,
      payload: payload ?? this.payload,
      syncStatus: syncStatus ?? this.syncStatus,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (collectionName.present) {
      map['collection_name'] = Variable<String>(collectionName.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OfflineQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('operation: $operation, ')
          ..write('collectionName: $collectionName, ')
          ..write('documentId: $documentId, ')
          ..write('payload: $payload, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTableTable usersTable = $UsersTableTable(this);
  late final $PrecinctsTableTable precinctsTable = $PrecinctsTableTable(this);
  late final $ElectoralTablesTableTable electoralTablesTable =
      $ElectoralTablesTableTable(this);
  late final $OrganizationsTableTable organizationsTable =
      $OrganizationsTableTable(this);
  late final $CandidatesTableTable candidatesTable =
      $CandidatesTableTable(this);
  late final $ActsTableTable actsTable = $ActsTableTable(this);
  late final $VotesTableTable votesTable = $VotesTableTable(this);
  late final $ExtraVotesTableTable extraVotesTable =
      $ExtraVotesTableTable(this);
  late final $OfflineQueueTableTable offlineQueueTable =
      $OfflineQueueTableTable(this);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final PrecinctsDao precinctsDao = PrecinctsDao(this as AppDatabase);
  late final ActsDao actsDao = ActsDao(this as AppDatabase);
  late final OfflineQueueDao offlineQueueDao =
      OfflineQueueDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        usersTable,
        precinctsTable,
        electoralTablesTable,
        organizationsTable,
        candidatesTable,
        actsTable,
        votesTable,
        extraVotesTable,
        offlineQueueTable
      ];
}

typedef $$UsersTableTableCreateCompanionBuilder = UsersTableCompanion Function({
  required String id,
  required String cedula,
  required String nombres,
  required String apellidos,
  required String telefono,
  required String correo,
  required String rol,
  Value<bool> passwordChanged,
  Value<bool> emailVerified,
  Value<String?> precinctId,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});
typedef $$UsersTableTableUpdateCompanionBuilder = UsersTableCompanion Function({
  Value<String> id,
  Value<String> cedula,
  Value<String> nombres,
  Value<String> apellidos,
  Value<String> telefono,
  Value<String> correo,
  Value<String> rol,
  Value<bool> passwordChanged,
  Value<bool> emailVerified,
  Value<String?> precinctId,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});

final class $$UsersTableTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTableTable, UsersTableData> {
  $$UsersTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PrecinctsTableTable, List<PrecinctsTableData>>
      _precinctsTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.precinctsTable,
              aliasName: $_aliasNameGenerator(
                  db.usersTable.id, db.precinctsTable.coordinadorRecintoId));

  $$PrecinctsTableTableProcessedTableManager get precinctsTableRefs {
    final manager = $$PrecinctsTableTableTableManager($_db, $_db.precinctsTable)
        .filter((f) =>
            f.coordinadorRecintoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_precinctsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ElectoralTablesTableTable,
      List<ElectoralTablesTableData>> _electoralTablesTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.electoralTablesTable,
          aliasName: $_aliasNameGenerator(
              db.usersTable.id, db.electoralTablesTable.veedorId));

  $$ElectoralTablesTableTableProcessedTableManager
      get electoralTablesTableRefs {
    final manager = $$ElectoralTablesTableTableTableManager(
            $_db, $_db.electoralTablesTable)
        .filter((f) => f.veedorId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_electoralTablesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableTableFilterComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cedula => $composableBuilder(
      column: $table.cedula, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombres => $composableBuilder(
      column: $table.nombres, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get apellidos => $composableBuilder(
      column: $table.apellidos, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get correo => $composableBuilder(
      column: $table.correo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rol => $composableBuilder(
      column: $table.rol, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get passwordChanged => $composableBuilder(
      column: $table.passwordChanged,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get emailVerified => $composableBuilder(
      column: $table.emailVerified, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get precinctId => $composableBuilder(
      column: $table.precinctId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnFilters(column));

  Expression<bool> precinctsTableRefs(
      Expression<bool> Function($$PrecinctsTableTableFilterComposer f) f) {
    final $$PrecinctsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.precinctsTable,
        getReferencedColumn: (t) => t.coordinadorRecintoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrecinctsTableTableFilterComposer(
              $db: $db,
              $table: $db.precinctsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> electoralTablesTableRefs(
      Expression<bool> Function($$ElectoralTablesTableTableFilterComposer f)
          f) {
    final $$ElectoralTablesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.electoralTablesTable,
        getReferencedColumn: (t) => t.veedorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ElectoralTablesTableTableFilterComposer(
              $db: $db,
              $table: $db.electoralTablesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cedula => $composableBuilder(
      column: $table.cedula, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombres => $composableBuilder(
      column: $table.nombres, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get apellidos => $composableBuilder(
      column: $table.apellidos, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get correo => $composableBuilder(
      column: $table.correo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rol => $composableBuilder(
      column: $table.rol, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get passwordChanged => $composableBuilder(
      column: $table.passwordChanged,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get emailVerified => $composableBuilder(
      column: $table.emailVerified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get precinctId => $composableBuilder(
      column: $table.precinctId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTableTable> {
  $$UsersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cedula =>
      $composableBuilder(column: $table.cedula, builder: (column) => column);

  GeneratedColumn<String> get nombres =>
      $composableBuilder(column: $table.nombres, builder: (column) => column);

  GeneratedColumn<String> get apellidos =>
      $composableBuilder(column: $table.apellidos, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get correo =>
      $composableBuilder(column: $table.correo, builder: (column) => column);

  GeneratedColumn<String> get rol =>
      $composableBuilder(column: $table.rol, builder: (column) => column);

  GeneratedColumn<bool> get passwordChanged => $composableBuilder(
      column: $table.passwordChanged, builder: (column) => column);

  GeneratedColumn<bool> get emailVerified => $composableBuilder(
      column: $table.emailVerified, builder: (column) => column);

  GeneratedColumn<String> get precinctId => $composableBuilder(
      column: $table.precinctId, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => column);

  Expression<T> precinctsTableRefs<T extends Object>(
      Expression<T> Function($$PrecinctsTableTableAnnotationComposer a) f) {
    final $$PrecinctsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.precinctsTable,
        getReferencedColumn: (t) => t.coordinadorRecintoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrecinctsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.precinctsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> electoralTablesTableRefs<T extends Object>(
      Expression<T> Function($$ElectoralTablesTableTableAnnotationComposer a)
          f) {
    final $$ElectoralTablesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.electoralTablesTable,
            getReferencedColumn: (t) => t.veedorId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ElectoralTablesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.electoralTablesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$UsersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTableTable,
    UsersTableData,
    $$UsersTableTableFilterComposer,
    $$UsersTableTableOrderingComposer,
    $$UsersTableTableAnnotationComposer,
    $$UsersTableTableCreateCompanionBuilder,
    $$UsersTableTableUpdateCompanionBuilder,
    (UsersTableData, $$UsersTableTableReferences),
    UsersTableData,
    PrefetchHooks Function(
        {bool precinctsTableRefs, bool electoralTablesTableRefs})> {
  $$UsersTableTableTableManager(_$AppDatabase db, $UsersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> cedula = const Value.absent(),
            Value<String> nombres = const Value.absent(),
            Value<String> apellidos = const Value.absent(),
            Value<String> telefono = const Value.absent(),
            Value<String> correo = const Value.absent(),
            Value<String> rol = const Value.absent(),
            Value<bool> passwordChanged = const Value.absent(),
            Value<bool> emailVerified = const Value.absent(),
            Value<String?> precinctId = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersTableCompanion(
            id: id,
            cedula: cedula,
            nombres: nombres,
            apellidos: apellidos,
            telefono: telefono,
            correo: correo,
            rol: rol,
            passwordChanged: passwordChanged,
            emailVerified: emailVerified,
            precinctId: precinctId,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String cedula,
            required String nombres,
            required String apellidos,
            required String telefono,
            required String correo,
            required String rol,
            Value<bool> passwordChanged = const Value.absent(),
            Value<bool> emailVerified = const Value.absent(),
            Value<String?> precinctId = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersTableCompanion.insert(
            id: id,
            cedula: cedula,
            nombres: nombres,
            apellidos: apellidos,
            telefono: telefono,
            correo: correo,
            rol: rol,
            passwordChanged: passwordChanged,
            emailVerified: emailVerified,
            precinctId: precinctId,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UsersTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {precinctsTableRefs = false, electoralTablesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (precinctsTableRefs) db.precinctsTable,
                if (electoralTablesTableRefs) db.electoralTablesTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (precinctsTableRefs)
                    await $_getPrefetchedData<UsersTableData, $UsersTableTable,
                            PrecinctsTableData>(
                        currentTable: table,
                        referencedTable: $$UsersTableTableReferences
                            ._precinctsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableTableReferences(db, table, p0)
                                .precinctsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.coordinadorRecintoId == item.id),
                        typedResults: items),
                  if (electoralTablesTableRefs)
                    await $_getPrefetchedData<UsersTableData, $UsersTableTable,
                            ElectoralTablesTableData>(
                        currentTable: table,
                        referencedTable: $$UsersTableTableReferences
                            ._electoralTablesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableTableReferences(db, table, p0)
                                .electoralTablesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.veedorId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTableTable,
    UsersTableData,
    $$UsersTableTableFilterComposer,
    $$UsersTableTableOrderingComposer,
    $$UsersTableTableAnnotationComposer,
    $$UsersTableTableCreateCompanionBuilder,
    $$UsersTableTableUpdateCompanionBuilder,
    (UsersTableData, $$UsersTableTableReferences),
    UsersTableData,
    PrefetchHooks Function(
        {bool precinctsTableRefs, bool electoralTablesTableRefs})>;
typedef $$PrecinctsTableTableCreateCompanionBuilder = PrecinctsTableCompanion
    Function({
  required String id,
  required String provincia,
  required String canton,
  required String parroquia,
  required String nombreRecinto,
  required int numeroJrv,
  Value<String?> coordinadorRecintoId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});
typedef $$PrecinctsTableTableUpdateCompanionBuilder = PrecinctsTableCompanion
    Function({
  Value<String> id,
  Value<String> provincia,
  Value<String> canton,
  Value<String> parroquia,
  Value<String> nombreRecinto,
  Value<int> numeroJrv,
  Value<String?> coordinadorRecintoId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});

final class $$PrecinctsTableTableReferences extends BaseReferences<
    _$AppDatabase, $PrecinctsTableTable, PrecinctsTableData> {
  $$PrecinctsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTableTable _coordinadorRecintoIdTable(_$AppDatabase db) =>
      db.usersTable.createAlias($_aliasNameGenerator(
          db.precinctsTable.coordinadorRecintoId, db.usersTable.id));

  $$UsersTableTableProcessedTableManager? get coordinadorRecintoId {
    final $_column = $_itemColumn<String>('coordinador_recinto_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableTableManager($_db, $_db.usersTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item =
        $_typedResult.readTableOrNull(_coordinadorRecintoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ElectoralTablesTableTable,
      List<ElectoralTablesTableData>> _electoralTablesTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.electoralTablesTable,
          aliasName: $_aliasNameGenerator(
              db.precinctsTable.id, db.electoralTablesTable.precinctId));

  $$ElectoralTablesTableTableProcessedTableManager
      get electoralTablesTableRefs {
    final manager = $$ElectoralTablesTableTableTableManager(
            $_db, $_db.electoralTablesTable)
        .filter((f) => f.precinctId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_electoralTablesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PrecinctsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PrecinctsTableTable> {
  $$PrecinctsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get provincia => $composableBuilder(
      column: $table.provincia, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get canton => $composableBuilder(
      column: $table.canton, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parroquia => $composableBuilder(
      column: $table.parroquia, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombreRecinto => $composableBuilder(
      column: $table.nombreRecinto, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get numeroJrv => $composableBuilder(
      column: $table.numeroJrv, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnFilters(column));

  $$UsersTableTableFilterComposer get coordinadorRecintoId {
    final $$UsersTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.coordinadorRecintoId,
        referencedTable: $db.usersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableTableFilterComposer(
              $db: $db,
              $table: $db.usersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> electoralTablesTableRefs(
      Expression<bool> Function($$ElectoralTablesTableTableFilterComposer f)
          f) {
    final $$ElectoralTablesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.electoralTablesTable,
        getReferencedColumn: (t) => t.precinctId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ElectoralTablesTableTableFilterComposer(
              $db: $db,
              $table: $db.electoralTablesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PrecinctsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PrecinctsTableTable> {
  $$PrecinctsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get provincia => $composableBuilder(
      column: $table.provincia, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get canton => $composableBuilder(
      column: $table.canton, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parroquia => $composableBuilder(
      column: $table.parroquia, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombreRecinto => $composableBuilder(
      column: $table.nombreRecinto,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get numeroJrv => $composableBuilder(
      column: $table.numeroJrv, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableTableOrderingComposer get coordinadorRecintoId {
    final $$UsersTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.coordinadorRecintoId,
        referencedTable: $db.usersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableTableOrderingComposer(
              $db: $db,
              $table: $db.usersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PrecinctsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrecinctsTableTable> {
  $$PrecinctsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get provincia =>
      $composableBuilder(column: $table.provincia, builder: (column) => column);

  GeneratedColumn<String> get canton =>
      $composableBuilder(column: $table.canton, builder: (column) => column);

  GeneratedColumn<String> get parroquia =>
      $composableBuilder(column: $table.parroquia, builder: (column) => column);

  GeneratedColumn<String> get nombreRecinto => $composableBuilder(
      column: $table.nombreRecinto, builder: (column) => column);

  GeneratedColumn<int> get numeroJrv =>
      $composableBuilder(column: $table.numeroJrv, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => column);

  $$UsersTableTableAnnotationComposer get coordinadorRecintoId {
    final $$UsersTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.coordinadorRecintoId,
        referencedTable: $db.usersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableTableAnnotationComposer(
              $db: $db,
              $table: $db.usersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> electoralTablesTableRefs<T extends Object>(
      Expression<T> Function($$ElectoralTablesTableTableAnnotationComposer a)
          f) {
    final $$ElectoralTablesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.electoralTablesTable,
            getReferencedColumn: (t) => t.precinctId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ElectoralTablesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.electoralTablesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PrecinctsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PrecinctsTableTable,
    PrecinctsTableData,
    $$PrecinctsTableTableFilterComposer,
    $$PrecinctsTableTableOrderingComposer,
    $$PrecinctsTableTableAnnotationComposer,
    $$PrecinctsTableTableCreateCompanionBuilder,
    $$PrecinctsTableTableUpdateCompanionBuilder,
    (PrecinctsTableData, $$PrecinctsTableTableReferences),
    PrecinctsTableData,
    PrefetchHooks Function(
        {bool coordinadorRecintoId, bool electoralTablesTableRefs})> {
  $$PrecinctsTableTableTableManager(
      _$AppDatabase db, $PrecinctsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrecinctsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrecinctsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrecinctsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> provincia = const Value.absent(),
            Value<String> canton = const Value.absent(),
            Value<String> parroquia = const Value.absent(),
            Value<String> nombreRecinto = const Value.absent(),
            Value<int> numeroJrv = const Value.absent(),
            Value<String?> coordinadorRecintoId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PrecinctsTableCompanion(
            id: id,
            provincia: provincia,
            canton: canton,
            parroquia: parroquia,
            nombreRecinto: nombreRecinto,
            numeroJrv: numeroJrv,
            coordinadorRecintoId: coordinadorRecintoId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String provincia,
            required String canton,
            required String parroquia,
            required String nombreRecinto,
            required int numeroJrv,
            Value<String?> coordinadorRecintoId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PrecinctsTableCompanion.insert(
            id: id,
            provincia: provincia,
            canton: canton,
            parroquia: parroquia,
            nombreRecinto: nombreRecinto,
            numeroJrv: numeroJrv,
            coordinadorRecintoId: coordinadorRecintoId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PrecinctsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {coordinadorRecintoId = false,
              electoralTablesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (electoralTablesTableRefs) db.electoralTablesTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (coordinadorRecintoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.coordinadorRecintoId,
                    referencedTable: $$PrecinctsTableTableReferences
                        ._coordinadorRecintoIdTable(db),
                    referencedColumn: $$PrecinctsTableTableReferences
                        ._coordinadorRecintoIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (electoralTablesTableRefs)
                    await $_getPrefetchedData<PrecinctsTableData,
                            $PrecinctsTableTable, ElectoralTablesTableData>(
                        currentTable: table,
                        referencedTable: $$PrecinctsTableTableReferences
                            ._electoralTablesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PrecinctsTableTableReferences(db, table, p0)
                                .electoralTablesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.precinctId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PrecinctsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PrecinctsTableTable,
    PrecinctsTableData,
    $$PrecinctsTableTableFilterComposer,
    $$PrecinctsTableTableOrderingComposer,
    $$PrecinctsTableTableAnnotationComposer,
    $$PrecinctsTableTableCreateCompanionBuilder,
    $$PrecinctsTableTableUpdateCompanionBuilder,
    (PrecinctsTableData, $$PrecinctsTableTableReferences),
    PrecinctsTableData,
    PrefetchHooks Function(
        {bool coordinadorRecintoId, bool electoralTablesTableRefs})>;
typedef $$ElectoralTablesTableTableCreateCompanionBuilder
    = ElectoralTablesTableCompanion Function({
  required String id,
  required int jrvNumber,
  required String precinctId,
  Value<String?> veedorId,
  Value<String> estadoActa,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});
typedef $$ElectoralTablesTableTableUpdateCompanionBuilder
    = ElectoralTablesTableCompanion Function({
  Value<String> id,
  Value<int> jrvNumber,
  Value<String> precinctId,
  Value<String?> veedorId,
  Value<String> estadoActa,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});

final class $$ElectoralTablesTableTableReferences extends BaseReferences<
    _$AppDatabase, $ElectoralTablesTableTable, ElectoralTablesTableData> {
  $$ElectoralTablesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PrecinctsTableTable _precinctIdTable(_$AppDatabase db) =>
      db.precinctsTable.createAlias($_aliasNameGenerator(
          db.electoralTablesTable.precinctId, db.precinctsTable.id));

  $$PrecinctsTableTableProcessedTableManager get precinctId {
    final $_column = $_itemColumn<String>('precinct_id')!;

    final manager = $$PrecinctsTableTableTableManager($_db, $_db.precinctsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_precinctIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTableTable _veedorIdTable(_$AppDatabase db) =>
      db.usersTable.createAlias($_aliasNameGenerator(
          db.electoralTablesTable.veedorId, db.usersTable.id));

  $$UsersTableTableProcessedTableManager? get veedorId {
    final $_column = $_itemColumn<String>('veedor_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableTableManager($_db, $_db.usersTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_veedorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ActsTableTable, List<ActsTableData>>
      _actsTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.actsTable,
              aliasName: $_aliasNameGenerator(
                  db.electoralTablesTable.id, db.actsTable.tableId));

  $$ActsTableTableProcessedTableManager get actsTableRefs {
    final manager = $$ActsTableTableTableManager($_db, $_db.actsTable)
        .filter((f) => f.tableId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_actsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ElectoralTablesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ElectoralTablesTableTable> {
  $$ElectoralTablesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get jrvNumber => $composableBuilder(
      column: $table.jrvNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estadoActa => $composableBuilder(
      column: $table.estadoActa, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnFilters(column));

  $$PrecinctsTableTableFilterComposer get precinctId {
    final $$PrecinctsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.precinctId,
        referencedTable: $db.precinctsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrecinctsTableTableFilterComposer(
              $db: $db,
              $table: $db.precinctsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableTableFilterComposer get veedorId {
    final $$UsersTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.veedorId,
        referencedTable: $db.usersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableTableFilterComposer(
              $db: $db,
              $table: $db.usersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> actsTableRefs(
      Expression<bool> Function($$ActsTableTableFilterComposer f) f) {
    final $$ActsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.actsTable,
        getReferencedColumn: (t) => t.tableId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActsTableTableFilterComposer(
              $db: $db,
              $table: $db.actsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ElectoralTablesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ElectoralTablesTableTable> {
  $$ElectoralTablesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get jrvNumber => $composableBuilder(
      column: $table.jrvNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estadoActa => $composableBuilder(
      column: $table.estadoActa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnOrderings(column));

  $$PrecinctsTableTableOrderingComposer get precinctId {
    final $$PrecinctsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.precinctId,
        referencedTable: $db.precinctsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrecinctsTableTableOrderingComposer(
              $db: $db,
              $table: $db.precinctsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableTableOrderingComposer get veedorId {
    final $$UsersTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.veedorId,
        referencedTable: $db.usersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableTableOrderingComposer(
              $db: $db,
              $table: $db.usersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ElectoralTablesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ElectoralTablesTableTable> {
  $$ElectoralTablesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get jrvNumber =>
      $composableBuilder(column: $table.jrvNumber, builder: (column) => column);

  GeneratedColumn<String> get estadoActa => $composableBuilder(
      column: $table.estadoActa, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => column);

  $$PrecinctsTableTableAnnotationComposer get precinctId {
    final $$PrecinctsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.precinctId,
        referencedTable: $db.precinctsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PrecinctsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.precinctsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableTableAnnotationComposer get veedorId {
    final $$UsersTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.veedorId,
        referencedTable: $db.usersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableTableAnnotationComposer(
              $db: $db,
              $table: $db.usersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> actsTableRefs<T extends Object>(
      Expression<T> Function($$ActsTableTableAnnotationComposer a) f) {
    final $$ActsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.actsTable,
        getReferencedColumn: (t) => t.tableId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.actsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ElectoralTablesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ElectoralTablesTableTable,
    ElectoralTablesTableData,
    $$ElectoralTablesTableTableFilterComposer,
    $$ElectoralTablesTableTableOrderingComposer,
    $$ElectoralTablesTableTableAnnotationComposer,
    $$ElectoralTablesTableTableCreateCompanionBuilder,
    $$ElectoralTablesTableTableUpdateCompanionBuilder,
    (ElectoralTablesTableData, $$ElectoralTablesTableTableReferences),
    ElectoralTablesTableData,
    PrefetchHooks Function(
        {bool precinctId, bool veedorId, bool actsTableRefs})> {
  $$ElectoralTablesTableTableTableManager(
      _$AppDatabase db, $ElectoralTablesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ElectoralTablesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ElectoralTablesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ElectoralTablesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> jrvNumber = const Value.absent(),
            Value<String> precinctId = const Value.absent(),
            Value<String?> veedorId = const Value.absent(),
            Value<String> estadoActa = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ElectoralTablesTableCompanion(
            id: id,
            jrvNumber: jrvNumber,
            precinctId: precinctId,
            veedorId: veedorId,
            estadoActa: estadoActa,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int jrvNumber,
            required String precinctId,
            Value<String?> veedorId = const Value.absent(),
            Value<String> estadoActa = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ElectoralTablesTableCompanion.insert(
            id: id,
            jrvNumber: jrvNumber,
            precinctId: precinctId,
            veedorId: veedorId,
            estadoActa: estadoActa,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ElectoralTablesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {precinctId = false, veedorId = false, actsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (actsTableRefs) db.actsTable],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (precinctId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.precinctId,
                    referencedTable: $$ElectoralTablesTableTableReferences
                        ._precinctIdTable(db),
                    referencedColumn: $$ElectoralTablesTableTableReferences
                        ._precinctIdTable(db)
                        .id,
                  ) as T;
                }
                if (veedorId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.veedorId,
                    referencedTable: $$ElectoralTablesTableTableReferences
                        ._veedorIdTable(db),
                    referencedColumn: $$ElectoralTablesTableTableReferences
                        ._veedorIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (actsTableRefs)
                    await $_getPrefetchedData<ElectoralTablesTableData,
                            $ElectoralTablesTableTable, ActsTableData>(
                        currentTable: table,
                        referencedTable: $$ElectoralTablesTableTableReferences
                            ._actsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ElectoralTablesTableTableReferences(db, table, p0)
                                .actsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tableId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ElectoralTablesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $ElectoralTablesTableTable,
        ElectoralTablesTableData,
        $$ElectoralTablesTableTableFilterComposer,
        $$ElectoralTablesTableTableOrderingComposer,
        $$ElectoralTablesTableTableAnnotationComposer,
        $$ElectoralTablesTableTableCreateCompanionBuilder,
        $$ElectoralTablesTableTableUpdateCompanionBuilder,
        (ElectoralTablesTableData, $$ElectoralTablesTableTableReferences),
        ElectoralTablesTableData,
        PrefetchHooks Function(
            {bool precinctId, bool veedorId, bool actsTableRefs})>;
typedef $$OrganizationsTableTableCreateCompanionBuilder
    = OrganizationsTableCompanion Function({
  required String id,
  required String nombre,
  required String tipoDignidad,
  required int numeroLista,
  Value<String> color,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});
typedef $$OrganizationsTableTableUpdateCompanionBuilder
    = OrganizationsTableCompanion Function({
  Value<String> id,
  Value<String> nombre,
  Value<String> tipoDignidad,
  Value<int> numeroLista,
  Value<String> color,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});

final class $$OrganizationsTableTableReferences extends BaseReferences<
    _$AppDatabase, $OrganizationsTableTable, OrganizationsTableData> {
  $$OrganizationsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CandidatesTableTable, List<CandidatesTableData>>
      _candidatesTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.candidatesTable,
              aliasName: $_aliasNameGenerator(
                  db.organizationsTable.id, db.candidatesTable.organizationId));

  $$CandidatesTableTableProcessedTableManager get candidatesTableRefs {
    final manager =
        $$CandidatesTableTableTableManager($_db, $_db.candidatesTable).filter(
            (f) => f.organizationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_candidatesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$OrganizationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $OrganizationsTableTable> {
  $$OrganizationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipoDignidad => $composableBuilder(
      column: $table.tipoDignidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get numeroLista => $composableBuilder(
      column: $table.numeroLista, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnFilters(column));

  Expression<bool> candidatesTableRefs(
      Expression<bool> Function($$CandidatesTableTableFilterComposer f) f) {
    final $$CandidatesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.candidatesTable,
        getReferencedColumn: (t) => t.organizationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CandidatesTableTableFilterComposer(
              $db: $db,
              $table: $db.candidatesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrganizationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OrganizationsTableTable> {
  $$OrganizationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipoDignidad => $composableBuilder(
      column: $table.tipoDignidad,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get numeroLista => $composableBuilder(
      column: $table.numeroLista, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnOrderings(column));
}

class $$OrganizationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrganizationsTableTable> {
  $$OrganizationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get tipoDignidad => $composableBuilder(
      column: $table.tipoDignidad, builder: (column) => column);

  GeneratedColumn<int> get numeroLista => $composableBuilder(
      column: $table.numeroLista, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => column);

  Expression<T> candidatesTableRefs<T extends Object>(
      Expression<T> Function($$CandidatesTableTableAnnotationComposer a) f) {
    final $$CandidatesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.candidatesTable,
        getReferencedColumn: (t) => t.organizationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CandidatesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.candidatesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrganizationsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrganizationsTableTable,
    OrganizationsTableData,
    $$OrganizationsTableTableFilterComposer,
    $$OrganizationsTableTableOrderingComposer,
    $$OrganizationsTableTableAnnotationComposer,
    $$OrganizationsTableTableCreateCompanionBuilder,
    $$OrganizationsTableTableUpdateCompanionBuilder,
    (OrganizationsTableData, $$OrganizationsTableTableReferences),
    OrganizationsTableData,
    PrefetchHooks Function({bool candidatesTableRefs})> {
  $$OrganizationsTableTableTableManager(
      _$AppDatabase db, $OrganizationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrganizationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrganizationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrganizationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> tipoDignidad = const Value.absent(),
            Value<int> numeroLista = const Value.absent(),
            Value<String> color = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrganizationsTableCompanion(
            id: id,
            nombre: nombre,
            tipoDignidad: tipoDignidad,
            numeroLista: numeroLista,
            color: color,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nombre,
            required String tipoDignidad,
            required int numeroLista,
            Value<String> color = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OrganizationsTableCompanion.insert(
            id: id,
            nombre: nombre,
            tipoDignidad: tipoDignidad,
            numeroLista: numeroLista,
            color: color,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$OrganizationsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({candidatesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (candidatesTableRefs) db.candidatesTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (candidatesTableRefs)
                    await $_getPrefetchedData<OrganizationsTableData,
                            $OrganizationsTableTable, CandidatesTableData>(
                        currentTable: table,
                        referencedTable: $$OrganizationsTableTableReferences
                            ._candidatesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$OrganizationsTableTableReferences(db, table, p0)
                                .candidatesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.organizationId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$OrganizationsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrganizationsTableTable,
    OrganizationsTableData,
    $$OrganizationsTableTableFilterComposer,
    $$OrganizationsTableTableOrderingComposer,
    $$OrganizationsTableTableAnnotationComposer,
    $$OrganizationsTableTableCreateCompanionBuilder,
    $$OrganizationsTableTableUpdateCompanionBuilder,
    (OrganizationsTableData, $$OrganizationsTableTableReferences),
    OrganizationsTableData,
    PrefetchHooks Function({bool candidatesTableRefs})>;
typedef $$CandidatesTableTableCreateCompanionBuilder = CandidatesTableCompanion
    Function({
  required String id,
  required String nombre,
  required String organizationId,
  required String tipoDignidad,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});
typedef $$CandidatesTableTableUpdateCompanionBuilder = CandidatesTableCompanion
    Function({
  Value<String> id,
  Value<String> nombre,
  Value<String> organizationId,
  Value<String> tipoDignidad,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});

final class $$CandidatesTableTableReferences extends BaseReferences<
    _$AppDatabase, $CandidatesTableTable, CandidatesTableData> {
  $$CandidatesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $OrganizationsTableTable _organizationIdTable(_$AppDatabase db) =>
      db.organizationsTable.createAlias($_aliasNameGenerator(
          db.candidatesTable.organizationId, db.organizationsTable.id));

  $$OrganizationsTableTableProcessedTableManager get organizationId {
    final $_column = $_itemColumn<String>('organization_id')!;

    final manager =
        $$OrganizationsTableTableTableManager($_db, $_db.organizationsTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_organizationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$VotesTableTable, List<VotesTableData>>
      _votesTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.votesTable,
              aliasName: $_aliasNameGenerator(
                  db.candidatesTable.id, db.votesTable.candidateId));

  $$VotesTableTableProcessedTableManager get votesTableRefs {
    final manager = $$VotesTableTableTableManager($_db, $_db.votesTable)
        .filter((f) => f.candidateId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_votesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CandidatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CandidatesTableTable> {
  $$CandidatesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipoDignidad => $composableBuilder(
      column: $table.tipoDignidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnFilters(column));

  $$OrganizationsTableTableFilterComposer get organizationId {
    final $$OrganizationsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.organizationId,
        referencedTable: $db.organizationsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrganizationsTableTableFilterComposer(
              $db: $db,
              $table: $db.organizationsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> votesTableRefs(
      Expression<bool> Function($$VotesTableTableFilterComposer f) f) {
    final $$VotesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.votesTable,
        getReferencedColumn: (t) => t.candidateId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VotesTableTableFilterComposer(
              $db: $db,
              $table: $db.votesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CandidatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CandidatesTableTable> {
  $$CandidatesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipoDignidad => $composableBuilder(
      column: $table.tipoDignidad,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnOrderings(column));

  $$OrganizationsTableTableOrderingComposer get organizationId {
    final $$OrganizationsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.organizationId,
        referencedTable: $db.organizationsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrganizationsTableTableOrderingComposer(
              $db: $db,
              $table: $db.organizationsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CandidatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CandidatesTableTable> {
  $$CandidatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get tipoDignidad => $composableBuilder(
      column: $table.tipoDignidad, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => column);

  $$OrganizationsTableTableAnnotationComposer get organizationId {
    final $$OrganizationsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.organizationId,
            referencedTable: $db.organizationsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$OrganizationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.organizationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> votesTableRefs<T extends Object>(
      Expression<T> Function($$VotesTableTableAnnotationComposer a) f) {
    final $$VotesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.votesTable,
        getReferencedColumn: (t) => t.candidateId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VotesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.votesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CandidatesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CandidatesTableTable,
    CandidatesTableData,
    $$CandidatesTableTableFilterComposer,
    $$CandidatesTableTableOrderingComposer,
    $$CandidatesTableTableAnnotationComposer,
    $$CandidatesTableTableCreateCompanionBuilder,
    $$CandidatesTableTableUpdateCompanionBuilder,
    (CandidatesTableData, $$CandidatesTableTableReferences),
    CandidatesTableData,
    PrefetchHooks Function({bool organizationId, bool votesTableRefs})> {
  $$CandidatesTableTableTableManager(
      _$AppDatabase db, $CandidatesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CandidatesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CandidatesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CandidatesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> organizationId = const Value.absent(),
            Value<String> tipoDignidad = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CandidatesTableCompanion(
            id: id,
            nombre: nombre,
            organizationId: organizationId,
            tipoDignidad: tipoDignidad,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nombre,
            required String organizationId,
            required String tipoDignidad,
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CandidatesTableCompanion.insert(
            id: id,
            nombre: nombre,
            organizationId: organizationId,
            tipoDignidad: tipoDignidad,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CandidatesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {organizationId = false, votesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (votesTableRefs) db.votesTable],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (organizationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.organizationId,
                    referencedTable: $$CandidatesTableTableReferences
                        ._organizationIdTable(db),
                    referencedColumn: $$CandidatesTableTableReferences
                        ._organizationIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (votesTableRefs)
                    await $_getPrefetchedData<CandidatesTableData,
                            $CandidatesTableTable, VotesTableData>(
                        currentTable: table,
                        referencedTable: $$CandidatesTableTableReferences
                            ._votesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CandidatesTableTableReferences(db, table, p0)
                                .votesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.candidateId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CandidatesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CandidatesTableTable,
    CandidatesTableData,
    $$CandidatesTableTableFilterComposer,
    $$CandidatesTableTableOrderingComposer,
    $$CandidatesTableTableAnnotationComposer,
    $$CandidatesTableTableCreateCompanionBuilder,
    $$CandidatesTableTableUpdateCompanionBuilder,
    (CandidatesTableData, $$CandidatesTableTableReferences),
    CandidatesTableData,
    PrefetchHooks Function({bool organizationId, bool votesTableRefs})>;
typedef $$ActsTableTableCreateCompanionBuilder = ActsTableCompanion Function({
  required String id,
  required String tableId,
  required String tipoDignidad,
  Value<String?> photoUrl,
  Value<String?> localPhotoPath,
  Value<double?> gpsLatitude,
  Value<double?> gpsLongitude,
  Value<String> estado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});
typedef $$ActsTableTableUpdateCompanionBuilder = ActsTableCompanion Function({
  Value<String> id,
  Value<String> tableId,
  Value<String> tipoDignidad,
  Value<String?> photoUrl,
  Value<String?> localPhotoPath,
  Value<double?> gpsLatitude,
  Value<double?> gpsLongitude,
  Value<String> estado,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> lastSyncAt,
  Value<int> rowid,
});

final class $$ActsTableTableReferences
    extends BaseReferences<_$AppDatabase, $ActsTableTable, ActsTableData> {
  $$ActsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ElectoralTablesTableTable _tableIdTable(_$AppDatabase db) =>
      db.electoralTablesTable.createAlias($_aliasNameGenerator(
          db.actsTable.tableId, db.electoralTablesTable.id));

  $$ElectoralTablesTableTableProcessedTableManager get tableId {
    final $_column = $_itemColumn<String>('table_id')!;

    final manager =
        $$ElectoralTablesTableTableTableManager($_db, $_db.electoralTablesTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tableIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$VotesTableTable, List<VotesTableData>>
      _votesTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.votesTable,
              aliasName:
                  $_aliasNameGenerator(db.actsTable.id, db.votesTable.actId));

  $$VotesTableTableProcessedTableManager get votesTableRefs {
    final manager = $$VotesTableTableTableManager($_db, $_db.votesTable)
        .filter((f) => f.actId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_votesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExtraVotesTableTable, List<ExtraVotesTableData>>
      _extraVotesTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.extraVotesTable,
              aliasName: $_aliasNameGenerator(
                  db.actsTable.id, db.extraVotesTable.actId));

  $$ExtraVotesTableTableProcessedTableManager get extraVotesTableRefs {
    final manager =
        $$ExtraVotesTableTableTableManager($_db, $_db.extraVotesTable)
            .filter((f) => f.actId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_extraVotesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ActsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ActsTableTable> {
  $$ActsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipoDignidad => $composableBuilder(
      column: $table.tipoDignidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPhotoPath => $composableBuilder(
      column: $table.localPhotoPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLatitude => $composableBuilder(
      column: $table.gpsLatitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get gpsLongitude => $composableBuilder(
      column: $table.gpsLongitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnFilters(column));

  $$ElectoralTablesTableTableFilterComposer get tableId {
    final $$ElectoralTablesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tableId,
        referencedTable: $db.electoralTablesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ElectoralTablesTableTableFilterComposer(
              $db: $db,
              $table: $db.electoralTablesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> votesTableRefs(
      Expression<bool> Function($$VotesTableTableFilterComposer f) f) {
    final $$VotesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.votesTable,
        getReferencedColumn: (t) => t.actId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VotesTableTableFilterComposer(
              $db: $db,
              $table: $db.votesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> extraVotesTableRefs(
      Expression<bool> Function($$ExtraVotesTableTableFilterComposer f) f) {
    final $$ExtraVotesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.extraVotesTable,
        getReferencedColumn: (t) => t.actId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExtraVotesTableTableFilterComposer(
              $db: $db,
              $table: $db.extraVotesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ActsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ActsTableTable> {
  $$ActsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipoDignidad => $composableBuilder(
      column: $table.tipoDignidad,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPhotoPath => $composableBuilder(
      column: $table.localPhotoPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLatitude => $composableBuilder(
      column: $table.gpsLatitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get gpsLongitude => $composableBuilder(
      column: $table.gpsLongitude,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => ColumnOrderings(column));

  $$ElectoralTablesTableTableOrderingComposer get tableId {
    final $$ElectoralTablesTableTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tableId,
            referencedTable: $db.electoralTablesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ElectoralTablesTableTableOrderingComposer(
                  $db: $db,
                  $table: $db.electoralTablesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$ActsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActsTableTable> {
  $$ActsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipoDignidad => $composableBuilder(
      column: $table.tipoDignidad, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get localPhotoPath => $composableBuilder(
      column: $table.localPhotoPath, builder: (column) => column);

  GeneratedColumn<double> get gpsLatitude => $composableBuilder(
      column: $table.gpsLatitude, builder: (column) => column);

  GeneratedColumn<double> get gpsLongitude => $composableBuilder(
      column: $table.gpsLongitude, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncAt => $composableBuilder(
      column: $table.lastSyncAt, builder: (column) => column);

  $$ElectoralTablesTableTableAnnotationComposer get tableId {
    final $$ElectoralTablesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.tableId,
            referencedTable: $db.electoralTablesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ElectoralTablesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.electoralTablesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> votesTableRefs<T extends Object>(
      Expression<T> Function($$VotesTableTableAnnotationComposer a) f) {
    final $$VotesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.votesTable,
        getReferencedColumn: (t) => t.actId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VotesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.votesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> extraVotesTableRefs<T extends Object>(
      Expression<T> Function($$ExtraVotesTableTableAnnotationComposer a) f) {
    final $$ExtraVotesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.extraVotesTable,
        getReferencedColumn: (t) => t.actId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExtraVotesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.extraVotesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ActsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ActsTableTable,
    ActsTableData,
    $$ActsTableTableFilterComposer,
    $$ActsTableTableOrderingComposer,
    $$ActsTableTableAnnotationComposer,
    $$ActsTableTableCreateCompanionBuilder,
    $$ActsTableTableUpdateCompanionBuilder,
    (ActsTableData, $$ActsTableTableReferences),
    ActsTableData,
    PrefetchHooks Function(
        {bool tableId, bool votesTableRefs, bool extraVotesTableRefs})> {
  $$ActsTableTableTableManager(_$AppDatabase db, $ActsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tableId = const Value.absent(),
            Value<String> tipoDignidad = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<String?> localPhotoPath = const Value.absent(),
            Value<double?> gpsLatitude = const Value.absent(),
            Value<double?> gpsLongitude = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActsTableCompanion(
            id: id,
            tableId: tableId,
            tipoDignidad: tipoDignidad,
            photoUrl: photoUrl,
            localPhotoPath: localPhotoPath,
            gpsLatitude: gpsLatitude,
            gpsLongitude: gpsLongitude,
            estado: estado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tableId,
            required String tipoDignidad,
            Value<String?> photoUrl = const Value.absent(),
            Value<String?> localPhotoPath = const Value.absent(),
            Value<double?> gpsLatitude = const Value.absent(),
            Value<double?> gpsLongitude = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> lastSyncAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActsTableCompanion.insert(
            id: id,
            tableId: tableId,
            tipoDignidad: tipoDignidad,
            photoUrl: photoUrl,
            localPhotoPath: localPhotoPath,
            gpsLatitude: gpsLatitude,
            gpsLongitude: gpsLongitude,
            estado: estado,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastSyncAt: lastSyncAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ActsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {tableId = false,
              votesTableRefs = false,
              extraVotesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (votesTableRefs) db.votesTable,
                if (extraVotesTableRefs) db.extraVotesTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (tableId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tableId,
                    referencedTable:
                        $$ActsTableTableReferences._tableIdTable(db),
                    referencedColumn:
                        $$ActsTableTableReferences._tableIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (votesTableRefs)
                    await $_getPrefetchedData<ActsTableData, $ActsTableTable,
                            VotesTableData>(
                        currentTable: table,
                        referencedTable:
                            $$ActsTableTableReferences._votesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ActsTableTableReferences(db, table, p0)
                                .votesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.actId == item.id),
                        typedResults: items),
                  if (extraVotesTableRefs)
                    await $_getPrefetchedData<ActsTableData, $ActsTableTable,
                            ExtraVotesTableData>(
                        currentTable: table,
                        referencedTable: $$ActsTableTableReferences
                            ._extraVotesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ActsTableTableReferences(db, table, p0)
                                .extraVotesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.actId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ActsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ActsTableTable,
    ActsTableData,
    $$ActsTableTableFilterComposer,
    $$ActsTableTableOrderingComposer,
    $$ActsTableTableAnnotationComposer,
    $$ActsTableTableCreateCompanionBuilder,
    $$ActsTableTableUpdateCompanionBuilder,
    (ActsTableData, $$ActsTableTableReferences),
    ActsTableData,
    PrefetchHooks Function(
        {bool tableId, bool votesTableRefs, bool extraVotesTableRefs})>;
typedef $$VotesTableTableCreateCompanionBuilder = VotesTableCompanion Function({
  required String id,
  required String actId,
  required String candidateId,
  Value<int> cantidadVotos,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$VotesTableTableUpdateCompanionBuilder = VotesTableCompanion Function({
  Value<String> id,
  Value<String> actId,
  Value<String> candidateId,
  Value<int> cantidadVotos,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$VotesTableTableReferences
    extends BaseReferences<_$AppDatabase, $VotesTableTable, VotesTableData> {
  $$VotesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ActsTableTable _actIdTable(_$AppDatabase db) => db.actsTable
      .createAlias($_aliasNameGenerator(db.votesTable.actId, db.actsTable.id));

  $$ActsTableTableProcessedTableManager get actId {
    final $_column = $_itemColumn<String>('act_id')!;

    final manager = $$ActsTableTableTableManager($_db, $_db.actsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_actIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CandidatesTableTable _candidateIdTable(_$AppDatabase db) =>
      db.candidatesTable.createAlias($_aliasNameGenerator(
          db.votesTable.candidateId, db.candidatesTable.id));

  $$CandidatesTableTableProcessedTableManager get candidateId {
    final $_column = $_itemColumn<String>('candidate_id')!;

    final manager =
        $$CandidatesTableTableTableManager($_db, $_db.candidatesTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_candidateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$VotesTableTableFilterComposer
    extends Composer<_$AppDatabase, $VotesTableTable> {
  $$VotesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidadVotos => $composableBuilder(
      column: $table.cantidadVotos, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ActsTableTableFilterComposer get actId {
    final $$ActsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.actId,
        referencedTable: $db.actsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActsTableTableFilterComposer(
              $db: $db,
              $table: $db.actsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CandidatesTableTableFilterComposer get candidateId {
    final $$CandidatesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.candidateId,
        referencedTable: $db.candidatesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CandidatesTableTableFilterComposer(
              $db: $db,
              $table: $db.candidatesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VotesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $VotesTableTable> {
  $$VotesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidadVotos => $composableBuilder(
      column: $table.cantidadVotos,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ActsTableTableOrderingComposer get actId {
    final $$ActsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.actId,
        referencedTable: $db.actsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActsTableTableOrderingComposer(
              $db: $db,
              $table: $db.actsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CandidatesTableTableOrderingComposer get candidateId {
    final $$CandidatesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.candidateId,
        referencedTable: $db.candidatesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CandidatesTableTableOrderingComposer(
              $db: $db,
              $table: $db.candidatesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VotesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $VotesTableTable> {
  $$VotesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cantidadVotos => $composableBuilder(
      column: $table.cantidadVotos, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ActsTableTableAnnotationComposer get actId {
    final $$ActsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.actId,
        referencedTable: $db.actsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.actsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CandidatesTableTableAnnotationComposer get candidateId {
    final $$CandidatesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.candidateId,
        referencedTable: $db.candidatesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CandidatesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.candidatesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VotesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VotesTableTable,
    VotesTableData,
    $$VotesTableTableFilterComposer,
    $$VotesTableTableOrderingComposer,
    $$VotesTableTableAnnotationComposer,
    $$VotesTableTableCreateCompanionBuilder,
    $$VotesTableTableUpdateCompanionBuilder,
    (VotesTableData, $$VotesTableTableReferences),
    VotesTableData,
    PrefetchHooks Function({bool actId, bool candidateId})> {
  $$VotesTableTableTableManager(_$AppDatabase db, $VotesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VotesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VotesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VotesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> actId = const Value.absent(),
            Value<String> candidateId = const Value.absent(),
            Value<int> cantidadVotos = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VotesTableCompanion(
            id: id,
            actId: actId,
            candidateId: candidateId,
            cantidadVotos: cantidadVotos,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String actId,
            required String candidateId,
            Value<int> cantidadVotos = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VotesTableCompanion.insert(
            id: id,
            actId: actId,
            candidateId: candidateId,
            cantidadVotos: cantidadVotos,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$VotesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({actId = false, candidateId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (actId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.actId,
                    referencedTable:
                        $$VotesTableTableReferences._actIdTable(db),
                    referencedColumn:
                        $$VotesTableTableReferences._actIdTable(db).id,
                  ) as T;
                }
                if (candidateId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.candidateId,
                    referencedTable:
                        $$VotesTableTableReferences._candidateIdTable(db),
                    referencedColumn:
                        $$VotesTableTableReferences._candidateIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$VotesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VotesTableTable,
    VotesTableData,
    $$VotesTableTableFilterComposer,
    $$VotesTableTableOrderingComposer,
    $$VotesTableTableAnnotationComposer,
    $$VotesTableTableCreateCompanionBuilder,
    $$VotesTableTableUpdateCompanionBuilder,
    (VotesTableData, $$VotesTableTableReferences),
    VotesTableData,
    PrefetchHooks Function({bool actId, bool candidateId})>;
typedef $$ExtraVotesTableTableCreateCompanionBuilder = ExtraVotesTableCompanion
    Function({
  required String id,
  required String actId,
  Value<int> votosBlancos,
  Value<int> votosNulos,
  Value<int> totalSufragantes,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$ExtraVotesTableTableUpdateCompanionBuilder = ExtraVotesTableCompanion
    Function({
  Value<String> id,
  Value<String> actId,
  Value<int> votosBlancos,
  Value<int> votosNulos,
  Value<int> totalSufragantes,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$ExtraVotesTableTableReferences extends BaseReferences<
    _$AppDatabase, $ExtraVotesTableTable, ExtraVotesTableData> {
  $$ExtraVotesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ActsTableTable _actIdTable(_$AppDatabase db) =>
      db.actsTable.createAlias(
          $_aliasNameGenerator(db.extraVotesTable.actId, db.actsTable.id));

  $$ActsTableTableProcessedTableManager get actId {
    final $_column = $_itemColumn<String>('act_id')!;

    final manager = $$ActsTableTableTableManager($_db, $_db.actsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_actIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExtraVotesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExtraVotesTableTable> {
  $$ExtraVotesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get votosBlancos => $composableBuilder(
      column: $table.votosBlancos, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get votosNulos => $composableBuilder(
      column: $table.votosNulos, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalSufragantes => $composableBuilder(
      column: $table.totalSufragantes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ActsTableTableFilterComposer get actId {
    final $$ActsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.actId,
        referencedTable: $db.actsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActsTableTableFilterComposer(
              $db: $db,
              $table: $db.actsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExtraVotesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExtraVotesTableTable> {
  $$ExtraVotesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get votosBlancos => $composableBuilder(
      column: $table.votosBlancos,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get votosNulos => $composableBuilder(
      column: $table.votosNulos, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalSufragantes => $composableBuilder(
      column: $table.totalSufragantes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ActsTableTableOrderingComposer get actId {
    final $$ActsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.actId,
        referencedTable: $db.actsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActsTableTableOrderingComposer(
              $db: $db,
              $table: $db.actsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExtraVotesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExtraVotesTableTable> {
  $$ExtraVotesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get votosBlancos => $composableBuilder(
      column: $table.votosBlancos, builder: (column) => column);

  GeneratedColumn<int> get votosNulos => $composableBuilder(
      column: $table.votosNulos, builder: (column) => column);

  GeneratedColumn<int> get totalSufragantes => $composableBuilder(
      column: $table.totalSufragantes, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ActsTableTableAnnotationComposer get actId {
    final $$ActsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.actId,
        referencedTable: $db.actsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.actsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExtraVotesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExtraVotesTableTable,
    ExtraVotesTableData,
    $$ExtraVotesTableTableFilterComposer,
    $$ExtraVotesTableTableOrderingComposer,
    $$ExtraVotesTableTableAnnotationComposer,
    $$ExtraVotesTableTableCreateCompanionBuilder,
    $$ExtraVotesTableTableUpdateCompanionBuilder,
    (ExtraVotesTableData, $$ExtraVotesTableTableReferences),
    ExtraVotesTableData,
    PrefetchHooks Function({bool actId})> {
  $$ExtraVotesTableTableTableManager(
      _$AppDatabase db, $ExtraVotesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExtraVotesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExtraVotesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExtraVotesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> actId = const Value.absent(),
            Value<int> votosBlancos = const Value.absent(),
            Value<int> votosNulos = const Value.absent(),
            Value<int> totalSufragantes = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExtraVotesTableCompanion(
            id: id,
            actId: actId,
            votosBlancos: votosBlancos,
            votosNulos: votosNulos,
            totalSufragantes: totalSufragantes,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String actId,
            Value<int> votosBlancos = const Value.absent(),
            Value<int> votosNulos = const Value.absent(),
            Value<int> totalSufragantes = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExtraVotesTableCompanion.insert(
            id: id,
            actId: actId,
            votosBlancos: votosBlancos,
            votosNulos: votosNulos,
            totalSufragantes: totalSufragantes,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExtraVotesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({actId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (actId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.actId,
                    referencedTable:
                        $$ExtraVotesTableTableReferences._actIdTable(db),
                    referencedColumn:
                        $$ExtraVotesTableTableReferences._actIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExtraVotesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExtraVotesTableTable,
    ExtraVotesTableData,
    $$ExtraVotesTableTableFilterComposer,
    $$ExtraVotesTableTableOrderingComposer,
    $$ExtraVotesTableTableAnnotationComposer,
    $$ExtraVotesTableTableCreateCompanionBuilder,
    $$ExtraVotesTableTableUpdateCompanionBuilder,
    (ExtraVotesTableData, $$ExtraVotesTableTableReferences),
    ExtraVotesTableData,
    PrefetchHooks Function({bool actId})>;
typedef $$OfflineQueueTableTableCreateCompanionBuilder
    = OfflineQueueTableCompanion Function({
  Value<int> id,
  required String operation,
  required String collectionName,
  required String documentId,
  required String payload,
  Value<String> syncStatus,
  Value<int> retryCount,
  Value<String?> lastError,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$OfflineQueueTableTableUpdateCompanionBuilder
    = OfflineQueueTableCompanion Function({
  Value<int> id,
  Value<String> operation,
  Value<String> collectionName,
  Value<String> documentId,
  Value<String> payload,
  Value<String> syncStatus,
  Value<int> retryCount,
  Value<String?> lastError,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$OfflineQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $OfflineQueueTableTable> {
  $$OfflineQueueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get collectionName => $composableBuilder(
      column: $table.collectionName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get documentId => $composableBuilder(
      column: $table.documentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$OfflineQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OfflineQueueTableTable> {
  $$OfflineQueueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get collectionName => $composableBuilder(
      column: $table.collectionName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get documentId => $composableBuilder(
      column: $table.documentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$OfflineQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OfflineQueueTableTable> {
  $$OfflineQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get collectionName => $composableBuilder(
      column: $table.collectionName, builder: (column) => column);

  GeneratedColumn<String> get documentId => $composableBuilder(
      column: $table.documentId, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OfflineQueueTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OfflineQueueTableTable,
    OfflineQueueTableData,
    $$OfflineQueueTableTableFilterComposer,
    $$OfflineQueueTableTableOrderingComposer,
    $$OfflineQueueTableTableAnnotationComposer,
    $$OfflineQueueTableTableCreateCompanionBuilder,
    $$OfflineQueueTableTableUpdateCompanionBuilder,
    (
      OfflineQueueTableData,
      BaseReferences<_$AppDatabase, $OfflineQueueTableTable,
          OfflineQueueTableData>
    ),
    OfflineQueueTableData,
    PrefetchHooks Function()> {
  $$OfflineQueueTableTableTableManager(
      _$AppDatabase db, $OfflineQueueTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OfflineQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OfflineQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OfflineQueueTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> collectionName = const Value.absent(),
            Value<String> documentId = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              OfflineQueueTableCompanion(
            id: id,
            operation: operation,
            collectionName: collectionName,
            documentId: documentId,
            payload: payload,
            syncStatus: syncStatus,
            retryCount: retryCount,
            lastError: lastError,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String operation,
            required String collectionName,
            required String documentId,
            required String payload,
            Value<String> syncStatus = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              OfflineQueueTableCompanion.insert(
            id: id,
            operation: operation,
            collectionName: collectionName,
            documentId: documentId,
            payload: payload,
            syncStatus: syncStatus,
            retryCount: retryCount,
            lastError: lastError,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OfflineQueueTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OfflineQueueTableTable,
    OfflineQueueTableData,
    $$OfflineQueueTableTableFilterComposer,
    $$OfflineQueueTableTableOrderingComposer,
    $$OfflineQueueTableTableAnnotationComposer,
    $$OfflineQueueTableTableCreateCompanionBuilder,
    $$OfflineQueueTableTableUpdateCompanionBuilder,
    (
      OfflineQueueTableData,
      BaseReferences<_$AppDatabase, $OfflineQueueTableTable,
          OfflineQueueTableData>
    ),
    OfflineQueueTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableTableManager get usersTable =>
      $$UsersTableTableTableManager(_db, _db.usersTable);
  $$PrecinctsTableTableTableManager get precinctsTable =>
      $$PrecinctsTableTableTableManager(_db, _db.precinctsTable);
  $$ElectoralTablesTableTableTableManager get electoralTablesTable =>
      $$ElectoralTablesTableTableTableManager(_db, _db.electoralTablesTable);
  $$OrganizationsTableTableTableManager get organizationsTable =>
      $$OrganizationsTableTableTableManager(_db, _db.organizationsTable);
  $$CandidatesTableTableTableManager get candidatesTable =>
      $$CandidatesTableTableTableManager(_db, _db.candidatesTable);
  $$ActsTableTableTableManager get actsTable =>
      $$ActsTableTableTableManager(_db, _db.actsTable);
  $$VotesTableTableTableManager get votesTable =>
      $$VotesTableTableTableManager(_db, _db.votesTable);
  $$ExtraVotesTableTableTableManager get extraVotesTable =>
      $$ExtraVotesTableTableTableManager(_db, _db.extraVotesTable);
  $$OfflineQueueTableTableTableManager get offlineQueueTable =>
      $$OfflineQueueTableTableTableManager(_db, _db.offlineQueueTable);
}
