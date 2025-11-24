// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PlanetTableTable extends PlanetTable
    with TableInfo<$PlanetTableTable, PlanetTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanetTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<PlanetName, String> name =
      GeneratedColumn<String>('name', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PlanetName>($PlanetTableTable.$convertername);
  static const VerificationMeta _politicalRegimeMeta =
      const VerificationMeta('politicalRegime');
  @override
  late final GeneratedColumn<String> politicalRegime = GeneratedColumn<String>(
      'political_regime', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isColonizedMeta =
      const VerificationMeta('isColonized');
  @override
  late final GeneratedColumn<bool> isColonized = GeneratedColumn<bool>(
      'is_colonized', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_colonized" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, name, politicalRegime, isColonized];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'planet_table';
  @override
  VerificationContext validateIntegrity(Insertable<PlanetTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('political_regime')) {
      context.handle(
          _politicalRegimeMeta,
          politicalRegime.isAcceptableOrUnknown(
              data['political_regime']!, _politicalRegimeMeta));
    }
    if (data.containsKey('is_colonized')) {
      context.handle(
          _isColonizedMeta,
          isColonized.isAcceptableOrUnknown(
              data['is_colonized']!, _isColonizedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanetTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanetTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      name: $PlanetTableTable.$convertername.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!),
      politicalRegime: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}political_regime']),
      isColonized: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_colonized'])!,
    );
  }

  @override
  $PlanetTableTable createAlias(String alias) {
    return $PlanetTableTable(attachedDatabase, alias);
  }

  static TypeConverter<PlanetName, String> $convertername =
      const PlanetNameConverter();
}

class PlanetTableData extends DataClass implements Insertable<PlanetTableData> {
  final int id;
  final int userId;
  final PlanetName name;
  final String? politicalRegime;
  final bool isColonized;
  const PlanetTableData(
      {required this.id,
      required this.userId,
      required this.name,
      this.politicalRegime,
      required this.isColonized});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    {
      map['name'] =
          Variable<String>($PlanetTableTable.$convertername.toSql(name));
    }
    if (!nullToAbsent || politicalRegime != null) {
      map['political_regime'] = Variable<String>(politicalRegime);
    }
    map['is_colonized'] = Variable<bool>(isColonized);
    return map;
  }

  PlanetTableCompanion toCompanion(bool nullToAbsent) {
    return PlanetTableCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      politicalRegime: politicalRegime == null && nullToAbsent
          ? const Value.absent()
          : Value(politicalRegime),
      isColonized: Value(isColonized),
    );
  }

  factory PlanetTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanetTableData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      name: serializer.fromJson<PlanetName>(json['name']),
      politicalRegime: serializer.fromJson<String?>(json['politicalRegime']),
      isColonized: serializer.fromJson<bool>(json['isColonized']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'name': serializer.toJson<PlanetName>(name),
      'politicalRegime': serializer.toJson<String?>(politicalRegime),
      'isColonized': serializer.toJson<bool>(isColonized),
    };
  }

  PlanetTableData copyWith(
          {int? id,
          int? userId,
          PlanetName? name,
          Value<String?> politicalRegime = const Value.absent(),
          bool? isColonized}) =>
      PlanetTableData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        politicalRegime: politicalRegime.present
            ? politicalRegime.value
            : this.politicalRegime,
        isColonized: isColonized ?? this.isColonized,
      );
  PlanetTableData copyWithCompanion(PlanetTableCompanion data) {
    return PlanetTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      politicalRegime: data.politicalRegime.present
          ? data.politicalRegime.value
          : this.politicalRegime,
      isColonized:
          data.isColonized.present ? data.isColonized.value : this.isColonized,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanetTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('politicalRegime: $politicalRegime, ')
          ..write('isColonized: $isColonized')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, name, politicalRegime, isColonized);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanetTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.politicalRegime == this.politicalRegime &&
          other.isColonized == this.isColonized);
}

