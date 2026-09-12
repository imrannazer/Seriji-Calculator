// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'siraji_database.dart';

// ignore_for_file: type=lint
class $CalculationsTable extends Calculations
    with TableInfo<$CalculationsTable, CalculationEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CalculationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dataJsonMeta =
      const VerificationMeta('dataJson');
  @override
  late final GeneratedColumn<String> dataJson = GeneratedColumn<String>(
      'data_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _schemaVersionMeta =
      const VerificationMeta('schemaVersion');
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
      'schema_version', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, createdAt, updatedAt, dataJson, schemaVersion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calculations';
  @override
  VerificationContext validateIntegrity(Insertable<CalculationEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('data_json')) {
      context.handle(_dataJsonMeta,
          dataJson.isAcceptableOrUnknown(data['data_json']!, _dataJsonMeta));
    } else if (isInserting) {
      context.missing(_dataJsonMeta);
    }
    if (data.containsKey('schema_version')) {
      context.handle(
          _schemaVersionMeta,
          schemaVersion.isAcceptableOrUnknown(
              data['schema_version']!, _schemaVersionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CalculationEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CalculationEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at']),
      dataJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data_json'])!,
      schemaVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}schema_version'])!,
    );
  }

  @override
  $CalculationsTable createAlias(String alias) {
    return $CalculationsTable(attachedDatabase, alias);
  }
}

