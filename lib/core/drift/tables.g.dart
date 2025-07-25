// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables.dart';

// ignore_for_file: type=lint
class $CardTable extends Card with TableInfo<$CardTable, CardData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _validPeriodMeta =
      const VerificationMeta('validPeriod');
  @override
  late final GeneratedColumn<DateTime> validPeriod = GeneratedColumn<DateTime>(
      'valid_period', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, number, name, validPeriod];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card';
  @override
  VerificationContext validateIntegrity(Insertable<CardData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('valid_period')) {
      context.handle(
          _validPeriodMeta,
          validPeriod.isAcceptableOrUnknown(
              data['valid_period']!, _validPeriodMeta));
    } else if (isInserting) {
      context.missing(_validPeriodMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      validPeriod: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}valid_period'])!,
    );
  }

  @override
  $CardTable createAlias(String alias) {
    return $CardTable(attachedDatabase, alias);
  }
}

class CardData extends DataClass implements Insertable<CardData> {
  final int id;
  final String number;
  final String name;
  final DateTime validPeriod;
  const CardData(
      {required this.id,
      required this.number,
      required this.name,
      required this.validPeriod});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['number'] = Variable<String>(number);
    map['name'] = Variable<String>(name);
    map['valid_period'] = Variable<DateTime>(validPeriod);
    return map;
  }

  CardCompanion toCompanion(bool nullToAbsent) {
    return CardCompanion(
      id: Value(id),
      number: Value(number),
      name: Value(name),
      validPeriod: Value(validPeriod),
    );
  }

  factory CardData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardData(
      id: serializer.fromJson<int>(json['id']),
      number: serializer.fromJson<String>(json['number']),
      name: serializer.fromJson<String>(json['name']),
      validPeriod: serializer.fromJson<DateTime>(json['validPeriod']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'number': serializer.toJson<String>(number),
      'name': serializer.toJson<String>(name),
      'validPeriod': serializer.toJson<DateTime>(validPeriod),
    };
  }

  CardData copyWith(
          {int? id, String? number, String? name, DateTime? validPeriod}) =>
      CardData(
        id: id ?? this.id,
        number: number ?? this.number,
        name: name ?? this.name,
        validPeriod: validPeriod ?? this.validPeriod,
      );
  CardData copyWithCompanion(CardCompanion data) {
    return CardData(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      name: data.name.present ? data.name.value : this.name,
      validPeriod:
          data.validPeriod.present ? data.validPeriod.value : this.validPeriod,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardData(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('name: $name, ')
          ..write('validPeriod: $validPeriod')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, number, name, validPeriod);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardData &&
          other.id == this.id &&
          other.number == this.number &&
          other.name == this.name &&
          other.validPeriod == this.validPeriod);
}

class CardCompanion extends UpdateCompanion<CardData> {
  final Value<int> id;
  final Value<String> number;
  final Value<String> name;
  final Value<DateTime> validPeriod;
  const CardCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.name = const Value.absent(),
    this.validPeriod = const Value.absent(),
  });
  CardCompanion.insert({
    this.id = const Value.absent(),
    required String number,
    required String name,
    required DateTime validPeriod,
  })  : number = Value(number),
        name = Value(name),
        validPeriod = Value(validPeriod);
  static Insertable<CardData> custom({
    Expression<int>? id,
    Expression<String>? number,
    Expression<String>? name,
    Expression<DateTime>? validPeriod,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (name != null) 'name': name,
      if (validPeriod != null) 'valid_period': validPeriod,
    });
  }

  CardCompanion copyWith(
      {Value<int>? id,
      Value<String>? number,
      Value<String>? name,
      Value<DateTime>? validPeriod}) {
    return CardCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      name: name ?? this.name,
      validPeriod: validPeriod ?? this.validPeriod,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (validPeriod.present) {
      map['valid_period'] = Variable<DateTime>(validPeriod.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('name: $name, ')
          ..write('validPeriod: $validPeriod')
          ..write(')'))
        .toString();
  }
}

