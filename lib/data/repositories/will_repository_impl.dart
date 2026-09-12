import 'package:drift/drift.dart';
import '../../domain/models/will.dart' as domain;
import '../../domain/repositories/will_repository.dart';
import '../../core/result/result.dart';
import '../database/siraji_database.dart';
import '../database/daos/wills_dao.dart';

class WillRepositoryImpl implements WillRepository {
  const WillRepositoryImpl(this._dao);

  final WillsDao _dao;

  @override
  Future<Result<List<domain.Will>>> getAllWills() async {
    try {
      final rows = await _dao.getAllWills();
      final list = <domain.Will>[];
      for (final r in rows) {
        list.add(domain.Will(
          id: r.id,
          testatorName: r.testatorName,
          createdAt: DateTime.fromMillisecondsSinceEpoch(r.createdAt),
          updatedAt: r.updatedAt != null
              ? DateTime.fromMillisecondsSinceEpoch(r.updatedAt!)
              : null,
          status: domain.WillStatus.values.firstWhere(
            (s) => s.name == r.status,
            orElse: () => domain.WillStatus.draft,
          ),
          bequestNotes: r.bequestNotes,
          dataJson: r.dataJson,
          schemaVersion: r.schemaVersion,
        ));
      }
      return Success(list);
    } catch (e) {
      return Failure('Failed to get wills: $e');
    }
  }

  @override
  Future<Result<domain.Will?>> getWillById(String id) async {
    try {
      final row = await _dao.getWillById(id);
      if (row == null) return const Success(null);
      return Success(domain.Will(
        id: row.id,
        testatorName: row.testatorName,
        createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
        updatedAt: row.updatedAt != null
            ? DateTime.fromMillisecondsSinceEpoch(row.updatedAt!)
            : null,
        status: domain.WillStatus.values.firstWhere(
          (s) => s.name == row.status,
          orElse: () => domain.WillStatus.draft,
        ),
        bequestNotes: row.bequestNotes,
        dataJson: row.dataJson,
        schemaVersion: row.schemaVersion,
      ));
    } catch (e) {
      return Failure('Failed to get will $id: $e');
    }
  }

  @override
  Future<Result<void>> saveWill(domain.Will will) async {
    try {
      await _dao.insertWill(WillsCompanion(
        id: Value(will.id),
        testatorName: Value(will.testatorName),
        createdAt: Value(will.createdAt.millisecondsSinceEpoch),
        updatedAt: Value(will.updatedAt?.millisecondsSinceEpoch),
        status: Value(will.status.name),
        bequestNotes: Value(will.bequestNotes),
        dataJson: Value(will.dataJson),
        schemaVersion: Value(will.schemaVersion),
      ));
      return const Success(null);
    } catch (e) {
      return Failure('Failed to save will: $e');
    }
  }

  @override
  Future<Result<void>> deleteWill(String id) async {
    try {
      await _dao.deleteWill(id);
      return const Success(null);
    } catch (e) {
      return Failure('Failed to delete will: $e');
    }
  }

  @override
  Future<Result<void>> deleteAllWills() async {
    try {
      await _dao.deleteAllWills();
      return const Success(null);
    } catch (e) {
      return Failure('Failed to delete all wills: $e');
    }
  }
}
