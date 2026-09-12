import 'package:drift/drift.dart';
import '../../domain/models/calculation.dart' as domain;
import '../../domain/repositories/calculation_repository.dart';
import '../../core/result/result.dart';
import '../database/siraji_database.dart';
import '../database/daos/calculations_dao.dart';

class CalculationRepositoryImpl implements CalculationRepository {
  const CalculationRepositoryImpl(this._dao);

  final CalculationsDao _dao;

  @override
  Future<Result<List<domain.Calculation>>> getAllCalculations() async {
    try {
      final rows = await _dao.getAllCalculations();
      final list = <domain.Calculation>[];
      for (final r in rows) {
        list.add(domain.Calculation(
          id: r.id,
          title: r.title,
          createdAt: DateTime.fromMillisecondsSinceEpoch(r.createdAt),
          updatedAt: r.updatedAt != null
              ? DateTime.fromMillisecondsSinceEpoch(r.updatedAt!)
              : null,
          dataJson: r.dataJson,
          schemaVersion: r.schemaVersion,
        ));
      }
      return Success(list);
    } catch (e) {
      return Failure('Failed to get calculations: $e');
    }
  }

  @override
  Future<Result<domain.Calculation?>> getCalculationById(String id) async {
    try {
      final row = await _dao.getCalculationById(id);
      if (row == null) return const Success(null);
      return Success(domain.Calculation(
        id: row.id,
        title: row.title,
        createdAt: DateTime.fromMillisecondsSinceEpoch(row.createdAt),
        updatedAt: row.updatedAt != null
            ? DateTime.fromMillisecondsSinceEpoch(row.updatedAt!)
            : null,
        dataJson: row.dataJson,
        schemaVersion: row.schemaVersion,
      ));
    } catch (e) {
      return Failure('Failed to get calculation $id: $e');
    }
  }

  @override
  Future<Result<void>> saveCalculation(domain.Calculation calculation) async {
    try {
      await _dao.insertCalculation(CalculationsCompanion(
        id: Value(calculation.id),
        title: Value(calculation.title),
        createdAt: Value(calculation.createdAt.millisecondsSinceEpoch),
        updatedAt: Value(calculation.updatedAt?.millisecondsSinceEpoch),
        dataJson: Value(calculation.dataJson),
        schemaVersion: Value(calculation.schemaVersion),
      ));
      return const Success(null);
    } catch (e) {
      return Failure('Failed to save calculation: $e');
    }
  }

  @override
  Future<Result<void>> deleteCalculation(String id) async {
    try {
      await _dao.deleteCalculation(id);
      return const Success(null);
    } catch (e) {
      return Failure('Failed to delete calculation: $e');
    }
  }

  @override
  Future<Result<void>> deleteAllCalculations() async {
    try {
      await _dao.deleteAllCalculations();
      return const Success(null);
    } catch (e) {
      return Failure('Failed to delete all calculations: $e');
    }
  }
}