class PlanetTableCompanion extends UpdateCompanion<PlanetTableData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<PlanetName> name;
  final Value<String?> politicalRegime;
  final Value<bool> isColonized;
  const PlanetTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.politicalRegime = const Value.absent(),
    this.isColonized = const Value.absent(),
  });
  PlanetTableCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required PlanetName name,
    this.politicalRegime = const Value.absent(),
    this.isColonized = const Value.absent(),
  })  : userId = Value(userId),
        name = Value(name);
  static Insertable<PlanetTableData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? name,
    Expression<String>? politicalRegime,
    Expression<bool>? isColonized,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (politicalRegime != null) 'political_regime': politicalRegime,
      if (isColonized != null) 'is_colonized': isColonized,
    });
  }

  PlanetTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<PlanetName>? name,
      Value<String?>? politicalRegime,
      Value<bool>? isColonized}) {
    return PlanetTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      politicalRegime: politicalRegime ?? this.politicalRegime,
      isColonized: isColonized ?? this.isColonized,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (name.present) {
      map['name'] =
          Variable<String>($PlanetTableTable.$convertername.toSql(name.value));
    }
    if (politicalRegime.present) {
      map['political_regime'] = Variable<String>(politicalRegime.value);
    }
    if (isColonized.present) {
      map['is_colonized'] = Variable<bool>(isColonized.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanetTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('politicalRegime: $politicalRegime, ')
          ..write('isColonized: $isColonized')
          ..write(')'))
        .toString();
  }
}

class $BuildingTableTable extends BuildingTable
    with TableInfo<$BuildingTableTable, BuildingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuildingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  @override
  late final GeneratedColumnWithTypeConverter<BuildingType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<BuildingType>($BuildingTableTable.$convertertype);
  static const VerificationMeta _planetIdMeta =
      const VerificationMeta('planetId');
  @override
  late final GeneratedColumn<int> planetId = GeneratedColumn<int>(
      'planet_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES planet_table (id)'));
  static const VerificationMeta _niveauMeta = const VerificationMeta('niveau');
  @override
  late final GeneratedColumn<int> niveau = GeneratedColumn<int>(
      'niveau', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _energieCostMeta =
      const VerificationMeta('energieCost');
  @override
  late final GeneratedColumn<int> energieCost = GeneratedColumn<int>(
      'energie_cost', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, planetId, niveau, energieCost];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'building_table';
  @override
  VerificationContext validateIntegrity(Insertable<BuildingTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('planet_id')) {
      context.handle(_planetIdMeta,
          planetId.isAcceptableOrUnknown(data['planet_id']!, _planetIdMeta));
    } else if (isInserting) {
      context.missing(_planetIdMeta);
    }
    if (data.containsKey('niveau')) {
      context.handle(_niveauMeta,
          niveau.isAcceptableOrUnknown(data['niveau']!, _niveauMeta));
    }
    if (data.containsKey('energie_cost')) {
      context.handle(
          _energieCostMeta,
          energieCost.isAcceptableOrUnknown(
              data['energie_cost']!, _energieCostMeta));
    } else if (isInserting) {
      context.missing(_energieCostMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BuildingTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BuildingTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      type: $BuildingTableTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      planetId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}planet_id'])!,
      niveau: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}niveau'])!,
      energieCost: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}energie_cost'])!,
    );
  }

  @override
  $BuildingTableTable createAlias(String alias) {
    return $BuildingTableTable(attachedDatabase, alias);
  }

  static TypeConverter<BuildingType, String> $convertertype =
      const BuildingTypeConverter();
}