class CalculationEntity extends DataClass
    implements Insertable<CalculationEntity> {
  final String id;
  final String title;
  final int createdAt;
  final int? updatedAt;
  final String dataJson;
  final int schemaVersion;
  const CalculationEntity(
      {required this.id,
      required this.title,
      required this.createdAt,
      this.updatedAt,
      required this.dataJson,
      required this.schemaVersion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    map['data_json'] = Variable<String>(dataJson);
    map['schema_version'] = Variable<int>(schemaVersion);
    return map;
  }

  CalculationsCompanion toCompanion(bool nullToAbsent) {
    return CalculationsCompanion(
      id: Value(id),
      title: Value(title),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      dataJson: Value(dataJson),
      schemaVersion: Value(schemaVersion),
    );
  }

  factory CalculationEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CalculationEntity(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
      dataJson: serializer.fromJson<String>(json['dataJson']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
      'dataJson': serializer.toJson<String>(dataJson),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
    };
  }

  CalculationEntity copyWith(
          {String? id,
          String? title,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent(),
          String? dataJson,
          int? schemaVersion}) =>
      CalculationEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        dataJson: dataJson ?? this.dataJson,
        schemaVersion: schemaVersion ?? this.schemaVersion,
      );
  CalculationEntity copyWithCompanion(CalculationsCompanion data) {
    return CalculationEntity(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      dataJson: data.dataJson.present ? data.dataJson.value : this.dataJson,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CalculationEntity(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dataJson: $dataJson, ')
          ..write('schemaVersion: $schemaVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, createdAt, updatedAt, dataJson, schemaVersion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CalculationEntity &&
          other.id == this.id &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.dataJson == this.dataJson &&
          other.schemaVersion == this.schemaVersion);
}

class CalculationsCompanion extends UpdateCompanion<CalculationEntity> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<String> dataJson;
  final Value<int> schemaVersion;
  final Value<int> rowid;
  const CalculationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.dataJson = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CalculationsCompanion.insert({
    required String id,
    required String title,
    required int createdAt,
    this.updatedAt = const Value.absent(),
    required String dataJson,
    this.schemaVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        createdAt = Value(createdAt),
        dataJson = Value(dataJson);
  static Insertable<CalculationEntity> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? dataJson,
    Expression<int>? schemaVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (dataJson != null) 'data_json': dataJson,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CalculationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<String>? dataJson,
      Value<int>? schemaVersion,
      Value<int>? rowid}) {
    return CalculationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      dataJson: dataJson ?? this.dataJson,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (dataJson.present) {
      map['data_json'] = Variable<String>(dataJson.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CalculationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('dataJson: $dataJson, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WillsTable extends Wills with TableInfo<$WillsTable, WillEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _testatorNameMeta =
      const VerificationMeta('testatorName');
  @override
  late final GeneratedColumn<String> testatorName = GeneratedColumn<String>(
      'testator_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bequestNotesMeta =
      const VerificationMeta('bequestNotes');
  @override
  late final GeneratedColumn<String> bequestNotes = GeneratedColumn<String>(
      'bequest_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dataJsonMeta =
      const VerificationMeta('dataJson');
  @override
  late final GeneratedColumn<String> dataJson = GeneratedColumn<String>(
      'data_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _schemaVersionMeta =
      const VerificationMeta('schemaVersion');
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
      'schema_version', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        testatorName,
        createdAt,
        updatedAt,
        status,
        bequestNotes,
        dataJson,
        schemaVersion
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wills';
  @override
  VerificationContext validateIntegrity(Insertable<WillEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('testator_name')) {
      context.handle(
          _testatorNameMeta,
          testatorName.isAcceptableOrUnknown(
              data['testator_name']!, _testatorNameMeta));
    } else if (isInserting) {
      context.missing(_testatorNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('bequest_notes')) {
      context.handle(
          _bequestNotesMeta,
          bequestNotes.isAcceptableOrUnknown(
              data['bequest_notes']!, _bequestNotesMeta));
    }
    if (data.containsKey('data_json')) {
      context.handle(_dataJsonMeta,
          dataJson.isAcceptableOrUnknown(data['data_json']!, _dataJsonMeta));
    }
    if (data.containsKey('schema_version')) {
      context.handle(
          _schemaVersionMeta,
          schemaVersion.isAcceptableOrUnknown(
              data['schema_version']!, _schemaVersionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WillEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WillEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      testatorName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}testator_name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updated_at']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      bequestNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bequest_notes']),
      dataJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data_json']),
      schemaVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}schema_version'])!,
    );
  }

  @override
  $WillsTable createAlias(String alias) {
    return $WillsTable(attachedDatabase, alias);
  }
}

class WillEntity extends DataClass implements Insertable<WillEntity> {
  final String id;
  final String testatorName;
  final int createdAt;
  final int? updatedAt;
  final String status;
  final String? bequestNotes;
  final String? dataJson;
  final int schemaVersion;
  const WillEntity(
      {required this.id,
      required this.testatorName,
      required this.createdAt,
      this.updatedAt,
      required this.status,
      this.bequestNotes,
      this.dataJson,
      required this.schemaVersion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['testator_name'] = Variable<String>(testatorName);
    map['created_at'] = Variable<int>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<int>(updatedAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || bequestNotes != null) {
      map['bequest_notes'] = Variable<String>(bequestNotes);
    }
    if (!nullToAbsent || dataJson != null) {
      map['data_json'] = Variable<String>(dataJson);
    }
    map['schema_version'] = Variable<int>(schemaVersion);
    return map;
  }

  WillsCompanion toCompanion(bool nullToAbsent) {
    return WillsCompanion(
      id: Value(id),
      testatorName: Value(testatorName),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      status: Value(status),
      bequestNotes: bequestNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(bequestNotes),
      dataJson: dataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(dataJson),
      schemaVersion: Value(schemaVersion),
    );
  }

  factory WillEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WillEntity(
      id: serializer.fromJson<String>(json['id']),
      testatorName: serializer.fromJson<String>(json['testatorName']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int?>(json['updatedAt']),
      status: serializer.fromJson<String>(json['status']),
      bequestNotes: serializer.fromJson<String?>(json['bequestNotes']),
      dataJson: serializer.fromJson<String?>(json['dataJson']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'testatorName': serializer.toJson<String>(testatorName),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int?>(updatedAt),
      'status': serializer.toJson<String>(status),
      'bequestNotes': serializer.toJson<String?>(bequestNotes),
      'dataJson': serializer.toJson<String?>(dataJson),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
    };
  }

  WillEntity copyWith(
          {String? id,
          String? testatorName,
          int? createdAt,
          Value<int?> updatedAt = const Value.absent(),
          String? status,
          Value<String?> bequestNotes = const Value.absent(),
          Value<String?> dataJson = const Value.absent(),
          int? schemaVersion}) =>
      WillEntity(
        id: id ?? this.id,
        testatorName: testatorName ?? this.testatorName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        status: status ?? this.status,
        bequestNotes:
            bequestNotes.present ? bequestNotes.value : this.bequestNotes,
        dataJson: dataJson.present ? dataJson.value : this.dataJson,
        schemaVersion: schemaVersion ?? this.schemaVersion,
      );
  WillEntity copyWithCompanion(WillsCompanion data) {
    return WillEntity(
      id: data.id.present ? data.id.value : this.id,
      testatorName: data.testatorName.present
          ? data.testatorName.value
          : this.testatorName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      status: data.status.present ? data.status.value : this.status,
      bequestNotes: data.bequestNotes.present
          ? data.bequestNotes.value
          : this.bequestNotes,
      dataJson: data.dataJson.present ? data.dataJson.value : this.dataJson,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WillEntity(')
          ..write('id: $id, ')
          ..write('testatorName: $testatorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('bequestNotes: $bequestNotes, ')
          ..write('dataJson: $dataJson, ')
          ..write('schemaVersion: $schemaVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, testatorName, createdAt, updatedAt,
      status, bequestNotes, dataJson, schemaVersion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WillEntity &&
          other.id == this.id &&
          other.testatorName == this.testatorName &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.status == this.status &&
          other.bequestNotes == this.bequestNotes &&
          other.dataJson == this.dataJson &&
          other.schemaVersion == this.schemaVersion);
}

class WillsCompanion extends UpdateCompanion<WillEntity> {
  final Value<String> id;
  final Value<String> testatorName;
  final Value<int> createdAt;
  final Value<int?> updatedAt;
  final Value<String> status;
  final Value<String?> bequestNotes;
  final Value<String?> dataJson;
  final Value<int> schemaVersion;
  final Value<int> rowid;
  const WillsCompanion({
    this.id = const Value.absent(),
    this.testatorName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.bequestNotes = const Value.absent(),
    this.dataJson = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WillsCompanion.insert({
    required String id,
    required String testatorName,
    required int createdAt,
    this.updatedAt = const Value.absent(),
    required String status,
    this.bequestNotes = const Value.absent(),
    this.dataJson = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        testatorName = Value(testatorName),
        createdAt = Value(createdAt),
        status = Value(status);
  static Insertable<WillEntity> custom({
    Expression<String>? id,
    Expression<String>? testatorName,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? status,
    Expression<String>? bequestNotes,
    Expression<String>? dataJson,
    Expression<int>? schemaVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (testatorName != null) 'testator_name': testatorName,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (status != null) 'status': status,
      if (bequestNotes != null) 'bequest_notes': bequestNotes,
      if (dataJson != null) 'data_json': dataJson,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WillsCompanion copyWith(
      {Value<String>? id,
      Value<String>? testatorName,
      Value<int>? createdAt,
      Value<int?>? updatedAt,
      Value<String>? status,
      Value<String?>? bequestNotes,
      Value<String?>? dataJson,
      Value<int>? schemaVersion,
      Value<int>? rowid}) {
    return WillsCompanion(
      id: id ?? this.id,
      testatorName: testatorName ?? this.testatorName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      bequestNotes: bequestNotes ?? this.bequestNotes,
      dataJson: dataJson ?? this.dataJson,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (testatorName.present) {
      map['testator_name'] = Variable<String>(testatorName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (bequestNotes.present) {
      map['bequest_notes'] = Variable<String>(bequestNotes.value);
    }
    if (dataJson.present) {
      map['data_json'] = Variable<String>(dataJson.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WillsCompanion(')
          ..write('id: $id, ')
          ..write('testatorName: $testatorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('bequestNotes: $bequestNotes, ')
          ..write('dataJson: $dataJson, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$SirajiDatabase extends GeneratedDatabase {
  _$SirajiDatabase(QueryExecutor e) : super(e);
  $SirajiDatabaseManager get managers => $SirajiDatabaseManager(this);
  late final $CalculationsTable calculations = $CalculationsTable(this);
  late final $WillsTable wills = $WillsTable(this);
  late final CalculationsDao calculationsDao =
      CalculationsDao(this as SirajiDatabase);
  late final WillsDao willsDao = WillsDao(this as SirajiDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [calculations, wills];
}

typedef $$CalculationsTableCreateCompanionBuilder = CalculationsCompanion
    Function({
  required String id,
  required String title,
  required int createdAt,
  Value<int?> updatedAt,
  required String dataJson,
  Value<int> schemaVersion,
  Value<int> rowid,
});
typedef $$CalculationsTableUpdateCompanionBuilder = CalculationsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<String> dataJson,
  Value<int> schemaVersion,
  Value<int> rowid,
});

class $$CalculationsTableFilterComposer
    extends Composer<_$SirajiDatabase, $CalculationsTable> {
  $$CalculationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dataJson => $composableBuilder(
      column: $table.dataJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion, builder: (column) => ColumnFilters(column));
}

class $$CalculationsTableOrderingComposer
    extends Composer<_$SirajiDatabase, $CalculationsTable> {
  $$CalculationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dataJson => $composableBuilder(
      column: $table.dataJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion,
      builder: (column) => ColumnOrderings(column));
}

class $$CalculationsTableAnnotationComposer
    extends Composer<_$SirajiDatabase, $CalculationsTable> {
  $$CalculationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get dataJson =>
      $composableBuilder(column: $table.dataJson, builder: (column) => column);

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion, builder: (column) => column);
}

class $$CalculationsTableTableManager extends RootTableManager<
    _$SirajiDatabase,
    $CalculationsTable,
    CalculationEntity,
    $$CalculationsTableFilterComposer,
    $$CalculationsTableOrderingComposer,
    $$CalculationsTableAnnotationComposer,
    $$CalculationsTableCreateCompanionBuilder,
    $$CalculationsTableUpdateCompanionBuilder,
    (
      CalculationEntity,
      BaseReferences<_$SirajiDatabase, $CalculationsTable, CalculationEntity>
    ),
    CalculationEntity,
    PrefetchHooks Function()> {
  $$CalculationsTableTableManager(_$SirajiDatabase db, $CalculationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CalculationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CalculationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CalculationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<String> dataJson = const Value.absent(),
            Value<int> schemaVersion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CalculationsCompanion(
            id: id,
            title: title,
            createdAt: createdAt,
            updatedAt: updatedAt,
            dataJson: dataJson,
            schemaVersion: schemaVersion,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required int createdAt,
            Value<int?> updatedAt = const Value.absent(),
            required String dataJson,
            Value<int> schemaVersion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CalculationsCompanion.insert(
            id: id,
            title: title,
            createdAt: createdAt,
            updatedAt: updatedAt,
            dataJson: dataJson,
            schemaVersion: schemaVersion,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CalculationsTableProcessedTableManager = ProcessedTableManager<
    _$SirajiDatabase,
    $CalculationsTable,
    CalculationEntity,
    $$CalculationsTableFilterComposer,
    $$CalculationsTableOrderingComposer,
    $$CalculationsTableAnnotationComposer,
    $$CalculationsTableCreateCompanionBuilder,
    $$CalculationsTableUpdateCompanionBuilder,
    (
      CalculationEntity,
      BaseReferences<_$SirajiDatabase, $CalculationsTable, CalculationEntity>
    ),
    CalculationEntity,
    PrefetchHooks Function()>;
typedef $$WillsTableCreateCompanionBuilder = WillsCompanion Function({
  required String id,
  required String testatorName,
  required int createdAt,
  Value<int?> updatedAt,
  required String status,
  Value<String?> bequestNotes,
  Value<String?> dataJson,
  Value<int> schemaVersion,
  Value<int> rowid,
});
typedef $$WillsTableUpdateCompanionBuilder = WillsCompanion Function({
  Value<String> id,
  Value<String> testatorName,
  Value<int> createdAt,
  Value<int?> updatedAt,
  Value<String> status,
  Value<String?> bequestNotes,
  Value<String?> dataJson,
  Value<int> schemaVersion,
  Value<int> rowid,
});

class $$WillsTableFilterComposer
    extends Composer<_$SirajiDatabase, $WillsTable> {
  $$WillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get testatorName => $composableBuilder(
      column: $table.testatorName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bequestNotes => $composableBuilder(
      column: $table.bequestNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dataJson => $composableBuilder(
      column: $table.dataJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion, builder: (column) => ColumnFilters(column));
}

class $$WillsTableOrderingComposer
    extends Composer<_$SirajiDatabase, $WillsTable> {
  $$WillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get testatorName => $composableBuilder(
      column: $table.testatorName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bequestNotes => $composableBuilder(
      column: $table.bequestNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dataJson => $composableBuilder(
      column: $table.dataJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion,
      builder: (column) => ColumnOrderings(column));
}

class $$WillsTableAnnotationComposer
    extends Composer<_$SirajiDatabase, $WillsTable> {
  $$WillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get testatorName => $composableBuilder(
      column: $table.testatorName, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get bequestNotes => $composableBuilder(
      column: $table.bequestNotes, builder: (column) => column);

  GeneratedColumn<String> get dataJson =>
      $composableBuilder(column: $table.dataJson, builder: (column) => column);

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
      column: $table.schemaVersion, builder: (column) => column);
}

class $$WillsTableTableManager extends RootTableManager<
    _$SirajiDatabase,
    $WillsTable,
    WillEntity,
    $$WillsTableFilterComposer,
    $$WillsTableOrderingComposer,
    $$WillsTableAnnotationComposer,
    $$WillsTableCreateCompanionBuilder,
    $$WillsTableUpdateCompanionBuilder,
    (WillEntity, BaseReferences<_$SirajiDatabase, $WillsTable, WillEntity>),
    WillEntity,
    PrefetchHooks Function()> {
  $$WillsTableTableManager(_$SirajiDatabase db, $WillsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> testatorName = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int?> updatedAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> bequestNotes = const Value.absent(),
            Value<String?> dataJson = const Value.absent(),
            Value<int> schemaVersion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WillsCompanion(
            id: id,
            testatorName: testatorName,
            createdAt: createdAt,
            updatedAt: updatedAt,
            status: status,
            bequestNotes: bequestNotes,
            dataJson: dataJson,
            schemaVersion: schemaVersion,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String testatorName,
            required int createdAt,
            Value<int?> updatedAt = const Value.absent(),
            required String status,
            Value<String?> bequestNotes = const Value.absent(),
            Value<String?> dataJson = const Value.absent(),
            Value<int> schemaVersion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WillsCompanion.insert(
            id: id,
            testatorName: testatorName,
            createdAt: createdAt,
            updatedAt: updatedAt,
            status: status,
            bequestNotes: bequestNotes,
            dataJson: dataJson,
            schemaVersion: schemaVersion,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WillsTableProcessedTableManager = ProcessedTableManager<
    _$SirajiDatabase,
    $WillsTable,
    WillEntity,
    $$WillsTableFilterComposer,
    $$WillsTableOrderingComposer,
    $$WillsTableAnnotationComposer,
    $$WillsTableCreateCompanionBuilder,
    $$WillsTableUpdateCompanionBuilder,
    (WillEntity, BaseReferences<_$SirajiDatabase, $WillsTable, WillEntity>),
    WillEntity,
    PrefetchHooks Function()>;

class $SirajiDatabaseManager {
  final _$SirajiDatabase _db;
  $SirajiDatabaseManager(this._db);
  $$CalculationsTableTableManager get calculations =>
      $$CalculationsTableTableManager(_db, _db.calculations);
  $$WillsTableTableManager get wills =>
      $$WillsTableTableManager(_db, _db.wills);
}
