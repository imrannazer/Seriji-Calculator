import '../models/calculation.dart';
import '../../core/result/result.dart';

abstract interface class CalculationRepository {
  Future<Result<List<Calculation>>> getAllCalculations();
  Future<Result<Calculation?>> getCalculationById(String id);
  Future<Result<void>> saveCalculation(Calculation calculation);
  Future<Result<void>> deleteCalculation(String id);
  Future<Result<void>> deleteAllCalculations();
}
