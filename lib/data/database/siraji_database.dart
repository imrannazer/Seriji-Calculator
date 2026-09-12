import 'package:drift/drift.dart';
import 'connection/connection.dart' as impl;
import 'tables/calculations_table.dart';
import 'tables/wills_table.dart';
import 'daos/calculations_dao.dart';
import 'daos/wills_dao.dart';

part 'siraji_database.g.dart';

@DriftDatabase(tables: [Calculations, Wills], daos: [CalculationsDao, WillsDao])
class SirajiDatabase extends _$SirajiDatabase {
  SirajiDatabase([QueryExecutor? executor])
      : super(executor ?? impl.openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
      );
}
