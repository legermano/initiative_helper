// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Encounter extends DataClass implements Insertable<Encounter> {
  final int id;
  final String description;
  Encounter({@required this.id, @required this.description});
  factory Encounter.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Encounter(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      description:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}desc']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || description != null) {
      map['desc'] = Variable<String>(description);
    }
    return map;
  }

  EncountersCompanion toCompanion(bool nullToAbsent) {
    return EncountersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Encounter.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Encounter(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String>(description),
    };
  }

  Encounter copyWith({int id, String description}) => Encounter(
        id: id ?? this.id,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Encounter(')
          ..write('id: $id, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode, description.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Encounter &&
          other.id == this.id &&
          other.description == this.description);
}

class EncountersCompanion extends UpdateCompanion<Encounter> {
  final Value<int> id;
  final Value<String> description;
  const EncountersCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
  });
  EncountersCompanion.insert({
    this.id = const Value.absent(),
    @required String description,
  }) : description = Value(description);
  static Insertable<Encounter> custom({
    Expression<int> id,
    Expression<String> description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'desc': description,
    });
  }

  EncountersCompanion copyWith({Value<int> id, Value<String> description}) {
    return EncountersCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['desc'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EncountersCompanion(')
          ..write('id: $id, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $EncountersTable extends Encounters
    with TableInfo<$EncountersTable, Encounter> {
  final GeneratedDatabase _db;
  final String _alias;
  $EncountersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'desc',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, description];
  @override
  $EncountersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'encounters';
  @override
  final String actualTableName = 'encounters';
  @override
  VerificationContext validateIntegrity(Insertable<Encounter> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('desc')) {
      context.handle(_descriptionMeta,
          description.isAcceptableOrUnknown(data['desc'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Encounter map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Encounter.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $EncountersTable createAlias(String alias) {
    return $EncountersTable(_db, alias);
  }
}

class Character extends DataClass implements Insertable<Character> {
  final int id;
  final int encounter;
  final String name;
  final int initiative;
  final int modifier;
  final Conditions condition;
  final int armorClass;
  final int maxHealthPoints;
  final int currentHealthPoints;
  Character(
      {@required this.id,
      @required this.encounter,
      @required this.name,
      @required this.initiative,
      this.modifier,
      @required this.condition,
      this.armorClass,
      this.maxHealthPoints,
      this.currentHealthPoints});
  factory Character.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Character(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      encounter:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}encounter']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      initiative:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}initiative']),
      modifier:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}modifier']),
      condition: $CharactersTable.$converter0.mapToDart(
          intType.mapFromDatabaseResponse(data['${effectivePrefix}condition'])),
      armorClass: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}armor_class']),
      maxHealthPoints: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}max_health_points']),
      currentHealthPoints: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}current_health_points']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || encounter != null) {
      map['encounter'] = Variable<int>(encounter);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || initiative != null) {
      map['initiative'] = Variable<int>(initiative);
    }
    if (!nullToAbsent || modifier != null) {
      map['modifier'] = Variable<int>(modifier);
    }
    if (!nullToAbsent || condition != null) {
      final converter = $CharactersTable.$converter0;
      map['condition'] = Variable<int>(converter.mapToSql(condition));
    }
    if (!nullToAbsent || armorClass != null) {
      map['armor_class'] = Variable<int>(armorClass);
    }
    if (!nullToAbsent || maxHealthPoints != null) {
      map['max_health_points'] = Variable<int>(maxHealthPoints);
    }
    if (!nullToAbsent || currentHealthPoints != null) {
      map['current_health_points'] = Variable<int>(currentHealthPoints);
    }
    return map;
  }

  CharactersCompanion toCompanion(bool nullToAbsent) {
    return CharactersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      encounter: encounter == null && nullToAbsent
          ? const Value.absent()
          : Value(encounter),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      initiative: initiative == null && nullToAbsent
          ? const Value.absent()
          : Value(initiative),
      modifier: modifier == null && nullToAbsent
          ? const Value.absent()
          : Value(modifier),
      condition: condition == null && nullToAbsent
          ? const Value.absent()
          : Value(condition),
      armorClass: armorClass == null && nullToAbsent
          ? const Value.absent()
          : Value(armorClass),
      maxHealthPoints: maxHealthPoints == null && nullToAbsent
          ? const Value.absent()
          : Value(maxHealthPoints),
      currentHealthPoints: currentHealthPoints == null && nullToAbsent
          ? const Value.absent()
          : Value(currentHealthPoints),
    );
  }

  factory Character.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Character(
      id: serializer.fromJson<int>(json['id']),
      encounter: serializer.fromJson<int>(json['encounter']),
      name: serializer.fromJson<String>(json['name']),
      initiative: serializer.fromJson<int>(json['initiative']),
      modifier: serializer.fromJson<int>(json['modifier']),
      condition: serializer.fromJson<Conditions>(json['condition']),
      armorClass: serializer.fromJson<int>(json['armorClass']),
      maxHealthPoints: serializer.fromJson<int>(json['maxHealthPoints']),
      currentHealthPoints:
          serializer.fromJson<int>(json['currentHealthPoints']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'encounter': serializer.toJson<int>(encounter),
      'name': serializer.toJson<String>(name),
      'initiative': serializer.toJson<int>(initiative),
      'modifier': serializer.toJson<int>(modifier),
      'condition': serializer.toJson<Conditions>(condition),
      'armorClass': serializer.toJson<int>(armorClass),
      'maxHealthPoints': serializer.toJson<int>(maxHealthPoints),
      'currentHealthPoints': serializer.toJson<int>(currentHealthPoints),
    };
  }

  Character copyWith(
          {int id,
          int encounter,
          String name,
          int initiative,
          int modifier,
          Conditions condition,
          int armorClass,
          int maxHealthPoints,
          int currentHealthPoints}) =>
      Character(
        id: id ?? this.id,
        encounter: encounter ?? this.encounter,
        name: name ?? this.name,
        initiative: initiative ?? this.initiative,
        modifier: modifier ?? this.modifier,
        condition: condition ?? this.condition,
        armorClass: armorClass ?? this.armorClass,
        maxHealthPoints: maxHealthPoints ?? this.maxHealthPoints,
        currentHealthPoints: currentHealthPoints ?? this.currentHealthPoints,
      );
  @override
  String toString() {
    return (StringBuffer('Character(')
          ..write('id: $id, ')
          ..write('encounter: $encounter, ')
          ..write('name: $name, ')
          ..write('initiative: $initiative, ')
          ..write('modifier: $modifier, ')
          ..write('condition: $condition, ')
          ..write('armorClass: $armorClass, ')
          ..write('maxHealthPoints: $maxHealthPoints, ')
          ..write('currentHealthPoints: $currentHealthPoints')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          encounter.hashCode,
          $mrjc(
              name.hashCode,
              $mrjc(
                  initiative.hashCode,
                  $mrjc(
                      modifier.hashCode,
                      $mrjc(
                          condition.hashCode,
                          $mrjc(
                              armorClass.hashCode,
                              $mrjc(maxHealthPoints.hashCode,
                                  currentHealthPoints.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Character &&
          other.id == this.id &&
          other.encounter == this.encounter &&
          other.name == this.name &&
          other.initiative == this.initiative &&
          other.modifier == this.modifier &&
          other.condition == this.condition &&
          other.armorClass == this.armorClass &&
          other.maxHealthPoints == this.maxHealthPoints &&
          other.currentHealthPoints == this.currentHealthPoints);
}

class CharactersCompanion extends UpdateCompanion<Character> {
  final Value<int> id;
  final Value<int> encounter;
  final Value<String> name;
  final Value<int> initiative;
  final Value<int> modifier;
  final Value<Conditions> condition;
  final Value<int> armorClass;
  final Value<int> maxHealthPoints;
  final Value<int> currentHealthPoints;
  const CharactersCompanion({
    this.id = const Value.absent(),
    this.encounter = const Value.absent(),
    this.name = const Value.absent(),
    this.initiative = const Value.absent(),
    this.modifier = const Value.absent(),
    this.condition = const Value.absent(),
    this.armorClass = const Value.absent(),
    this.maxHealthPoints = const Value.absent(),
    this.currentHealthPoints = const Value.absent(),
  });
  CharactersCompanion.insert({
    this.id = const Value.absent(),
    @required int encounter,
    @required String name,
    @required int initiative,
    this.modifier = const Value.absent(),
    this.condition = const Value.absent(),
    this.armorClass = const Value.absent(),
    this.maxHealthPoints = const Value.absent(),
    this.currentHealthPoints = const Value.absent(),
  })  : encounter = Value(encounter),
        name = Value(name),
        initiative = Value(initiative);
  static Insertable<Character> custom({
    Expression<int> id,
    Expression<int> encounter,
    Expression<String> name,
    Expression<int> initiative,
    Expression<int> modifier,
    Expression<int> condition,
    Expression<int> armorClass,
    Expression<int> maxHealthPoints,
    Expression<int> currentHealthPoints,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (encounter != null) 'encounter': encounter,
      if (name != null) 'name': name,
      if (initiative != null) 'initiative': initiative,
      if (modifier != null) 'modifier': modifier,
      if (condition != null) 'condition': condition,
      if (armorClass != null) 'armor_class': armorClass,
      if (maxHealthPoints != null) 'max_health_points': maxHealthPoints,
      if (currentHealthPoints != null)
        'current_health_points': currentHealthPoints,
    });
  }

  CharactersCompanion copyWith(
      {Value<int> id,
      Value<int> encounter,
      Value<String> name,
      Value<int> initiative,
      Value<int> modifier,
      Value<Conditions> condition,
      Value<int> armorClass,
      Value<int> maxHealthPoints,
      Value<int> currentHealthPoints}) {
    return CharactersCompanion(
      id: id ?? this.id,
      encounter: encounter ?? this.encounter,
      name: name ?? this.name,
      initiative: initiative ?? this.initiative,
      modifier: modifier ?? this.modifier,
      condition: condition ?? this.condition,
      armorClass: armorClass ?? this.armorClass,
      maxHealthPoints: maxHealthPoints ?? this.maxHealthPoints,
      currentHealthPoints: currentHealthPoints ?? this.currentHealthPoints,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (encounter.present) {
      map['encounter'] = Variable<int>(encounter.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (initiative.present) {
      map['initiative'] = Variable<int>(initiative.value);
    }
    if (modifier.present) {
      map['modifier'] = Variable<int>(modifier.value);
    }
    if (condition.present) {
      final converter = $CharactersTable.$converter0;
      map['condition'] = Variable<int>(converter.mapToSql(condition.value));
    }
    if (armorClass.present) {
      map['armor_class'] = Variable<int>(armorClass.value);
    }
    if (maxHealthPoints.present) {
      map['max_health_points'] = Variable<int>(maxHealthPoints.value);
    }
    if (currentHealthPoints.present) {
      map['current_health_points'] = Variable<int>(currentHealthPoints.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharactersCompanion(')
          ..write('id: $id, ')
          ..write('encounter: $encounter, ')
          ..write('name: $name, ')
          ..write('initiative: $initiative, ')
          ..write('modifier: $modifier, ')
          ..write('condition: $condition, ')
          ..write('armorClass: $armorClass, ')
          ..write('maxHealthPoints: $maxHealthPoints, ')
          ..write('currentHealthPoints: $currentHealthPoints')
          ..write(')'))
        .toString();
  }
}

class $CharactersTable extends Characters
    with TableInfo<$CharactersTable, Character> {
  final GeneratedDatabase _db;
  final String _alias;
  $CharactersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _encounterMeta = const VerificationMeta('encounter');
  GeneratedIntColumn _encounter;
  @override
  GeneratedIntColumn get encounter => _encounter ??= _constructEncounter();
  GeneratedIntColumn _constructEncounter() {
    return GeneratedIntColumn('encounter', $tableName, false,
        $customConstraints: 'NULL REFERENCES encounters(id)');
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _initiativeMeta = const VerificationMeta('initiative');
  GeneratedIntColumn _initiative;
  @override
  GeneratedIntColumn get initiative => _initiative ??= _constructInitiative();
  GeneratedIntColumn _constructInitiative() {
    return GeneratedIntColumn(
      'initiative',
      $tableName,
      false,
    );
  }

  final VerificationMeta _modifierMeta = const VerificationMeta('modifier');
  GeneratedIntColumn _modifier;
  @override
  GeneratedIntColumn get modifier => _modifier ??= _constructModifier();
  GeneratedIntColumn _constructModifier() {
    return GeneratedIntColumn(
      'modifier',
      $tableName,
      true,
    );
  }

  final VerificationMeta _conditionMeta = const VerificationMeta('condition');
  GeneratedIntColumn _condition;
  @override
  GeneratedIntColumn get condition => _condition ??= _constructCondition();
  GeneratedIntColumn _constructCondition() {
    return GeneratedIntColumn('condition', $tableName, false,
        defaultValue: const Constant(8));
  }

  final VerificationMeta _armorClassMeta = const VerificationMeta('armorClass');
  GeneratedIntColumn _armorClass;
  @override
  GeneratedIntColumn get armorClass => _armorClass ??= _constructArmorClass();
  GeneratedIntColumn _constructArmorClass() {
    return GeneratedIntColumn(
      'armor_class',
      $tableName,
      true,
    );
  }

  final VerificationMeta _maxHealthPointsMeta =
      const VerificationMeta('maxHealthPoints');
  GeneratedIntColumn _maxHealthPoints;
  @override
  GeneratedIntColumn get maxHealthPoints =>
      _maxHealthPoints ??= _constructMaxHealthPoints();
  GeneratedIntColumn _constructMaxHealthPoints() {
    return GeneratedIntColumn(
      'max_health_points',
      $tableName,
      true,
    );
  }

  final VerificationMeta _currentHealthPointsMeta =
      const VerificationMeta('currentHealthPoints');
  GeneratedIntColumn _currentHealthPoints;
  @override
  GeneratedIntColumn get currentHealthPoints =>
      _currentHealthPoints ??= _constructCurrentHealthPoints();
  GeneratedIntColumn _constructCurrentHealthPoints() {
    return GeneratedIntColumn(
      'current_health_points',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        encounter,
        name,
        initiative,
        modifier,
        condition,
        armorClass,
        maxHealthPoints,
        currentHealthPoints
      ];
  @override
  $CharactersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'characters';
  @override
  final String actualTableName = 'characters';
  @override
  VerificationContext validateIntegrity(Insertable<Character> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('encounter')) {
      context.handle(_encounterMeta,
          encounter.isAcceptableOrUnknown(data['encounter'], _encounterMeta));
    } else if (isInserting) {
      context.missing(_encounterMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('initiative')) {
      context.handle(
          _initiativeMeta,
          initiative.isAcceptableOrUnknown(
              data['initiative'], _initiativeMeta));
    } else if (isInserting) {
      context.missing(_initiativeMeta);
    }
    if (data.containsKey('modifier')) {
      context.handle(_modifierMeta,
          modifier.isAcceptableOrUnknown(data['modifier'], _modifierMeta));
    }
    context.handle(_conditionMeta, const VerificationResult.success());
    if (data.containsKey('armor_class')) {
      context.handle(
          _armorClassMeta,
          armorClass.isAcceptableOrUnknown(
              data['armor_class'], _armorClassMeta));
    }
    if (data.containsKey('max_health_points')) {
      context.handle(
          _maxHealthPointsMeta,
          maxHealthPoints.isAcceptableOrUnknown(
              data['max_health_points'], _maxHealthPointsMeta));
    }
    if (data.containsKey('current_health_points')) {
      context.handle(
          _currentHealthPointsMeta,
          currentHealthPoints.isAcceptableOrUnknown(
              data['current_health_points'], _currentHealthPointsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Character map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Character.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $CharactersTable createAlias(String alias) {
    return $CharactersTable(_db, alias);
  }

  static TypeConverter<Conditions, int> $converter0 =
      const EnumIndexConverter<Conditions>(Conditions.values);
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $EncountersTable _encounters;
  $EncountersTable get encounters => _encounters ??= $EncountersTable(this);
  $CharactersTable _characters;
  $CharactersTable get characters => _characters ??= $CharactersTable(this);
  EncounterDao _encounterDao;
  EncounterDao get encounterDao =>
      _encounterDao ??= EncounterDao(this as AppDatabase);
  CharacterDao _characterDao;
  CharacterDao get characterDao =>
      _characterDao ??= CharacterDao(this as AppDatabase);
  Future<int> deleteCharacters(int var1) {
    return customUpdate(
      'DELETE FROM characters WHERE encounter = ?',
      variables: [Variable.withInt(var1)],
      updates: {characters},
      updateKind: UpdateKind.delete,
    );
  }

  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [encounters, characters];
}
