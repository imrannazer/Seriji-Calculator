import 'package:drift/drift.dart';
import '../siraji_database.dart';
import '../tables/wills_table.dart';

part 'wills_dao.g.dart';

@DriftAccessor(tables: [Wills])
class WillsDao extends DatabaseAccessor<SirajiDatabase>
    with _$WillsDaoMixin {
  WillsDao(super.db);

  Future<List<WillEntity>> getAllWills() => select(wills).get();

  Stream<List<WillEntity>> watchAllWills() => select(wills).watch();

  Future<WillEntity?> getWillById(String id) =>
      (select(wills)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> insertWill(WillsCompanion entry) =>
      into(wills).insertOnConflictUpdate(entry);

  Future<void> deleteWill(String id) =>
      (delete(wills)..where((t) => t.id.equals(id))).go();

  Future<void> deleteAllWills() => delete(wills).go();
}
