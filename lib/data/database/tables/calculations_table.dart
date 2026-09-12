import 'package:drift/drift.dart';

@DataClassName('CalculationEntity')
class Calculations extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer().nullable()();
  TextColumn get dataJson => text()();
  IntColumn get schemaVersion => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}
