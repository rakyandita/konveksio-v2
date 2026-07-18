// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BranchesTable extends Branches with TableInfo<$BranchesTable, Branche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, address, phone, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Branche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Branche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Branche(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $BranchesTable createAlias(String alias) {
    return $BranchesTable(attachedDatabase, alias);
  }
}

class Branche extends DataClass implements Insertable<Branche> {
  final String id;
  final String name;
  final String? address;
  final String? phone;
  final bool isActive;
  const Branche({
    required this.id,
    required this.name,
    this.address,
    this.phone,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  BranchesCompanion toCompanion(bool nullToAbsent) {
    return BranchesCompanion(
      id: Value(id),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      isActive: Value(isActive),
    );
  }

  factory Branche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Branche(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      phone: serializer.fromJson<String?>(json['phone']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'phone': serializer.toJson<String?>(phone),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Branche copyWith({
    String? id,
    String? name,
    Value<String?> address = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    bool? isActive,
  }) => Branche(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address.present ? address.value : this.address,
    phone: phone.present ? phone.value : this.phone,
    isActive: isActive ?? this.isActive,
  );
  Branche copyWithCompanion(BranchesCompanion data) {
    return Branche(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      phone: data.phone.present ? data.phone.value : this.phone,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Branche(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, address, phone, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Branche &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.phone == this.phone &&
          other.isActive == this.isActive);
}

class BranchesCompanion extends UpdateCompanion<Branche> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> address;
  final Value<String?> phone;
  final Value<bool> isActive;
  final Value<int> rowid;
  const BranchesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BranchesCompanion.insert({
    required String id,
    required String name,
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Branche> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? phone,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BranchesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? address,
    Value<String?>? phone,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return BranchesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BranchSettingsTable extends BranchSettings
    with TableInfo<$BranchSettingsTable, BranchSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _paymentSystemMeta = const VerificationMeta(
    'paymentSystem',
  );
  @override
  late final GeneratedColumn<String> paymentSystem = GeneratedColumn<String>(
    'payment_system',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxKasbonPercentageMeta =
      const VerificationMeta('maxKasbonPercentage');
  @override
  late final GeneratedColumn<double> maxKasbonPercentage =
      GeneratedColumn<double>(
        'max_kasbon_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    branchId,
    paymentSystem,
    maxKasbonPercentage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branch_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<BranchSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('payment_system')) {
      context.handle(
        _paymentSystemMeta,
        paymentSystem.isAcceptableOrUnknown(
          data['payment_system']!,
          _paymentSystemMeta,
        ),
      );
    }
    if (data.containsKey('max_kasbon_percentage')) {
      context.handle(
        _maxKasbonPercentageMeta,
        maxKasbonPercentage.isAcceptableOrUnknown(
          data['max_kasbon_percentage']!,
          _maxKasbonPercentageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {branchId};
  @override
  BranchSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BranchSetting(
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      paymentSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_system'],
      ),
      maxKasbonPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_kasbon_percentage'],
      ),
    );
  }

  @override
  $BranchSettingsTable createAlias(String alias) {
    return $BranchSettingsTable(attachedDatabase, alias);
  }
}

class BranchSetting extends DataClass implements Insertable<BranchSetting> {
  final String branchId;
  final String? paymentSystem;
  final double? maxKasbonPercentage;
  const BranchSetting({
    required this.branchId,
    this.paymentSystem,
    this.maxKasbonPercentage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['branch_id'] = Variable<String>(branchId);
    if (!nullToAbsent || paymentSystem != null) {
      map['payment_system'] = Variable<String>(paymentSystem);
    }
    if (!nullToAbsent || maxKasbonPercentage != null) {
      map['max_kasbon_percentage'] = Variable<double>(maxKasbonPercentage);
    }
    return map;
  }

  BranchSettingsCompanion toCompanion(bool nullToAbsent) {
    return BranchSettingsCompanion(
      branchId: Value(branchId),
      paymentSystem: paymentSystem == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentSystem),
      maxKasbonPercentage: maxKasbonPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(maxKasbonPercentage),
    );
  }

  factory BranchSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BranchSetting(
      branchId: serializer.fromJson<String>(json['branchId']),
      paymentSystem: serializer.fromJson<String?>(json['paymentSystem']),
      maxKasbonPercentage: serializer.fromJson<double?>(
        json['maxKasbonPercentage'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'branchId': serializer.toJson<String>(branchId),
      'paymentSystem': serializer.toJson<String?>(paymentSystem),
      'maxKasbonPercentage': serializer.toJson<double?>(maxKasbonPercentage),
    };
  }

  BranchSetting copyWith({
    String? branchId,
    Value<String?> paymentSystem = const Value.absent(),
    Value<double?> maxKasbonPercentage = const Value.absent(),
  }) => BranchSetting(
    branchId: branchId ?? this.branchId,
    paymentSystem: paymentSystem.present
        ? paymentSystem.value
        : this.paymentSystem,
    maxKasbonPercentage: maxKasbonPercentage.present
        ? maxKasbonPercentage.value
        : this.maxKasbonPercentage,
  );
  BranchSetting copyWithCompanion(BranchSettingsCompanion data) {
    return BranchSetting(
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      paymentSystem: data.paymentSystem.present
          ? data.paymentSystem.value
          : this.paymentSystem,
      maxKasbonPercentage: data.maxKasbonPercentage.present
          ? data.maxKasbonPercentage.value
          : this.maxKasbonPercentage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BranchSetting(')
          ..write('branchId: $branchId, ')
          ..write('paymentSystem: $paymentSystem, ')
          ..write('maxKasbonPercentage: $maxKasbonPercentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(branchId, paymentSystem, maxKasbonPercentage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BranchSetting &&
          other.branchId == this.branchId &&
          other.paymentSystem == this.paymentSystem &&
          other.maxKasbonPercentage == this.maxKasbonPercentage);
}

class BranchSettingsCompanion extends UpdateCompanion<BranchSetting> {
  final Value<String> branchId;
  final Value<String?> paymentSystem;
  final Value<double?> maxKasbonPercentage;
  final Value<int> rowid;
  const BranchSettingsCompanion({
    this.branchId = const Value.absent(),
    this.paymentSystem = const Value.absent(),
    this.maxKasbonPercentage = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BranchSettingsCompanion.insert({
    required String branchId,
    this.paymentSystem = const Value.absent(),
    this.maxKasbonPercentage = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : branchId = Value(branchId);
  static Insertable<BranchSetting> custom({
    Expression<String>? branchId,
    Expression<String>? paymentSystem,
    Expression<double>? maxKasbonPercentage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (branchId != null) 'branch_id': branchId,
      if (paymentSystem != null) 'payment_system': paymentSystem,
      if (maxKasbonPercentage != null)
        'max_kasbon_percentage': maxKasbonPercentage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BranchSettingsCompanion copyWith({
    Value<String>? branchId,
    Value<String?>? paymentSystem,
    Value<double?>? maxKasbonPercentage,
    Value<int>? rowid,
  }) {
    return BranchSettingsCompanion(
      branchId: branchId ?? this.branchId,
      paymentSystem: paymentSystem ?? this.paymentSystem,
      maxKasbonPercentage: maxKasbonPercentage ?? this.maxKasbonPercentage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (paymentSystem.present) {
      map['payment_system'] = Variable<String>(paymentSystem.value);
    }
    if (maxKasbonPercentage.present) {
      map['max_kasbon_percentage'] = Variable<double>(
        maxKasbonPercentage.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchSettingsCompanion(')
          ..write('branchId: $branchId, ')
          ..write('paymentSystem: $paymentSystem, ')
          ..write('maxKasbonPercentage: $maxKasbonPercentage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, branchId, role, name, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Profile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final String id;
  final String branchId;
  final String role;
  final String name;
  final bool isActive;
  const Profile({
    required this.id,
    required this.branchId,
    required this.role,
    required this.name,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['role'] = Variable<String>(role);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      branchId: Value(branchId),
      role: Value(role),
      name: Value(name),
      isActive: Value(isActive),
    );
  }

  factory Profile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      role: serializer.fromJson<String>(json['role']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'role': serializer.toJson<String>(role),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Profile copyWith({
    String? id,
    String? branchId,
    String? role,
    String? name,
    bool? isActive,
  }) => Profile(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    role: role ?? this.role,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
  );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      role: data.role.present ? data.role.value : this.role,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('role: $role, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, branchId, role, name, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.role == this.role &&
          other.name == this.name &&
          other.isActive == this.isActive);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> role;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.role = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    required String branchId,
    required String role,
    required String name,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       role = Value(role),
       name = Value(name);
  static Insertable<Profile> custom({
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? role,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (role != null) 'role': role,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? role,
    Value<String>? name,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      role: role ?? this.role,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('role: $role, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AdminPermissionsTable extends AdminPermissions
    with TableInfo<$AdminPermissionsTable, AdminPermission> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdminPermissionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id)',
    ),
  );
  static const VerificationMeta _canManageOrdersMeta = const VerificationMeta(
    'canManageOrders',
  );
  @override
  late final GeneratedColumn<bool> canManageOrders = GeneratedColumn<bool>(
    'can_manage_orders',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_manage_orders" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _canManageProductionMeta =
      const VerificationMeta('canManageProduction');
  @override
  late final GeneratedColumn<bool> canManageProduction = GeneratedColumn<bool>(
    'can_manage_production',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_manage_production" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _canViewReportsMeta = const VerificationMeta(
    'canViewReports',
  );
  @override
  late final GeneratedColumn<bool> canViewReports = GeneratedColumn<bool>(
    'can_view_reports',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_view_reports" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    canManageOrders,
    canManageProduction,
    canViewReports,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'admin_permissions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AdminPermission> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('can_manage_orders')) {
      context.handle(
        _canManageOrdersMeta,
        canManageOrders.isAcceptableOrUnknown(
          data['can_manage_orders']!,
          _canManageOrdersMeta,
        ),
      );
    }
    if (data.containsKey('can_manage_production')) {
      context.handle(
        _canManageProductionMeta,
        canManageProduction.isAcceptableOrUnknown(
          data['can_manage_production']!,
          _canManageProductionMeta,
        ),
      );
    }
    if (data.containsKey('can_view_reports')) {
      context.handle(
        _canViewReportsMeta,
        canViewReports.isAcceptableOrUnknown(
          data['can_view_reports']!,
          _canViewReportsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  AdminPermission map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdminPermission(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      canManageOrders: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_manage_orders'],
      )!,
      canManageProduction: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_manage_production'],
      )!,
      canViewReports: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_view_reports'],
      )!,
    );
  }

  @override
  $AdminPermissionsTable createAlias(String alias) {
    return $AdminPermissionsTable(attachedDatabase, alias);
  }
}

class AdminPermission extends DataClass implements Insertable<AdminPermission> {
  final String userId;
  final bool canManageOrders;
  final bool canManageProduction;
  final bool canViewReports;
  const AdminPermission({
    required this.userId,
    required this.canManageOrders,
    required this.canManageProduction,
    required this.canViewReports,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['can_manage_orders'] = Variable<bool>(canManageOrders);
    map['can_manage_production'] = Variable<bool>(canManageProduction);
    map['can_view_reports'] = Variable<bool>(canViewReports);
    return map;
  }

  AdminPermissionsCompanion toCompanion(bool nullToAbsent) {
    return AdminPermissionsCompanion(
      userId: Value(userId),
      canManageOrders: Value(canManageOrders),
      canManageProduction: Value(canManageProduction),
      canViewReports: Value(canViewReports),
    );
  }

  factory AdminPermission.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdminPermission(
      userId: serializer.fromJson<String>(json['userId']),
      canManageOrders: serializer.fromJson<bool>(json['canManageOrders']),
      canManageProduction: serializer.fromJson<bool>(
        json['canManageProduction'],
      ),
      canViewReports: serializer.fromJson<bool>(json['canViewReports']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'canManageOrders': serializer.toJson<bool>(canManageOrders),
      'canManageProduction': serializer.toJson<bool>(canManageProduction),
      'canViewReports': serializer.toJson<bool>(canViewReports),
    };
  }

  AdminPermission copyWith({
    String? userId,
    bool? canManageOrders,
    bool? canManageProduction,
    bool? canViewReports,
  }) => AdminPermission(
    userId: userId ?? this.userId,
    canManageOrders: canManageOrders ?? this.canManageOrders,
    canManageProduction: canManageProduction ?? this.canManageProduction,
    canViewReports: canViewReports ?? this.canViewReports,
  );
  AdminPermission copyWithCompanion(AdminPermissionsCompanion data) {
    return AdminPermission(
      userId: data.userId.present ? data.userId.value : this.userId,
      canManageOrders: data.canManageOrders.present
          ? data.canManageOrders.value
          : this.canManageOrders,
      canManageProduction: data.canManageProduction.present
          ? data.canManageProduction.value
          : this.canManageProduction,
      canViewReports: data.canViewReports.present
          ? data.canViewReports.value
          : this.canViewReports,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdminPermission(')
          ..write('userId: $userId, ')
          ..write('canManageOrders: $canManageOrders, ')
          ..write('canManageProduction: $canManageProduction, ')
          ..write('canViewReports: $canViewReports')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(userId, canManageOrders, canManageProduction, canViewReports);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdminPermission &&
          other.userId == this.userId &&
          other.canManageOrders == this.canManageOrders &&
          other.canManageProduction == this.canManageProduction &&
          other.canViewReports == this.canViewReports);
}

class AdminPermissionsCompanion extends UpdateCompanion<AdminPermission> {
  final Value<String> userId;
  final Value<bool> canManageOrders;
  final Value<bool> canManageProduction;
  final Value<bool> canViewReports;
  final Value<int> rowid;
  const AdminPermissionsCompanion({
    this.userId = const Value.absent(),
    this.canManageOrders = const Value.absent(),
    this.canManageProduction = const Value.absent(),
    this.canViewReports = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AdminPermissionsCompanion.insert({
    required String userId,
    this.canManageOrders = const Value.absent(),
    this.canManageProduction = const Value.absent(),
    this.canViewReports = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<AdminPermission> custom({
    Expression<String>? userId,
    Expression<bool>? canManageOrders,
    Expression<bool>? canManageProduction,
    Expression<bool>? canViewReports,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (canManageOrders != null) 'can_manage_orders': canManageOrders,
      if (canManageProduction != null)
        'can_manage_production': canManageProduction,
      if (canViewReports != null) 'can_view_reports': canViewReports,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AdminPermissionsCompanion copyWith({
    Value<String>? userId,
    Value<bool>? canManageOrders,
    Value<bool>? canManageProduction,
    Value<bool>? canViewReports,
    Value<int>? rowid,
  }) {
    return AdminPermissionsCompanion(
      userId: userId ?? this.userId,
      canManageOrders: canManageOrders ?? this.canManageOrders,
      canManageProduction: canManageProduction ?? this.canManageProduction,
      canViewReports: canViewReports ?? this.canViewReports,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (canManageOrders.present) {
      map['can_manage_orders'] = Variable<bool>(canManageOrders.value);
    }
    if (canManageProduction.present) {
      map['can_manage_production'] = Variable<bool>(canManageProduction.value);
    }
    if (canViewReports.present) {
      map['can_view_reports'] = Variable<bool>(canViewReports.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdminPermissionsCompanion(')
          ..write('userId: $userId, ')
          ..write('canManageOrders: $canManageOrders, ')
          ..write('canManageProduction: $canManageProduction, ')
          ..write('canViewReports: $canViewReports, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SizeGroupsTable extends SizeGroups
    with TableInfo<$SizeGroupsTable, SizeGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SizeGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizesMeta = const VerificationMeta('sizes');
  @override
  late final GeneratedColumn<String> sizes = GeneratedColumn<String>(
    'sizes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, branchId, name, sizes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'size_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<SizeGroup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sizes')) {
      context.handle(
        _sizesMeta,
        sizes.isAcceptableOrUnknown(data['sizes']!, _sizesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SizeGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SizeGroup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sizes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sizes'],
      )!,
    );
  }

  @override
  $SizeGroupsTable createAlias(String alias) {
    return $SizeGroupsTable(attachedDatabase, alias);
  }
}

class SizeGroup extends DataClass implements Insertable<SizeGroup> {
  final String id;
  final String branchId;
  final String name;
  final String sizes;
  const SizeGroup({
    required this.id,
    required this.branchId,
    required this.name,
    required this.sizes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['name'] = Variable<String>(name);
    map['sizes'] = Variable<String>(sizes);
    return map;
  }

  SizeGroupsCompanion toCompanion(bool nullToAbsent) {
    return SizeGroupsCompanion(
      id: Value(id),
      branchId: Value(branchId),
      name: Value(name),
      sizes: Value(sizes),
    );
  }

  factory SizeGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SizeGroup(
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      sizes: serializer.fromJson<String>(json['sizes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'name': serializer.toJson<String>(name),
      'sizes': serializer.toJson<String>(sizes),
    };
  }

  SizeGroup copyWith({
    String? id,
    String? branchId,
    String? name,
    String? sizes,
  }) => SizeGroup(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    name: name ?? this.name,
    sizes: sizes ?? this.sizes,
  );
  SizeGroup copyWithCompanion(SizeGroupsCompanion data) {
    return SizeGroup(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      sizes: data.sizes.present ? data.sizes.value : this.sizes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SizeGroup(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('sizes: $sizes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, branchId, name, sizes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SizeGroup &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.sizes == this.sizes);
}

class SizeGroupsCompanion extends UpdateCompanion<SizeGroup> {
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> name;
  final Value<String> sizes;
  final Value<int> rowid;
  const SizeGroupsCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.sizes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SizeGroupsCompanion.insert({
    required String id,
    required String branchId,
    required String name,
    required String sizes,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       name = Value(name),
       sizes = Value(sizes);
  static Insertable<SizeGroup> custom({
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? name,
    Expression<String>? sizes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (sizes != null) 'sizes': sizes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SizeGroupsCompanion copyWith({
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? name,
    Value<String>? sizes,
    Value<int>? rowid,
  }) {
    return SizeGroupsCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      sizes: sizes ?? this.sizes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sizes.present) {
      map['sizes'] = Variable<String>(sizes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SizeGroupsCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('sizes: $sizes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeGroupIdMeta = const VerificationMeta(
    'sizeGroupId',
  );
  @override
  late final GeneratedColumn<String> sizeGroupId = GeneratedColumn<String>(
    'size_group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES size_groups (id)',
    ),
  );
  static const VerificationMeta _priceMinMeta = const VerificationMeta(
    'priceMin',
  );
  @override
  late final GeneratedColumn<double> priceMin = GeneratedColumn<double>(
    'price_min',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMaxMeta = const VerificationMeta(
    'priceMax',
  );
  @override
  late final GeneratedColumn<double> priceMax = GeneratedColumn<double>(
    'price_max',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    branchId,
    name,
    category,
    sizeGroupId,
    priceMin,
    priceMax,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('size_group_id')) {
      context.handle(
        _sizeGroupIdMeta,
        sizeGroupId.isAcceptableOrUnknown(
          data['size_group_id']!,
          _sizeGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sizeGroupIdMeta);
    }
    if (data.containsKey('price_min')) {
      context.handle(
        _priceMinMeta,
        priceMin.isAcceptableOrUnknown(data['price_min']!, _priceMinMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMinMeta);
    }
    if (data.containsKey('price_max')) {
      context.handle(
        _priceMaxMeta,
        priceMax.isAcceptableOrUnknown(data['price_max']!, _priceMaxMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMaxMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      sizeGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size_group_id'],
      )!,
      priceMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_min'],
      )!,
      priceMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_max'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String branchId;
  final String name;
  final String category;
  final String sizeGroupId;
  final double priceMin;
  final double priceMax;
  final bool isActive;
  const Product({
    required this.id,
    required this.branchId,
    required this.name,
    required this.category,
    required this.sizeGroupId,
    required this.priceMin,
    required this.priceMax,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['size_group_id'] = Variable<String>(sizeGroupId);
    map['price_min'] = Variable<double>(priceMin);
    map['price_max'] = Variable<double>(priceMax);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      branchId: Value(branchId),
      name: Value(name),
      category: Value(category),
      sizeGroupId: Value(sizeGroupId),
      priceMin: Value(priceMin),
      priceMax: Value(priceMax),
      isActive: Value(isActive),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      sizeGroupId: serializer.fromJson<String>(json['sizeGroupId']),
      priceMin: serializer.fromJson<double>(json['priceMin']),
      priceMax: serializer.fromJson<double>(json['priceMax']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'sizeGroupId': serializer.toJson<String>(sizeGroupId),
      'priceMin': serializer.toJson<double>(priceMin),
      'priceMax': serializer.toJson<double>(priceMax),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Product copyWith({
    String? id,
    String? branchId,
    String? name,
    String? category,
    String? sizeGroupId,
    double? priceMin,
    double? priceMax,
    bool? isActive,
  }) => Product(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    name: name ?? this.name,
    category: category ?? this.category,
    sizeGroupId: sizeGroupId ?? this.sizeGroupId,
    priceMin: priceMin ?? this.priceMin,
    priceMax: priceMax ?? this.priceMax,
    isActive: isActive ?? this.isActive,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      sizeGroupId: data.sizeGroupId.present
          ? data.sizeGroupId.value
          : this.sizeGroupId,
      priceMin: data.priceMin.present ? data.priceMin.value : this.priceMin,
      priceMax: data.priceMax.present ? data.priceMax.value : this.priceMax,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('sizeGroupId: $sizeGroupId, ')
          ..write('priceMin: $priceMin, ')
          ..write('priceMax: $priceMax, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    branchId,
    name,
    category,
    sizeGroupId,
    priceMin,
    priceMax,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.category == this.category &&
          other.sizeGroupId == this.sizeGroupId &&
          other.priceMin == this.priceMin &&
          other.priceMax == this.priceMax &&
          other.isActive == this.isActive);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> name;
  final Value<String> category;
  final Value<String> sizeGroupId;
  final Value<double> priceMin;
  final Value<double> priceMax;
  final Value<bool> isActive;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.sizeGroupId = const Value.absent(),
    this.priceMin = const Value.absent(),
    this.priceMax = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    required String branchId,
    required String name,
    required String category,
    required String sizeGroupId,
    required double priceMin,
    required double priceMax,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       name = Value(name),
       category = Value(category),
       sizeGroupId = Value(sizeGroupId),
       priceMin = Value(priceMin),
       priceMax = Value(priceMax);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? sizeGroupId,
    Expression<double>? priceMin,
    Expression<double>? priceMax,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (sizeGroupId != null) 'size_group_id': sizeGroupId,
      if (priceMin != null) 'price_min': priceMin,
      if (priceMax != null) 'price_max': priceMax,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? name,
    Value<String>? category,
    Value<String>? sizeGroupId,
    Value<double>? priceMin,
    Value<double>? priceMax,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      category: category ?? this.category,
      sizeGroupId: sizeGroupId ?? this.sizeGroupId,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (sizeGroupId.present) {
      map['size_group_id'] = Variable<String>(sizeGroupId.value);
    }
    if (priceMin.present) {
      map['price_min'] = Variable<double>(priceMin.value);
    }
    if (priceMax.present) {
      map['price_max'] = Variable<double>(priceMax.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('sizeGroupId: $sizeGroupId, ')
          ..write('priceMin: $priceMin, ')
          ..write('priceMax: $priceMax, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VendorsTable extends Vendors with TableInfo<$VendorsTable, Vendor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VendorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _divisionMeta = const VerificationMeta(
    'division',
  );
  @override
  late final GeneratedColumn<String> division = GeneratedColumn<String>(
    'division',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    branchId,
    name,
    division,
    phone,
    notes,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vendors';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vendor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('division')) {
      context.handle(
        _divisionMeta,
        division.isAcceptableOrUnknown(data['division']!, _divisionMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vendor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vendor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      division: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}division'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $VendorsTable createAlias(String alias) {
    return $VendorsTable(attachedDatabase, alias);
  }
}

class Vendor extends DataClass implements Insertable<Vendor> {
  final String id;
  final String branchId;
  final String name;
  final String? division;
  final String? phone;
  final String? notes;
  final bool isActive;
  const Vendor({
    required this.id,
    required this.branchId,
    required this.name,
    this.division,
    this.phone,
    this.notes,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || division != null) {
      map['division'] = Variable<String>(division);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  VendorsCompanion toCompanion(bool nullToAbsent) {
    return VendorsCompanion(
      id: Value(id),
      branchId: Value(branchId),
      name: Value(name),
      division: division == null && nullToAbsent
          ? const Value.absent()
          : Value(division),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
    );
  }

  factory Vendor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vendor(
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      division: serializer.fromJson<String?>(json['division']),
      phone: serializer.fromJson<String?>(json['phone']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'name': serializer.toJson<String>(name),
      'division': serializer.toJson<String?>(division),
      'phone': serializer.toJson<String?>(phone),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Vendor copyWith({
    String? id,
    String? branchId,
    String? name,
    Value<String?> division = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isActive,
  }) => Vendor(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    name: name ?? this.name,
    division: division.present ? division.value : this.division,
    phone: phone.present ? phone.value : this.phone,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
  );
  Vendor copyWithCompanion(VendorsCompanion data) {
    return Vendor(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      division: data.division.present ? data.division.value : this.division,
      phone: data.phone.present ? data.phone.value : this.phone,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vendor(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('division: $division, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, branchId, name, division, phone, notes, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vendor &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.division == this.division &&
          other.phone == this.phone &&
          other.notes == this.notes &&
          other.isActive == this.isActive);
}

class VendorsCompanion extends UpdateCompanion<Vendor> {
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> name;
  final Value<String?> division;
  final Value<String?> phone;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<int> rowid;
  const VendorsCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.division = const Value.absent(),
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VendorsCompanion.insert({
    required String id,
    required String branchId,
    required String name,
    this.division = const Value.absent(),
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       name = Value(name);
  static Insertable<Vendor> custom({
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? name,
    Expression<String>? division,
    Expression<String>? phone,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (division != null) 'division': division,
      if (phone != null) 'phone': phone,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VendorsCompanion copyWith({
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? name,
    Value<String?>? division,
    Value<String?>? phone,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return VendorsCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      division: division ?? this.division,
      phone: phone ?? this.phone,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (division.present) {
      map['division'] = Variable<String>(division.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VendorsCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('division: $division, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmployeeRatesTable extends EmployeeRates
    with TableInfo<$EmployeeRatesTable, EmployeeRate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeeRatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id)',
    ),
  );
  static const VerificationMeta _divisionMeta = const VerificationMeta(
    'division',
  );
  @override
  late final GeneratedColumn<String> division = GeneratedColumn<String>(
    'division',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratePerPcsMeta = const VerificationMeta(
    'ratePerPcs',
  );
  @override
  late final GeneratedColumn<double> ratePerPcs = GeneratedColumn<double>(
    'rate_per_pcs',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, division, ratePerPcs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employee_rates';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmployeeRate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('division')) {
      context.handle(
        _divisionMeta,
        division.isAcceptableOrUnknown(data['division']!, _divisionMeta),
      );
    } else if (isInserting) {
      context.missing(_divisionMeta);
    }
    if (data.containsKey('rate_per_pcs')) {
      context.handle(
        _ratePerPcsMeta,
        ratePerPcs.isAcceptableOrUnknown(
          data['rate_per_pcs']!,
          _ratePerPcsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ratePerPcsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmployeeRate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmployeeRate(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      division: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}division'],
      )!,
      ratePerPcs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rate_per_pcs'],
      )!,
    );
  }

  @override
  $EmployeeRatesTable createAlias(String alias) {
    return $EmployeeRatesTable(attachedDatabase, alias);
  }
}

class EmployeeRate extends DataClass implements Insertable<EmployeeRate> {
  final String id;
  final String userId;
  final String division;
  final double ratePerPcs;
  const EmployeeRate({
    required this.id,
    required this.userId,
    required this.division,
    required this.ratePerPcs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['division'] = Variable<String>(division);
    map['rate_per_pcs'] = Variable<double>(ratePerPcs);
    return map;
  }

  EmployeeRatesCompanion toCompanion(bool nullToAbsent) {
    return EmployeeRatesCompanion(
      id: Value(id),
      userId: Value(userId),
      division: Value(division),
      ratePerPcs: Value(ratePerPcs),
    );
  }

  factory EmployeeRate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmployeeRate(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      division: serializer.fromJson<String>(json['division']),
      ratePerPcs: serializer.fromJson<double>(json['ratePerPcs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'division': serializer.toJson<String>(division),
      'ratePerPcs': serializer.toJson<double>(ratePerPcs),
    };
  }

  EmployeeRate copyWith({
    String? id,
    String? userId,
    String? division,
    double? ratePerPcs,
  }) => EmployeeRate(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    division: division ?? this.division,
    ratePerPcs: ratePerPcs ?? this.ratePerPcs,
  );
  EmployeeRate copyWithCompanion(EmployeeRatesCompanion data) {
    return EmployeeRate(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      division: data.division.present ? data.division.value : this.division,
      ratePerPcs: data.ratePerPcs.present
          ? data.ratePerPcs.value
          : this.ratePerPcs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeRate(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('division: $division, ')
          ..write('ratePerPcs: $ratePerPcs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, division, ratePerPcs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmployeeRate &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.division == this.division &&
          other.ratePerPcs == this.ratePerPcs);
}

class EmployeeRatesCompanion extends UpdateCompanion<EmployeeRate> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> division;
  final Value<double> ratePerPcs;
  final Value<int> rowid;
  const EmployeeRatesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.division = const Value.absent(),
    this.ratePerPcs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmployeeRatesCompanion.insert({
    required String id,
    required String userId,
    required String division,
    required double ratePerPcs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       division = Value(division),
       ratePerPcs = Value(ratePerPcs);
  static Insertable<EmployeeRate> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? division,
    Expression<double>? ratePerPcs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (division != null) 'division': division,
      if (ratePerPcs != null) 'rate_per_pcs': ratePerPcs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmployeeRatesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? division,
    Value<double>? ratePerPcs,
    Value<int>? rowid,
  }) {
    return EmployeeRatesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      division: division ?? this.division,
      ratePerPcs: ratePerPcs ?? this.ratePerPcs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (division.present) {
      map['division'] = Variable<String>(division.value);
    }
    if (ratePerPcs.present) {
      map['rate_per_pcs'] = Variable<double>(ratePerPcs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeRatesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('division: $division, ')
          ..write('ratePerPcs: $ratePerPcs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    branchId,
    name,
    phone,
    address,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final String id;
  final String branchId;
  final String name;
  final String? phone;
  final String? address;
  final bool isActive;
  const Customer({
    required this.id,
    required this.branchId,
    required this.name,
    this.phone,
    this.address,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      branchId: Value(branchId),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      isActive: Value(isActive),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Customer copyWith({
    String? id,
    String? branchId,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    bool? isActive,
  }) => Customer(
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    isActive: isActive ?? this.isActive,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, branchId, name, phone, address, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.isActive == this.isActive);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<bool> isActive;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    required String id,
    required String branchId,
    required String name,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       name = Value(name);
  static Insertable<Customer> custom({
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith({
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? address,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BranchesTable branches = $BranchesTable(this);
  late final $BranchSettingsTable branchSettings = $BranchSettingsTable(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $AdminPermissionsTable adminPermissions = $AdminPermissionsTable(
    this,
  );
  late final $SizeGroupsTable sizeGroups = $SizeGroupsTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $VendorsTable vendors = $VendorsTable(this);
  late final $EmployeeRatesTable employeeRates = $EmployeeRatesTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final Index idxSizeGroupsBranch = Index(
    'idx_size_groups_branch',
    'CREATE INDEX idx_size_groups_branch ON size_groups (branch_id)',
  );
  late final Index idxProductsBranch = Index(
    'idx_products_branch',
    'CREATE INDEX idx_products_branch ON products (branch_id)',
  );
  late final Index idxVendorsBranch = Index(
    'idx_vendors_branch',
    'CREATE INDEX idx_vendors_branch ON vendors (branch_id)',
  );
  late final Index idxEmployeeRatesUser = Index(
    'idx_employee_rates_user',
    'CREATE INDEX idx_employee_rates_user ON employee_rates (user_id)',
  );
  late final Index idxCustomersBranch = Index(
    'idx_customers_branch',
    'CREATE INDEX idx_customers_branch ON customers (branch_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    branches,
    branchSettings,
    profiles,
    adminPermissions,
    sizeGroups,
    products,
    vendors,
    employeeRates,
    customers,
    idxSizeGroupsBranch,
    idxProductsBranch,
    idxVendorsBranch,
    idxEmployeeRatesUser,
    idxCustomersBranch,
  ];
}

typedef $$BranchesTableCreateCompanionBuilder =
    BranchesCompanion Function({
      required String id,
      required String name,
      Value<String?> address,
      Value<String?> phone,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$BranchesTableUpdateCompanionBuilder =
    BranchesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> address,
      Value<String?> phone,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$BranchesTableReferences
    extends BaseReferences<_$AppDatabase, $BranchesTable, Branche> {
  $$BranchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BranchSettingsTable, List<BranchSetting>>
  _branchSettingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.branchSettings,
    aliasName: 'branches__id__branch_settings__branch_id',
  );

  $$BranchSettingsTableProcessedTableManager get branchSettingsRefs {
    final manager = $$BranchSettingsTableTableManager(
      $_db,
      $_db.branchSettings,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_branchSettingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProfilesTable, List<Profile>> _profilesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.profiles,
    aliasName: 'branches__id__profiles__branch_id',
  );

  $$ProfilesTableProcessedTableManager get profilesRefs {
    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_profilesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SizeGroupsTable, List<SizeGroup>>
  _sizeGroupsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sizeGroups,
    aliasName: 'branches__id__size_groups__branch_id',
  );

  $$SizeGroupsTableProcessedTableManager get sizeGroupsRefs {
    final manager = $$SizeGroupsTableTableManager(
      $_db,
      $_db.sizeGroups,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sizeGroupsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProductsTable, List<Product>> _productsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: 'branches__id__products__branch_id',
  );

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VendorsTable, List<Vendor>> _vendorsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.vendors,
    aliasName: 'branches__id__vendors__branch_id',
  );

  $$VendorsTableProcessedTableManager get vendorsRefs {
    final manager = $$VendorsTableTableManager(
      $_db,
      $_db.vendors,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_vendorsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CustomersTable, List<Customer>>
  _customersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.customers,
    aliasName: 'branches__id__customers__branch_id',
  );

  $$CustomersTableProcessedTableManager get customersRefs {
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_customersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BranchesTableFilterComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> branchSettingsRefs(
    Expression<bool> Function($$BranchSettingsTableFilterComposer f) f,
  ) {
    final $$BranchSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.branchSettings,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchSettingsTableFilterComposer(
            $db: $db,
            $table: $db.branchSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> profilesRefs(
    Expression<bool> Function($$ProfilesTableFilterComposer f) f,
  ) {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sizeGroupsRefs(
    Expression<bool> Function($$SizeGroupsTableFilterComposer f) f,
  ) {
    final $$SizeGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sizeGroups,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizeGroupsTableFilterComposer(
            $db: $db,
            $table: $db.sizeGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> productsRefs(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vendorsRefs(
    Expression<bool> Function($$VendorsTableFilterComposer f) f,
  ) {
    final $$VendorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vendors,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VendorsTableFilterComposer(
            $db: $db,
            $table: $db.vendors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customersRefs(
    Expression<bool> Function($$CustomersTableFilterComposer f) f,
  ) {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BranchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BranchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> branchSettingsRefs<T extends Object>(
    Expression<T> Function($$BranchSettingsTableAnnotationComposer a) f,
  ) {
    final $$BranchSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.branchSettings,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.branchSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> profilesRefs<T extends Object>(
    Expression<T> Function($$ProfilesTableAnnotationComposer a) f,
  ) {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sizeGroupsRefs<T extends Object>(
    Expression<T> Function($$SizeGroupsTableAnnotationComposer a) f,
  ) {
    final $$SizeGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sizeGroups,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizeGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.sizeGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> productsRefs<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vendorsRefs<T extends Object>(
    Expression<T> Function($$VendorsTableAnnotationComposer a) f,
  ) {
    final $$VendorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vendors,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VendorsTableAnnotationComposer(
            $db: $db,
            $table: $db.vendors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customersRefs<T extends Object>(
    Expression<T> Function($$CustomersTableAnnotationComposer a) f,
  ) {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BranchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BranchesTable,
          Branche,
          $$BranchesTableFilterComposer,
          $$BranchesTableOrderingComposer,
          $$BranchesTableAnnotationComposer,
          $$BranchesTableCreateCompanionBuilder,
          $$BranchesTableUpdateCompanionBuilder,
          (Branche, $$BranchesTableReferences),
          Branche,
          PrefetchHooks Function({
            bool branchSettingsRefs,
            bool profilesRefs,
            bool sizeGroupsRefs,
            bool productsRefs,
            bool vendorsRefs,
            bool customersRefs,
          })
        > {
  $$BranchesTableTableManager(_$AppDatabase db, $BranchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BranchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BranchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BranchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchesCompanion(
                id: id,
                name: name,
                address: address,
                phone: phone,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchesCompanion.insert(
                id: id,
                name: name,
                address: address,
                phone: phone,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BranchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                branchSettingsRefs = false,
                profilesRefs = false,
                sizeGroupsRefs = false,
                productsRefs = false,
                vendorsRefs = false,
                customersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (branchSettingsRefs) db.branchSettings,
                    if (profilesRefs) db.profiles,
                    if (sizeGroupsRefs) db.sizeGroups,
                    if (productsRefs) db.products,
                    if (vendorsRefs) db.vendors,
                    if (customersRefs) db.customers,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (branchSettingsRefs)
                        await $_getPrefetchedData<
                          Branche,
                          $BranchesTable,
                          BranchSetting
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._branchSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).branchSettingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (profilesRefs)
                        await $_getPrefetchedData<
                          Branche,
                          $BranchesTable,
                          Profile
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._profilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).profilesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sizeGroupsRefs)
                        await $_getPrefetchedData<
                          Branche,
                          $BranchesTable,
                          SizeGroup
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._sizeGroupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).sizeGroupsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (productsRefs)
                        await $_getPrefetchedData<
                          Branche,
                          $BranchesTable,
                          Product
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._productsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).productsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vendorsRefs)
                        await $_getPrefetchedData<
                          Branche,
                          $BranchesTable,
                          Vendor
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._vendorsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).vendorsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (customersRefs)
                        await $_getPrefetchedData<
                          Branche,
                          $BranchesTable,
                          Customer
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._customersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).customersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BranchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BranchesTable,
      Branche,
      $$BranchesTableFilterComposer,
      $$BranchesTableOrderingComposer,
      $$BranchesTableAnnotationComposer,
      $$BranchesTableCreateCompanionBuilder,
      $$BranchesTableUpdateCompanionBuilder,
      (Branche, $$BranchesTableReferences),
      Branche,
      PrefetchHooks Function({
        bool branchSettingsRefs,
        bool profilesRefs,
        bool sizeGroupsRefs,
        bool productsRefs,
        bool vendorsRefs,
        bool customersRefs,
      })
    >;
typedef $$BranchSettingsTableCreateCompanionBuilder =
    BranchSettingsCompanion Function({
      required String branchId,
      Value<String?> paymentSystem,
      Value<double?> maxKasbonPercentage,
      Value<int> rowid,
    });
typedef $$BranchSettingsTableUpdateCompanionBuilder =
    BranchSettingsCompanion Function({
      Value<String> branchId,
      Value<String?> paymentSystem,
      Value<double?> maxKasbonPercentage,
      Value<int> rowid,
    });

final class $$BranchSettingsTableReferences
    extends BaseReferences<_$AppDatabase, $BranchSettingsTable, BranchSetting> {
  $$BranchSettingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('branch_settings__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BranchSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $BranchSettingsTable> {
  $$BranchSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get paymentSystem => $composableBuilder(
    column: $table.paymentSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxKasbonPercentage => $composableBuilder(
    column: $table.maxKasbonPercentage,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BranchSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $BranchSettingsTable> {
  $$BranchSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get paymentSystem => $composableBuilder(
    column: $table.paymentSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxKasbonPercentage => $composableBuilder(
    column: $table.maxKasbonPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BranchSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BranchSettingsTable> {
  $$BranchSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get paymentSystem => $composableBuilder(
    column: $table.paymentSystem,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxKasbonPercentage => $composableBuilder(
    column: $table.maxKasbonPercentage,
    builder: (column) => column,
  );

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BranchSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BranchSettingsTable,
          BranchSetting,
          $$BranchSettingsTableFilterComposer,
          $$BranchSettingsTableOrderingComposer,
          $$BranchSettingsTableAnnotationComposer,
          $$BranchSettingsTableCreateCompanionBuilder,
          $$BranchSettingsTableUpdateCompanionBuilder,
          (BranchSetting, $$BranchSettingsTableReferences),
          BranchSetting,
          PrefetchHooks Function({bool branchId})
        > {
  $$BranchSettingsTableTableManager(
    _$AppDatabase db,
    $BranchSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BranchSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BranchSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BranchSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> branchId = const Value.absent(),
                Value<String?> paymentSystem = const Value.absent(),
                Value<double?> maxKasbonPercentage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchSettingsCompanion(
                branchId: branchId,
                paymentSystem: paymentSystem,
                maxKasbonPercentage: maxKasbonPercentage,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String branchId,
                Value<String?> paymentSystem = const Value.absent(),
                Value<double?> maxKasbonPercentage = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchSettingsCompanion.insert(
                branchId: branchId,
                paymentSystem: paymentSystem,
                maxKasbonPercentage: maxKasbonPercentage,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BranchSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$BranchSettingsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn:
                                    $$BranchSettingsTableReferences
                                        ._branchIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BranchSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BranchSettingsTable,
      BranchSetting,
      $$BranchSettingsTableFilterComposer,
      $$BranchSettingsTableOrderingComposer,
      $$BranchSettingsTableAnnotationComposer,
      $$BranchSettingsTableCreateCompanionBuilder,
      $$BranchSettingsTableUpdateCompanionBuilder,
      (BranchSetting, $$BranchSettingsTableReferences),
      BranchSetting,
      PrefetchHooks Function({bool branchId})
    >;
typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      required String id,
      required String branchId,
      required String role,
      required String name,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<String> id,
      Value<String> branchId,
      Value<String> role,
      Value<String> name,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$ProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $ProfilesTable, Profile> {
  $$ProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('profiles__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AdminPermissionsTable, List<AdminPermission>>
  _adminPermissionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.adminPermissions,
    aliasName: 'profiles__id__admin_permissions__user_id',
  );

  $$AdminPermissionsTableProcessedTableManager get adminPermissionsRefs {
    final manager = $$AdminPermissionsTableTableManager(
      $_db,
      $_db.adminPermissions,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _adminPermissionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EmployeeRatesTable, List<EmployeeRate>>
  _employeeRatesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.employeeRates,
    aliasName: 'profiles__id__employee_rates__user_id',
  );

  $$EmployeeRatesTableProcessedTableManager get employeeRatesRefs {
    final manager = $$EmployeeRatesTableTableManager(
      $_db,
      $_db.employeeRates,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_employeeRatesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> adminPermissionsRefs(
    Expression<bool> Function($$AdminPermissionsTableFilterComposer f) f,
  ) {
    final $$AdminPermissionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.adminPermissions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AdminPermissionsTableFilterComposer(
            $db: $db,
            $table: $db.adminPermissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> employeeRatesRefs(
    Expression<bool> Function($$EmployeeRatesTableFilterComposer f) f,
  ) {
    final $$EmployeeRatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.employeeRates,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeeRatesTableFilterComposer(
            $db: $db,
            $table: $db.employeeRates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> adminPermissionsRefs<T extends Object>(
    Expression<T> Function($$AdminPermissionsTableAnnotationComposer a) f,
  ) {
    final $$AdminPermissionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.adminPermissions,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AdminPermissionsTableAnnotationComposer(
            $db: $db,
            $table: $db.adminPermissions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> employeeRatesRefs<T extends Object>(
    Expression<T> Function($$EmployeeRatesTableAnnotationComposer a) f,
  ) {
    final $$EmployeeRatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.employeeRates,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeeRatesTableAnnotationComposer(
            $db: $db,
            $table: $db.employeeRates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          Profile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (Profile, $$ProfilesTableReferences),
          Profile,
          PrefetchHooks Function({
            bool branchId,
            bool adminPermissionsRefs,
            bool employeeRatesRefs,
          })
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                branchId: branchId,
                role: role,
                name: name,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String branchId,
                required String role,
                required String name,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                branchId: branchId,
                role: role,
                name: name,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                branchId = false,
                adminPermissionsRefs = false,
                employeeRatesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (adminPermissionsRefs) db.adminPermissions,
                    if (employeeRatesRefs) db.employeeRates,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (branchId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.branchId,
                                    referencedTable: $$ProfilesTableReferences
                                        ._branchIdTable(db),
                                    referencedColumn: $$ProfilesTableReferences
                                        ._branchIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (adminPermissionsRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          AdminPermission
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._adminPermissionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).adminPermissionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (employeeRatesRefs)
                        await $_getPrefetchedData<
                          Profile,
                          $ProfilesTable,
                          EmployeeRate
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._employeeRatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).employeeRatesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      Profile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (Profile, $$ProfilesTableReferences),
      Profile,
      PrefetchHooks Function({
        bool branchId,
        bool adminPermissionsRefs,
        bool employeeRatesRefs,
      })
    >;
typedef $$AdminPermissionsTableCreateCompanionBuilder =
    AdminPermissionsCompanion Function({
      required String userId,
      Value<bool> canManageOrders,
      Value<bool> canManageProduction,
      Value<bool> canViewReports,
      Value<int> rowid,
    });
typedef $$AdminPermissionsTableUpdateCompanionBuilder =
    AdminPermissionsCompanion Function({
      Value<String> userId,
      Value<bool> canManageOrders,
      Value<bool> canManageProduction,
      Value<bool> canViewReports,
      Value<int> rowid,
    });

final class $$AdminPermissionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $AdminPermissionsTable, AdminPermission> {
  $$AdminPermissionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _userIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('admin_permissions__user_id__profiles__id');

  $$ProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AdminPermissionsTableFilterComposer
    extends Composer<_$AppDatabase, $AdminPermissionsTable> {
  $$AdminPermissionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get canManageOrders => $composableBuilder(
    column: $table.canManageOrders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canManageProduction => $composableBuilder(
    column: $table.canManageProduction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canViewReports => $composableBuilder(
    column: $table.canViewReports,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get userId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AdminPermissionsTableOrderingComposer
    extends Composer<_$AppDatabase, $AdminPermissionsTable> {
  $$AdminPermissionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get canManageOrders => $composableBuilder(
    column: $table.canManageOrders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canManageProduction => $composableBuilder(
    column: $table.canManageProduction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canViewReports => $composableBuilder(
    column: $table.canViewReports,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get userId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AdminPermissionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AdminPermissionsTable> {
  $$AdminPermissionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get canManageOrders => $composableBuilder(
    column: $table.canManageOrders,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get canManageProduction => $composableBuilder(
    column: $table.canManageProduction,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get canViewReports => $composableBuilder(
    column: $table.canViewReports,
    builder: (column) => column,
  );

  $$ProfilesTableAnnotationComposer get userId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AdminPermissionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AdminPermissionsTable,
          AdminPermission,
          $$AdminPermissionsTableFilterComposer,
          $$AdminPermissionsTableOrderingComposer,
          $$AdminPermissionsTableAnnotationComposer,
          $$AdminPermissionsTableCreateCompanionBuilder,
          $$AdminPermissionsTableUpdateCompanionBuilder,
          (AdminPermission, $$AdminPermissionsTableReferences),
          AdminPermission,
          PrefetchHooks Function({bool userId})
        > {
  $$AdminPermissionsTableTableManager(
    _$AppDatabase db,
    $AdminPermissionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AdminPermissionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AdminPermissionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AdminPermissionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<bool> canManageOrders = const Value.absent(),
                Value<bool> canManageProduction = const Value.absent(),
                Value<bool> canViewReports = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AdminPermissionsCompanion(
                userId: userId,
                canManageOrders: canManageOrders,
                canManageProduction: canManageProduction,
                canViewReports: canViewReports,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<bool> canManageOrders = const Value.absent(),
                Value<bool> canManageProduction = const Value.absent(),
                Value<bool> canViewReports = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AdminPermissionsCompanion.insert(
                userId: userId,
                canManageOrders: canManageOrders,
                canManageProduction: canManageProduction,
                canViewReports: canViewReports,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AdminPermissionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable:
                                    $$AdminPermissionsTableReferences
                                        ._userIdTable(db),
                                referencedColumn:
                                    $$AdminPermissionsTableReferences
                                        ._userIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AdminPermissionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AdminPermissionsTable,
      AdminPermission,
      $$AdminPermissionsTableFilterComposer,
      $$AdminPermissionsTableOrderingComposer,
      $$AdminPermissionsTableAnnotationComposer,
      $$AdminPermissionsTableCreateCompanionBuilder,
      $$AdminPermissionsTableUpdateCompanionBuilder,
      (AdminPermission, $$AdminPermissionsTableReferences),
      AdminPermission,
      PrefetchHooks Function({bool userId})
    >;
typedef $$SizeGroupsTableCreateCompanionBuilder =
    SizeGroupsCompanion Function({
      required String id,
      required String branchId,
      required String name,
      required String sizes,
      Value<int> rowid,
    });
typedef $$SizeGroupsTableUpdateCompanionBuilder =
    SizeGroupsCompanion Function({
      Value<String> id,
      Value<String> branchId,
      Value<String> name,
      Value<String> sizes,
      Value<int> rowid,
    });

final class $$SizeGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $SizeGroupsTable, SizeGroup> {
  $$SizeGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('size_groups__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ProductsTable, List<Product>> _productsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: 'size_groups__id__products__size_group_id',
  );

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.sizeGroupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SizeGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $SizeGroupsTable> {
  $$SizeGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sizes => $composableBuilder(
    column: $table.sizes,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> productsRefs(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.sizeGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SizeGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $SizeGroupsTable> {
  $$SizeGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sizes => $composableBuilder(
    column: $table.sizes,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SizeGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SizeGroupsTable> {
  $$SizeGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sizes =>
      $composableBuilder(column: $table.sizes, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> productsRefs<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.sizeGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SizeGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SizeGroupsTable,
          SizeGroup,
          $$SizeGroupsTableFilterComposer,
          $$SizeGroupsTableOrderingComposer,
          $$SizeGroupsTableAnnotationComposer,
          $$SizeGroupsTableCreateCompanionBuilder,
          $$SizeGroupsTableUpdateCompanionBuilder,
          (SizeGroup, $$SizeGroupsTableReferences),
          SizeGroup,
          PrefetchHooks Function({bool branchId, bool productsRefs})
        > {
  $$SizeGroupsTableTableManager(_$AppDatabase db, $SizeGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SizeGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SizeGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SizeGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> sizes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SizeGroupsCompanion(
                id: id,
                branchId: branchId,
                name: name,
                sizes: sizes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String branchId,
                required String name,
                required String sizes,
                Value<int> rowid = const Value.absent(),
              }) => SizeGroupsCompanion.insert(
                id: id,
                branchId: branchId,
                name: name,
                sizes: sizes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SizeGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false, productsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productsRefs) db.products],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$SizeGroupsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$SizeGroupsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productsRefs)
                    await $_getPrefetchedData<
                      SizeGroup,
                      $SizeGroupsTable,
                      Product
                    >(
                      currentTable: table,
                      referencedTable: $$SizeGroupsTableReferences
                          ._productsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SizeGroupsTableReferences(
                            db,
                            table,
                            p0,
                          ).productsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.sizeGroupId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SizeGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SizeGroupsTable,
      SizeGroup,
      $$SizeGroupsTableFilterComposer,
      $$SizeGroupsTableOrderingComposer,
      $$SizeGroupsTableAnnotationComposer,
      $$SizeGroupsTableCreateCompanionBuilder,
      $$SizeGroupsTableUpdateCompanionBuilder,
      (SizeGroup, $$SizeGroupsTableReferences),
      SizeGroup,
      PrefetchHooks Function({bool branchId, bool productsRefs})
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      required String id,
      required String branchId,
      required String name,
      required String category,
      required String sizeGroupId,
      required double priceMin,
      required double priceMax,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<String> branchId,
      Value<String> name,
      Value<String> category,
      Value<String> sizeGroupId,
      Value<double> priceMin,
      Value<double> priceMax,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('products__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SizeGroupsTable _sizeGroupIdTable(_$AppDatabase db) =>
      db.sizeGroups.createAlias('products__size_group_id__size_groups__id');

  $$SizeGroupsTableProcessedTableManager get sizeGroupId {
    final $_column = $_itemColumn<String>('size_group_id')!;

    final manager = $$SizeGroupsTableTableManager(
      $_db,
      $_db.sizeGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sizeGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceMin => $composableBuilder(
    column: $table.priceMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get priceMax => $composableBuilder(
    column: $table.priceMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SizeGroupsTableFilterComposer get sizeGroupId {
    final $$SizeGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sizeGroupId,
      referencedTable: $db.sizeGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizeGroupsTableFilterComposer(
            $db: $db,
            $table: $db.sizeGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceMin => $composableBuilder(
    column: $table.priceMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get priceMax => $composableBuilder(
    column: $table.priceMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SizeGroupsTableOrderingComposer get sizeGroupId {
    final $$SizeGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sizeGroupId,
      referencedTable: $db.sizeGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizeGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.sizeGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get priceMin =>
      $composableBuilder(column: $table.priceMin, builder: (column) => column);

  GeneratedColumn<double> get priceMax =>
      $composableBuilder(column: $table.priceMax, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SizeGroupsTableAnnotationComposer get sizeGroupId {
    final $$SizeGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sizeGroupId,
      referencedTable: $db.sizeGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SizeGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.sizeGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({bool branchId, bool sizeGroupId})
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> sizeGroupId = const Value.absent(),
                Value<double> priceMin = const Value.absent(),
                Value<double> priceMax = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                branchId: branchId,
                name: name,
                category: category,
                sizeGroupId: sizeGroupId,
                priceMin: priceMin,
                priceMax: priceMax,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String branchId,
                required String name,
                required String category,
                required String sizeGroupId,
                required double priceMin,
                required double priceMax,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                branchId: branchId,
                name: name,
                category: category,
                sizeGroupId: sizeGroupId,
                priceMin: priceMin,
                priceMax: priceMax,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false, sizeGroupId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$ProductsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$ProductsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (sizeGroupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sizeGroupId,
                                referencedTable: $$ProductsTableReferences
                                    ._sizeGroupIdTable(db),
                                referencedColumn: $$ProductsTableReferences
                                    ._sizeGroupIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({bool branchId, bool sizeGroupId})
    >;
typedef $$VendorsTableCreateCompanionBuilder =
    VendorsCompanion Function({
      required String id,
      required String branchId,
      required String name,
      Value<String?> division,
      Value<String?> phone,
      Value<String?> notes,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$VendorsTableUpdateCompanionBuilder =
    VendorsCompanion Function({
      Value<String> id,
      Value<String> branchId,
      Value<String> name,
      Value<String?> division,
      Value<String?> phone,
      Value<String?> notes,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$VendorsTableReferences
    extends BaseReferences<_$AppDatabase, $VendorsTable, Vendor> {
  $$VendorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('vendors__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VendorsTableFilterComposer
    extends Composer<_$AppDatabase, $VendorsTable> {
  $$VendorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get division => $composableBuilder(
    column: $table.division,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VendorsTableOrderingComposer
    extends Composer<_$AppDatabase, $VendorsTable> {
  $$VendorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get division => $composableBuilder(
    column: $table.division,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VendorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VendorsTable> {
  $$VendorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get division =>
      $composableBuilder(column: $table.division, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VendorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VendorsTable,
          Vendor,
          $$VendorsTableFilterComposer,
          $$VendorsTableOrderingComposer,
          $$VendorsTableAnnotationComposer,
          $$VendorsTableCreateCompanionBuilder,
          $$VendorsTableUpdateCompanionBuilder,
          (Vendor, $$VendorsTableReferences),
          Vendor,
          PrefetchHooks Function({bool branchId})
        > {
  $$VendorsTableTableManager(_$AppDatabase db, $VendorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VendorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VendorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VendorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> division = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VendorsCompanion(
                id: id,
                branchId: branchId,
                name: name,
                division: division,
                phone: phone,
                notes: notes,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String branchId,
                required String name,
                Value<String?> division = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VendorsCompanion.insert(
                id: id,
                branchId: branchId,
                name: name,
                division: division,
                phone: phone,
                notes: notes,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VendorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$VendorsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$VendorsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VendorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VendorsTable,
      Vendor,
      $$VendorsTableFilterComposer,
      $$VendorsTableOrderingComposer,
      $$VendorsTableAnnotationComposer,
      $$VendorsTableCreateCompanionBuilder,
      $$VendorsTableUpdateCompanionBuilder,
      (Vendor, $$VendorsTableReferences),
      Vendor,
      PrefetchHooks Function({bool branchId})
    >;
typedef $$EmployeeRatesTableCreateCompanionBuilder =
    EmployeeRatesCompanion Function({
      required String id,
      required String userId,
      required String division,
      required double ratePerPcs,
      Value<int> rowid,
    });
typedef $$EmployeeRatesTableUpdateCompanionBuilder =
    EmployeeRatesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> division,
      Value<double> ratePerPcs,
      Value<int> rowid,
    });

final class $$EmployeeRatesTableReferences
    extends BaseReferences<_$AppDatabase, $EmployeeRatesTable, EmployeeRate> {
  $$EmployeeRatesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _userIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('employee_rates__user_id__profiles__id');

  $$ProfilesTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EmployeeRatesTableFilterComposer
    extends Composer<_$AppDatabase, $EmployeeRatesTable> {
  $$EmployeeRatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get division => $composableBuilder(
    column: $table.division,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ratePerPcs => $composableBuilder(
    column: $table.ratePerPcs,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get userId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmployeeRatesTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployeeRatesTable> {
  $$EmployeeRatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get division => $composableBuilder(
    column: $table.division,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ratePerPcs => $composableBuilder(
    column: $table.ratePerPcs,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get userId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmployeeRatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployeeRatesTable> {
  $$EmployeeRatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get division =>
      $composableBuilder(column: $table.division, builder: (column) => column);

  GeneratedColumn<double> get ratePerPcs => $composableBuilder(
    column: $table.ratePerPcs,
    builder: (column) => column,
  );

  $$ProfilesTableAnnotationComposer get userId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EmployeeRatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmployeeRatesTable,
          EmployeeRate,
          $$EmployeeRatesTableFilterComposer,
          $$EmployeeRatesTableOrderingComposer,
          $$EmployeeRatesTableAnnotationComposer,
          $$EmployeeRatesTableCreateCompanionBuilder,
          $$EmployeeRatesTableUpdateCompanionBuilder,
          (EmployeeRate, $$EmployeeRatesTableReferences),
          EmployeeRate,
          PrefetchHooks Function({bool userId})
        > {
  $$EmployeeRatesTableTableManager(_$AppDatabase db, $EmployeeRatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeeRatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeeRatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeeRatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> division = const Value.absent(),
                Value<double> ratePerPcs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmployeeRatesCompanion(
                id: id,
                userId: userId,
                division: division,
                ratePerPcs: ratePerPcs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String division,
                required double ratePerPcs,
                Value<int> rowid = const Value.absent(),
              }) => EmployeeRatesCompanion.insert(
                id: id,
                userId: userId,
                division: division,
                ratePerPcs: ratePerPcs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EmployeeRatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userId,
                                referencedTable: $$EmployeeRatesTableReferences
                                    ._userIdTable(db),
                                referencedColumn: $$EmployeeRatesTableReferences
                                    ._userIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EmployeeRatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmployeeRatesTable,
      EmployeeRate,
      $$EmployeeRatesTableFilterComposer,
      $$EmployeeRatesTableOrderingComposer,
      $$EmployeeRatesTableAnnotationComposer,
      $$EmployeeRatesTableCreateCompanionBuilder,
      $$EmployeeRatesTableUpdateCompanionBuilder,
      (EmployeeRate, $$EmployeeRatesTableReferences),
      EmployeeRate,
      PrefetchHooks Function({bool userId})
    >;
typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      required String id,
      required String branchId,
      required String name,
      Value<String?> phone,
      Value<String?> address,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<String> id,
      Value<String> branchId,
      Value<String> name,
      Value<String?> phone,
      Value<String?> address,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('customers__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({bool branchId})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                branchId: branchId,
                name: name,
                phone: phone,
                address: address,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String branchId,
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                branchId: branchId,
                name: name,
                phone: phone,
                address: address,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$CustomersTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$CustomersTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({bool branchId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BranchesTableTableManager get branches =>
      $$BranchesTableTableManager(_db, _db.branches);
  $$BranchSettingsTableTableManager get branchSettings =>
      $$BranchSettingsTableTableManager(_db, _db.branchSettings);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$AdminPermissionsTableTableManager get adminPermissions =>
      $$AdminPermissionsTableTableManager(_db, _db.adminPermissions);
  $$SizeGroupsTableTableManager get sizeGroups =>
      $$SizeGroupsTableTableManager(_db, _db.sizeGroups);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$VendorsTableTableManager get vendors =>
      $$VendorsTableTableManager(_db, _db.vendors);
  $$EmployeeRatesTableTableManager get employeeRates =>
      $$EmployeeRatesTableTableManager(_db, _db.employeeRates);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
}