class BuildingTableData extends DataClass
    implements Insertable<BuildingTableData> {
  final int id;
  final BuildingType type;
  final int planetId;
  final int niveau;
  final int energieCost;
  const BuildingTableData(
      {required this.id,
      required this.type,
      required this.planetId,
      required this.niveau,
      required this.energieCost});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] =
          Variable<String>($BuildingTableTable.$convertertype.toSql(type));
    }
    map['planet_id'] = Variable<int>(planetId);
    map['niveau'] = Variable<int>(niveau);
    map['energie_cost'] = Variable<int>(energieCost);
    return map;
  }

  BuildingTableCompanion toCompanion(bool nullToAbsent) {
    return BuildingTableCompanion(
      id: Value(id),
      type: Value(type),
      planetId: Value(planetId),
      niveau: Value(niveau),
      energieCost: Value(energieCost),
    );
  }

  factory BuildingTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BuildingTableData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<BuildingType>(json['type']),
      planetId: serializer.fromJson<int>(json['planetId']),
      niveau: serializer.fromJson<int>(json['niveau']),
      energieCost: serializer.fromJson<int>(json['energieCost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<BuildingType>(type),
      'planetId': serializer.toJson<int>(planetId),
      'niveau': serializer.toJson<int>(niveau),
      'energieCost': serializer.toJson<int>(energieCost),
    };
  }

  BuildingTableData copyWith(
          {int? id,
          BuildingType? type,
          int? planetId,
          int? niveau,
          int? energieCost}) =>
      BuildingTableData(
        id: id ?? this.id,
        type: type ?? this.type,
        planetId: planetId ?? this.planetId,
        niveau: niveau ?? this.niveau,
        energieCost: energieCost ?? this.energieCost,
      );
  BuildingTableData copyWithCompanion(BuildingTableCompanion data) {
    return BuildingTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      planetId: data.planetId.present ? data.planetId.value : this.planetId,
      niveau: data.niveau.present ? data.niveau.value : this.niveau,
      energieCost:
          data.energieCost.present ? data.energieCost.value : this.energieCost,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BuildingTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('planetId: $planetId, ')
          ..write('niveau: $niveau, ')
          ..write('energieCost: $energieCost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, planetId, niveau, energieCost);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BuildingTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.planetId == this.planetId &&
          other.niveau == this.niveau &&
          other.energieCost == this.energieCost);
}

class BuildingTableCompanion extends UpdateCompanion<BuildingTableData> {
  final Value<int> id;
  final Value<BuildingType> type;
  final Value<int> planetId;
  final Value<int> niveau;
  final Value<int> energieCost;
  const BuildingTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.planetId = const Value.absent(),
    this.niveau = const Value.absent(),
    this.energieCost = const Value.absent(),
  });
  BuildingTableCompanion.insert({
    this.id = const Value.absent(),
    required BuildingType type,
    required int planetId,
    this.niveau = const Value.absent(),
    required int energieCost,
  })  : type = Value(type),
        planetId = Value(planetId),
        energieCost = Value(energieCost);
  static Insertable<BuildingTableData> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<int>? planetId,
    Expression<int>? niveau,
    Expression<int>? energieCost,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (planetId != null) 'planet_id': planetId,
      if (niveau != null) 'niveau': niveau,
      if (energieCost != null) 'energie_cost': energieCost,
    });
  }

  BuildingTableCompanion copyWith(
      {Value<int>? id,
      Value<BuildingType>? type,
      Value<int>? planetId,
      Value<int>? niveau,
      Value<int>? energieCost}) {
    return BuildingTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      planetId: planetId ?? this.planetId,
      niveau: niveau ?? this.niveau,
      energieCost: energieCost ?? this.energieCost,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
          $BuildingTableTable.$convertertype.toSql(type.value));
    }
    if (planetId.present) {
      map['planet_id'] = Variable<int>(planetId.value);
    }
    if (niveau.present) {
      map['niveau'] = Variable<int>(niveau.value);
    }
    if (energieCost.present) {
      map['energie_cost'] = Variable<int>(energieCost.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuildingTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('planetId: $planetId, ')
          ..write('niveau: $niveau, ')
          ..write('energieCost: $energieCost')
          ..write(')'))
        .toString();
  }
}

