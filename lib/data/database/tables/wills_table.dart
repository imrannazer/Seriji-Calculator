import 'package:drift/drift.dart';

@DataClassName('WillEntity')
class Wills extends Table {
  TextColumn get id => text()();
  TextColumn get testatorName => text()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer().nullable()();
  TextColumn get status => text()();
  TextColumn get bequestNotes => text().nullable()();
  TextColumn get dataJson => text().nullable()();
  IntColumn get schemaVersion => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}
