import 'package:drift/drift.dart';
import '../siraji_database.dart';
import '../tables/calculations_table.dart';

part 'calculations_dao.g.dart';

@DriftAccessor(tables: [Calculations])
class CalculationsDao extends DatabaseAccessor<SirajiDatabase>
    with _$CalculationsDaoMixin {
  CalculationsDao(super.db);

  Future<List<CalculationEntity>> getAllCalculations() =>
      select(calculations).get();

  Stream<List<CalculationEntity>> watchAllCalculations() =>
      select(calculations).watch();

  Future<CalculationEntity?> getCalculationById(String id) =>
      (select(calculations)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<void> insertCalculation(CalculationsCompanion entry) =>
      into(calculations).insertOnConflictUpdate(entry);

  Future<void> deleteCalculation(String id) =>
      (delete(calculations)..where((t) => t.id.equals(id))).go();

  Future<void> deleteAllCalculations() => delete(calculations).go();
}