class $UserTableTable extends UserTable with TableInfo<$UserTableTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<List<int>?, String> planetIds =
      GeneratedColumn<String>('planet_ids', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<int>?>($UserTableTable.$converterplanetIds);
  @override
  List<GeneratedColumn> get $columns => [id, name, planetIds];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_table';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      planetIds: $UserTableTable.$converterplanetIds.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}planet_ids'])),
    );
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }

  static TypeConverter<List<int>?, String?> $converterplanetIds =
      NullAwareTypeConverter.wrap(const PlanetIdConverter() as TypeConverter<List<int>, String>);
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final List<int>? planetIds;
  const User({required this.id, required this.name, this.planetIds});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || planetIds != null) {
      map['planet_ids'] = Variable<String>(
          $UserTableTable.$converterplanetIds.toSql(planetIds));
    }
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      name: Value(name),
      planetIds: planetIds == null && nullToAbsent
          ? const Value.absent()
          : Value(planetIds),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      planetIds: serializer.fromJson<List<int>?>(json['planetIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'planetIds': serializer.toJson<List<int>?>(planetIds),
    };
  }

  User copyWith(
          {int? id,
          String? name,
          Value<List<int>?> planetIds = const Value.absent()}) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        planetIds: planetIds.present ? planetIds.value : this.planetIds,
      );
  User copyWithCompanion(UserTableCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      planetIds: data.planetIds.present ? data.planetIds.value : this.planetIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('planetIds: $planetIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, planetIds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.planetIds == this.planetIds);
}

class UserTableCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<List<int>?> planetIds;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.planetIds = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.planetIds = const Value.absent(),
  }) : name = Value(name);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? planetIds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (planetIds != null) 'planet_ids': planetIds,
    });
  }

  UserTableCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<List<int>?>? planetIds}) {
    return UserTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      planetIds: planetIds ?? this.planetIds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (planetIds.present) {
      map['planet_ids'] = Variable<String>(
          $UserTableTable.$converterplanetIds.toSql(planetIds.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('planetIds: $planetIds')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlanetTableTable planetTable = $PlanetTableTable(this);
  late final $BuildingTableTable buildingTable = $BuildingTableTable(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final PlanetDao planetDao = PlanetDao(this as AppDatabase);
  late final BuildingDao buildingDao = BuildingDao(this as AppDatabase);
  late final UserDao userDao = UserDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [planetTable, buildingTable, userTable];
}

typedef $$PlanetTableTableCreateCompanionBuilder = PlanetTableCompanion
    Function({
  Value<int> id,
  required int userId,
  required PlanetName name,
  Value<String?> politicalRegime,
  Value<bool> isColonized,
});
typedef $$PlanetTableTableUpdateCompanionBuilder = PlanetTableCompanion
    Function({
  Value<int> id,
  Value<int> userId,
  Value<PlanetName> name,
  Value<String?> politicalRegime,
  Value<bool> isColonized,
});

final class $$PlanetTableTableReferences
    extends BaseReferences<_$AppDatabase, $PlanetTableTable, PlanetTableData> {
  $$PlanetTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BuildingTableTable, List<BuildingTableData>>
      _buildingTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.buildingTable,
              aliasName: $_aliasNameGenerator(
                  db.planetTable.id, db.buildingTable.planetId));

  $$BuildingTableTableProcessedTableManager get buildingTableRefs {
    final manager = $$BuildingTableTableTableManager($_db, $_db.buildingTable)
        .filter((f) => f.planetId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_buildingTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlanetTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlanetTableTable> {
  $$PlanetTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PlanetName, PlanetName, String> get name =>
      $composableBuilder(
          column: $table.name,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get politicalRegime => $composableBuilder(
      column: $table.politicalRegime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isColonized => $composableBuilder(
      column: $table.isColonized, builder: (column) => ColumnFilters(column));

  Expression<bool> buildingTableRefs(
      Expression<bool> Function($$BuildingTableTableFilterComposer f) f) {
    final $$BuildingTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.buildingTable,
        getReferencedColumn: (t) => t.planetId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuildingTableTableFilterComposer(
              $db: $db,
              $table: $db.buildingTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlanetTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanetTableTable> {
  $$PlanetTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get politicalRegime => $composableBuilder(
      column: $table.politicalRegime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isColonized => $composableBuilder(
      column: $table.isColonized, builder: (column) => ColumnOrderings(column));
}

class $$PlanetTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanetTableTable> {
  $$PlanetTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PlanetName, String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get politicalRegime => $composableBuilder(
      column: $table.politicalRegime, builder: (column) => column);

  GeneratedColumn<bool> get isColonized => $composableBuilder(
      column: $table.isColonized, builder: (column) => column);

  Expression<T> buildingTableRefs<T extends Object>(
      Expression<T> Function($$BuildingTableTableAnnotationComposer a) f) {
    final $$BuildingTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.buildingTable,
        getReferencedColumn: (t) => t.planetId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BuildingTableTableAnnotationComposer(
              $db: $db,
              $table: $db.buildingTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PlanetTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlanetTableTable,
    PlanetTableData,
    $$PlanetTableTableFilterComposer,
    $$PlanetTableTableOrderingComposer,
    $$PlanetTableTableAnnotationComposer,
    $$PlanetTableTableCreateCompanionBuilder,
    $$PlanetTableTableUpdateCompanionBuilder,
    (PlanetTableData, $$PlanetTableTableReferences),
    PlanetTableData,
    PrefetchHooks Function({bool buildingTableRefs})> {
  $$PlanetTableTableTableManager(_$AppDatabase db, $PlanetTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanetTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanetTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanetTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> userId = const Value.absent(),
            Value<PlanetName> name = const Value.absent(),
            Value<String?> politicalRegime = const Value.absent(),
            Value<bool> isColonized = const Value.absent(),
          }) =>
              PlanetTableCompanion(
            id: id,
            userId: userId,
            name: name,
            politicalRegime: politicalRegime,
            isColonized: isColonized,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int userId,
            required PlanetName name,
            Value<String?> politicalRegime = const Value.absent(),
            Value<bool> isColonized = const Value.absent(),
          }) =>
              PlanetTableCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            politicalRegime: politicalRegime,
            isColonized: isColonized,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlanetTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({buildingTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (buildingTableRefs) db.buildingTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (buildingTableRefs)
                    await $_getPrefetchedData<PlanetTableData,
                            $PlanetTableTable, BuildingTableData>(
                        currentTable: table,
                        referencedTable: $$PlanetTableTableReferences
                            ._buildingTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlanetTableTableReferences(db, table, p0)
                                .buildingTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.planetId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlanetTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlanetTableTable,
    PlanetTableData,
    $$PlanetTableTableFilterComposer,
    $$PlanetTableTableOrderingComposer,
    $$PlanetTableTableAnnotationComposer,
    $$PlanetTableTableCreateCompanionBuilder,
    $$PlanetTableTableUpdateCompanionBuilder,
    (PlanetTableData, $$PlanetTableTableReferences),
    PlanetTableData,
    PrefetchHooks Function({bool buildingTableRefs})>;
typedef $$BuildingTableTableCreateCompanionBuilder = BuildingTableCompanion
    Function({
  Value<int> id,
  required BuildingType type,
  required int planetId,
  Value<int> niveau,
  required int energieCost,
});
typedef $$BuildingTableTableUpdateCompanionBuilder = BuildingTableCompanion
    Function({
  Value<int> id,
  Value<BuildingType> type,
  Value<int> planetId,
  Value<int> niveau,
  Value<int> energieCost,
});

final class $$BuildingTableTableReferences extends BaseReferences<_$AppDatabase,
    $BuildingTableTable, BuildingTableData> {
  $$BuildingTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlanetTableTable _planetIdTable(_$AppDatabase db) =>
      db.planetTable.createAlias(
          $_aliasNameGenerator(db.buildingTable.planetId, db.planetTable.id));

  $$PlanetTableTableProcessedTableManager get planetId {
    final $_column = $_itemColumn<int>('planet_id')!;

    final manager = $$PlanetTableTableTableManager($_db, $_db.planetTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BuildingTableTableFilterComposer
    extends Composer<_$AppDatabase, $BuildingTableTable> {
  $$BuildingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<BuildingType, BuildingType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get niveau => $composableBuilder(
      column: $table.niveau, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get energieCost => $composableBuilder(
      column: $table.energieCost, builder: (column) => ColumnFilters(column));

  $$PlanetTableTableFilterComposer get planetId {
    final $$PlanetTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planetId,
        referencedTable: $db.planetTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanetTableTableFilterComposer(
              $db: $db,
              $table: $db.planetTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BuildingTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BuildingTableTable> {
  $$BuildingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get niveau => $composableBuilder(
      column: $table.niveau, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get energieCost => $composableBuilder(
      column: $table.energieCost, builder: (column) => ColumnOrderings(column));

  $$PlanetTableTableOrderingComposer get planetId {
    final $$PlanetTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planetId,
        referencedTable: $db.planetTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanetTableTableOrderingComposer(
              $db: $db,
              $table: $db.planetTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BuildingTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BuildingTableTable> {
  $$BuildingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BuildingType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get niveau =>
      $composableBuilder(column: $table.niveau, builder: (column) => column);

  GeneratedColumn<int> get energieCost => $composableBuilder(
      column: $table.energieCost, builder: (column) => column);

  $$PlanetTableTableAnnotationComposer get planetId {
    final $$PlanetTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planetId,
        referencedTable: $db.planetTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlanetTableTableAnnotationComposer(
              $db: $db,
              $table: $db.planetTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BuildingTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BuildingTableTable,
    BuildingTableData,
    $$BuildingTableTableFilterComposer,
    $$BuildingTableTableOrderingComposer,
    $$BuildingTableTableAnnotationComposer,
    $$BuildingTableTableCreateCompanionBuilder,
    $$BuildingTableTableUpdateCompanionBuilder,
    (BuildingTableData, $$BuildingTableTableReferences),
    BuildingTableData,
    PrefetchHooks Function({bool planetId})> {
  $$BuildingTableTableTableManager(_$AppDatabase db, $BuildingTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BuildingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BuildingTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BuildingTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<BuildingType> type = const Value.absent(),
            Value<int> planetId = const Value.absent(),
            Value<int> niveau = const Value.absent(),
            Value<int> energieCost = const Value.absent(),
          }) =>
              BuildingTableCompanion(
            id: id,
            type: type,
            planetId: planetId,
            niveau: niveau,
            energieCost: energieCost,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required BuildingType type,
            required int planetId,
            Value<int> niveau = const Value.absent(),
            required int energieCost,
          }) =>
              BuildingTableCompanion.insert(
            id: id,
            type: type,
            planetId: planetId,
            niveau: niveau,
            energieCost: energieCost,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BuildingTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({planetId = false}) {
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
                if (planetId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.planetId,
                    referencedTable:
                        $$BuildingTableTableReferences._planetIdTable(db),
                    referencedColumn:
                        $$BuildingTableTableReferences._planetIdTable(db).id,
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

typedef $$BuildingTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BuildingTableTable,
    BuildingTableData,
    $$BuildingTableTableFilterComposer,
    $$BuildingTableTableOrderingComposer,
    $$BuildingTableTableAnnotationComposer,
    $$BuildingTableTableCreateCompanionBuilder,
    $$BuildingTableTableUpdateCompanionBuilder,
    (BuildingTableData, $$BuildingTableTableReferences),
    BuildingTableData,
    PrefetchHooks Function({bool planetId})>;
typedef $$UserTableTableCreateCompanionBuilder = UserTableCompanion Function({
  Value<int> id,
  required String name,
  Value<List<int>?> planetIds,
});
typedef $$UserTableTableUpdateCompanionBuilder = UserTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<List<int>?> planetIds,
});

class $$UserTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<int>?, List<int>, String> get planetIds =>
      $composableBuilder(
          column: $table.planetIds,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$UserTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get planetIds => $composableBuilder(
      column: $table.planetIds, builder: (column) => ColumnOrderings(column));
}

class $$UserTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTableTable> {
  $$UserTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<int>?, String> get planetIds =>
      $composableBuilder(column: $table.planetIds, builder: (column) => column);
}

class $$UserTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserTableTable,
    User,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UserTableTable, User>),
    User,
    PrefetchHooks Function()> {
  $$UserTableTableTableManager(_$AppDatabase db, $UserTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<List<int>?> planetIds = const Value.absent(),
          }) =>
              UserTableCompanion(
            id: id,
            name: name,
            planetIds: planetIds,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<List<int>?> planetIds = const Value.absent(),
          }) =>
              UserTableCompanion.insert(
            id: id,
            name: name,
            planetIds: planetIds,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserTableTable,
    User,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (User, BaseReferences<_$AppDatabase, $UserTableTable, User>),
    User,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlanetTableTableTableManager get planetTable =>
      $$PlanetTableTableTableManager(_db, _db.planetTable);
  $$BuildingTableTableTableManager get buildingTable =>
      $$BuildingTableTableTableManager(_db, _db.buildingTable);
  $$UserTableTableTableManager get userTable =>
      $$UserTableTableTableManager(_db, _db.userTable);
}
