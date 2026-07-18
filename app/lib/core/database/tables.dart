import 'package:drift/drift.dart';

// --- TENANT & AUTH ---
class Branches extends Table {
  TextColumn get id => text()(); // UUID string
  TextColumn get name => text()();
  TextColumn get address => text().nullable()();
  TextColumn get phone => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  @override
  Set<Column> get primaryKey => {id};
}

class BranchSettings extends Table {
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get paymentSystem => text().nullable()();
  RealColumn get maxKasbonPercentage => real().nullable()();
  
  @override
  Set<Column> get primaryKey => {branchId};
}

class Profiles extends Table {
  TextColumn get id => text()(); // auth.users.id
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get role => text()();
  TextColumn get name => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  @override
  Set<Column> get primaryKey => {id};
}

class AdminPermissions extends Table {
  TextColumn get userId => text().references(Profiles, #id)();
  BoolColumn get canManageOrders => boolean().withDefault(const Constant(false))();
  BoolColumn get canManageProduction => boolean().withDefault(const Constant(false))();
  BoolColumn get canViewReports => boolean().withDefault(const Constant(false))();
  
  @override
  Set<Column> get primaryKey => {userId};
}

// --- MASTER DATA ---
@TableIndex(name: 'idx_size_groups_branch', columns: {#branchId})
class SizeGroups extends Table {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get name => text()();
  TextColumn get sizes => text()(); // Disimpan sebagai JSON string
  
  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_products_branch', columns: {#branchId})
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get name => text()();
  TextColumn get category => text()(); // setelan / non-setelan
  TextColumn get sizeGroupId => text().references(SizeGroups, #id)();
  RealColumn get priceMin => real()();
  RealColumn get priceMax => real()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_vendors_branch', columns: {#branchId})
class Vendors extends Table {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get name => text()();
  TextColumn get division => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_employee_rates_user', columns: {#userId})
class EmployeeRates extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().references(Profiles, #id)();
  TextColumn get division => text()();
  RealColumn get ratePerPcs => real()();
  
  @override
  Set<Column> get primaryKey => {id};
}

@TableIndex(name: 'idx_customers_branch', columns: {#branchId})
class Customers extends Table {
  TextColumn get id => text()();
  TextColumn get branchId => text().references(Branches, #id)();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  @override
  Set<Column> get primaryKey => {id};
}