class $CardDetailTable extends CardDetail
    with TableInfo<$CardDetailTable, CardDetailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardDetailTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idCardMeta = const VerificationMeta('idCard');
  @override
  late final GeneratedColumn<int> idCard = GeneratedColumn<int>(
      'id_card', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES card (id)'));
  static const VerificationMeta _bonusMeta = const VerificationMeta('bonus');
  @override
  late final GeneratedColumn<int> bonus = GeneratedColumn<int>(
      'bonus', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateOperationMeta =
      const VerificationMeta('dateOperation');
  @override
  late final GeneratedColumn<DateTime> dateOperation =
      GeneratedColumn<DateTime>('date_operation', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isAddBonusMeta =
      const VerificationMeta('isAddBonus');
  @override
  late final GeneratedColumn<bool> isAddBonus = GeneratedColumn<bool>(
      'is_add_bonus', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_add_bonus" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, idCard, bonus, dateOperation, isAddBonus];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_detail';
  @override
  VerificationContext validateIntegrity(Insertable<CardDetailData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_card')) {
      context.handle(_idCardMeta,
          idCard.isAcceptableOrUnknown(data['id_card']!, _idCardMeta));
    } else if (isInserting) {
      context.missing(_idCardMeta);
    }
    if (data.containsKey('bonus')) {
      context.handle(
          _bonusMeta, bonus.isAcceptableOrUnknown(data['bonus']!, _bonusMeta));
    } else if (isInserting) {
      context.missing(_bonusMeta);
    }
    if (data.containsKey('date_operation')) {
      context.handle(
          _dateOperationMeta,
          dateOperation.isAcceptableOrUnknown(
              data['date_operation']!, _dateOperationMeta));
    } else if (isInserting) {
      context.missing(_dateOperationMeta);
    }
    if (data.containsKey('is_add_bonus')) {
      context.handle(
          _isAddBonusMeta,
          isAddBonus.isAcceptableOrUnknown(
              data['is_add_bonus']!, _isAddBonusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardDetailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardDetailData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idCard: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_card'])!,
      bonus: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bonus'])!,
      dateOperation: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_operation'])!,
      isAddBonus: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_add_bonus'])!,
    );
  }

  @override
  $CardDetailTable createAlias(String alias) {
    return $CardDetailTable(attachedDatabase, alias);
  }
}

class CardDetailData extends DataClass implements Insertable<CardDetailData> {
  final int id;
  final int idCard;
  final int bonus;
  final DateTime dateOperation;
  final bool isAddBonus;
  const CardDetailData(
      {required this.id,
      required this.idCard,
      required this.bonus,
      required this.dateOperation,
      required this.isAddBonus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_card'] = Variable<int>(idCard);
    map['bonus'] = Variable<int>(bonus);
    map['date_operation'] = Variable<DateTime>(dateOperation);
    map['is_add_bonus'] = Variable<bool>(isAddBonus);
    return map;
  }

  CardDetailCompanion toCompanion(bool nullToAbsent) {
    return CardDetailCompanion(
      id: Value(id),
      idCard: Value(idCard),
      bonus: Value(bonus),
      dateOperation: Value(dateOperation),
      isAddBonus: Value(isAddBonus),
    );
  }

  factory CardDetailData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardDetailData(
      id: serializer.fromJson<int>(json['id']),
      idCard: serializer.fromJson<int>(json['idCard']),
      bonus: serializer.fromJson<int>(json['bonus']),
      dateOperation: serializer.fromJson<DateTime>(json['dateOperation']),
      isAddBonus: serializer.fromJson<bool>(json['isAddBonus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idCard': serializer.toJson<int>(idCard),
      'bonus': serializer.toJson<int>(bonus),
      'dateOperation': serializer.toJson<DateTime>(dateOperation),
      'isAddBonus': serializer.toJson<bool>(isAddBonus),
    };
  }

  CardDetailData copyWith(
          {int? id,
          int? idCard,
          int? bonus,
          DateTime? dateOperation,
          bool? isAddBonus}) =>
      CardDetailData(
        id: id ?? this.id,
        idCard: idCard ?? this.idCard,
        bonus: bonus ?? this.bonus,
        dateOperation: dateOperation ?? this.dateOperation,
        isAddBonus: isAddBonus ?? this.isAddBonus,
      );
  CardDetailData copyWithCompanion(CardDetailCompanion data) {
    return CardDetailData(
      id: data.id.present ? data.id.value : this.id,
      idCard: data.idCard.present ? data.idCard.value : this.idCard,
      bonus: data.bonus.present ? data.bonus.value : this.bonus,
      dateOperation: data.dateOperation.present
          ? data.dateOperation.value
          : this.dateOperation,
      isAddBonus:
          data.isAddBonus.present ? data.isAddBonus.value : this.isAddBonus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardDetailData(')
          ..write('id: $id, ')
          ..write('idCard: $idCard, ')
          ..write('bonus: $bonus, ')
          ..write('dateOperation: $dateOperation, ')
          ..write('isAddBonus: $isAddBonus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idCard, bonus, dateOperation, isAddBonus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardDetailData &&
          other.id == this.id &&
          other.idCard == this.idCard &&
          other.bonus == this.bonus &&
          other.dateOperation == this.dateOperation &&
          other.isAddBonus == this.isAddBonus);
}

class CardDetailCompanion extends UpdateCompanion<CardDetailData> {
  final Value<int> id;
  final Value<int> idCard;
  final Value<int> bonus;
  final Value<DateTime> dateOperation;
  final Value<bool> isAddBonus;
  const CardDetailCompanion({
    this.id = const Value.absent(),
    this.idCard = const Value.absent(),
    this.bonus = const Value.absent(),
    this.dateOperation = const Value.absent(),
    this.isAddBonus = const Value.absent(),
  });
  CardDetailCompanion.insert({
    this.id = const Value.absent(),
    required int idCard,
    required int bonus,
    required DateTime dateOperation,
    this.isAddBonus = const Value.absent(),
  })  : idCard = Value(idCard),
        bonus = Value(bonus),
        dateOperation = Value(dateOperation);
  static Insertable<CardDetailData> custom({
    Expression<int>? id,
    Expression<int>? idCard,
    Expression<int>? bonus,
    Expression<DateTime>? dateOperation,
    Expression<bool>? isAddBonus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idCard != null) 'id_card': idCard,
      if (bonus != null) 'bonus': bonus,
      if (dateOperation != null) 'date_operation': dateOperation,
      if (isAddBonus != null) 'is_add_bonus': isAddBonus,
    });
  }

  CardDetailCompanion copyWith(
      {Value<int>? id,
      Value<int>? idCard,
      Value<int>? bonus,
      Value<DateTime>? dateOperation,
      Value<bool>? isAddBonus}) {
    return CardDetailCompanion(
      id: id ?? this.id,
      idCard: idCard ?? this.idCard,
      bonus: bonus ?? this.bonus,
      dateOperation: dateOperation ?? this.dateOperation,
      isAddBonus: isAddBonus ?? this.isAddBonus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idCard.present) {
      map['id_card'] = Variable<int>(idCard.value);
    }
    if (bonus.present) {
      map['bonus'] = Variable<int>(bonus.value);
    }
    if (dateOperation.present) {
      map['date_operation'] = Variable<DateTime>(dateOperation.value);
    }
    if (isAddBonus.present) {
      map['is_add_bonus'] = Variable<bool>(isAddBonus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardDetailCompanion(')
          ..write('id: $id, ')
          ..write('idCard: $idCard, ')
          ..write('bonus: $bonus, ')
          ..write('dateOperation: $dateOperation, ')
          ..write('isAddBonus: $isAddBonus')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CardTable card = $CardTable(this);
  late final $CardDetailTable cardDetail = $CardDetailTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [card, cardDetail];
}

typedef $$CardTableCreateCompanionBuilder = CardCompanion Function({
  Value<int> id,
  required String number,
  required String name,
  required DateTime validPeriod,
});
typedef $$CardTableUpdateCompanionBuilder = CardCompanion Function({
  Value<int> id,
  Value<String> number,
  Value<String> name,
  Value<DateTime> validPeriod,
});

final class $$CardTableReferences
    extends BaseReferences<_$AppDatabase, $CardTable, CardData> {
  $$CardTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CardDetailTable, List<CardDetailData>>
      _cardDetailRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.cardDetail,
          aliasName: $_aliasNameGenerator(db.card.id, db.cardDetail.idCard));

  $$CardDetailTableProcessedTableManager get cardDetailRefs {
    final manager = $$CardDetailTableTableManager($_db, $_db.cardDetail)
        .filter((f) => f.idCard.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardDetailRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CardTableFilterComposer extends Composer<_$AppDatabase, $CardTable> {
  $$CardTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get validPeriod => $composableBuilder(
      column: $table.validPeriod, builder: (column) => ColumnFilters(column));

  Expression<bool> cardDetailRefs(
      Expression<bool> Function($$CardDetailTableFilterComposer f) f) {
    final $$CardDetailTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cardDetail,
        getReferencedColumn: (t) => t.idCard,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardDetailTableFilterComposer(
              $db: $db,
              $table: $db.cardDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CardTableOrderingComposer extends Composer<_$AppDatabase, $CardTable> {
  $$CardTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get number => $composableBuilder(
      column: $table.number, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get validPeriod => $composableBuilder(
      column: $table.validPeriod, builder: (column) => ColumnOrderings(column));
}

class $$CardTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardTable> {
  $$CardTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get validPeriod => $composableBuilder(
      column: $table.validPeriod, builder: (column) => column);

  Expression<T> cardDetailRefs<T extends Object>(
      Expression<T> Function($$CardDetailTableAnnotationComposer a) f) {
    final $$CardDetailTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cardDetail,
        getReferencedColumn: (t) => t.idCard,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardDetailTableAnnotationComposer(
              $db: $db,
              $table: $db.cardDetail,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CardTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardTable,
    CardData,
    $$CardTableFilterComposer,
    $$CardTableOrderingComposer,
    $$CardTableAnnotationComposer,
    $$CardTableCreateCompanionBuilder,
    $$CardTableUpdateCompanionBuilder,
    (CardData, $$CardTableReferences),
    CardData,
    PrefetchHooks Function({bool cardDetailRefs})> {
  $$CardTableTableManager(_$AppDatabase db, $CardTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> number = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> validPeriod = const Value.absent(),
          }) =>
              CardCompanion(
            id: id,
            number: number,
            name: name,
            validPeriod: validPeriod,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String number,
            required String name,
            required DateTime validPeriod,
          }) =>
              CardCompanion.insert(
            id: id,
            number: number,
            name: name,
            validPeriod: validPeriod,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CardTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({cardDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (cardDetailRefs) db.cardDetail],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cardDetailRefs)
                    await $_getPrefetchedData<CardData, $CardTable,
                            CardDetailData>(
                        currentTable: table,
                        referencedTable:
                            $$CardTableReferences._cardDetailRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CardTableReferences(db, table, p0).cardDetailRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.idCard == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CardTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CardTable,
    CardData,
    $$CardTableFilterComposer,
    $$CardTableOrderingComposer,
    $$CardTableAnnotationComposer,
    $$CardTableCreateCompanionBuilder,
    $$CardTableUpdateCompanionBuilder,
    (CardData, $$CardTableReferences),
    CardData,
    PrefetchHooks Function({bool cardDetailRefs})>;
typedef $$CardDetailTableCreateCompanionBuilder = CardDetailCompanion Function({
  Value<int> id,
  required int idCard,
  required int bonus,
  required DateTime dateOperation,
  Value<bool> isAddBonus,
});
typedef $$CardDetailTableUpdateCompanionBuilder = CardDetailCompanion Function({
  Value<int> id,
  Value<int> idCard,
  Value<int> bonus,
  Value<DateTime> dateOperation,
  Value<bool> isAddBonus,
});

final class $$CardDetailTableReferences
    extends BaseReferences<_$AppDatabase, $CardDetailTable, CardDetailData> {
  $$CardDetailTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CardTable _idCardTable(_$AppDatabase db) => db.card
      .createAlias($_aliasNameGenerator(db.cardDetail.idCard, db.card.id));

  $$CardTableProcessedTableManager get idCard {
    final $_column = $_itemColumn<int>('id_card')!;

    final manager = $$CardTableTableManager($_db, $_db.card)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idCardTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CardDetailTableFilterComposer
    extends Composer<_$AppDatabase, $CardDetailTable> {
  $$CardDetailTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bonus => $composableBuilder(
      column: $table.bonus, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateOperation => $composableBuilder(
      column: $table.dateOperation, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isAddBonus => $composableBuilder(
      column: $table.isAddBonus, builder: (column) => ColumnFilters(column));

  $$CardTableFilterComposer get idCard {
    final $$CardTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCard,
        referencedTable: $db.card,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardTableFilterComposer(
              $db: $db,
              $table: $db.card,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CardDetailTableOrderingComposer
    extends Composer<_$AppDatabase, $CardDetailTable> {
  $$CardDetailTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bonus => $composableBuilder(
      column: $table.bonus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateOperation => $composableBuilder(
      column: $table.dateOperation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isAddBonus => $composableBuilder(
      column: $table.isAddBonus, builder: (column) => ColumnOrderings(column));

  $$CardTableOrderingComposer get idCard {
    final $$CardTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCard,
        referencedTable: $db.card,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardTableOrderingComposer(
              $db: $db,
              $table: $db.card,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CardDetailTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardDetailTable> {
  $$CardDetailTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get bonus =>
      $composableBuilder(column: $table.bonus, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOperation => $composableBuilder(
      column: $table.dateOperation, builder: (column) => column);

  GeneratedColumn<bool> get isAddBonus => $composableBuilder(
      column: $table.isAddBonus, builder: (column) => column);

  $$CardTableAnnotationComposer get idCard {
    final $$CardTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.idCard,
        referencedTable: $db.card,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardTableAnnotationComposer(
              $db: $db,
              $table: $db.card,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CardDetailTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardDetailTable,
    CardDetailData,
    $$CardDetailTableFilterComposer,
    $$CardDetailTableOrderingComposer,
    $$CardDetailTableAnnotationComposer,
    $$CardDetailTableCreateCompanionBuilder,
    $$CardDetailTableUpdateCompanionBuilder,
    (CardDetailData, $$CardDetailTableReferences),
    CardDetailData,
    PrefetchHooks Function({bool idCard})> {
  $$CardDetailTableTableManager(_$AppDatabase db, $CardDetailTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardDetailTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardDetailTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardDetailTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> idCard = const Value.absent(),
            Value<int> bonus = const Value.absent(),
            Value<DateTime> dateOperation = const Value.absent(),
            Value<bool> isAddBonus = const Value.absent(),
          }) =>
              CardDetailCompanion(
            id: id,
            idCard: idCard,
            bonus: bonus,
            dateOperation: dateOperation,
            isAddBonus: isAddBonus,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int idCard,
            required int bonus,
            required DateTime dateOperation,
            Value<bool> isAddBonus = const Value.absent(),
          }) =>
              CardDetailCompanion.insert(
            id: id,
            idCard: idCard,
            bonus: bonus,
            dateOperation: dateOperation,
            isAddBonus: isAddBonus,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CardDetailTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({idCard = false}) {
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
                if (idCard) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.idCard,
                    referencedTable:
                        $$CardDetailTableReferences._idCardTable(db),
                    referencedColumn:
                        $$CardDetailTableReferences._idCardTable(db).id,
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

typedef $$CardDetailTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CardDetailTable,
    CardDetailData,
    $$CardDetailTableFilterComposer,
    $$CardDetailTableOrderingComposer,
    $$CardDetailTableAnnotationComposer,
    $$CardDetailTableCreateCompanionBuilder,
    $$CardDetailTableUpdateCompanionBuilder,
    (CardDetailData, $$CardDetailTableReferences),
    CardDetailData,
    PrefetchHooks Function({bool idCard})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CardTableTableManager get card => $$CardTableTableManager(_db, _db.card);
  $$CardDetailTableTableManager get cardDetail =>
      $$CardDetailTableTableManager(_db, _db.cardDetail);
}
