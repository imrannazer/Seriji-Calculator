import '../models/will.dart';
import '../../core/result/result.dart';

abstract interface class WillRepository {
  Future<Result<List<Will>>> getAllWills();
  Future<Result<Will?>> getWillById(String id);
  Future<Result<void>> saveWill(Will will);
  Future<Result<void>> deleteWill(String id);
  Future<Result<void>> deleteAllWills();
}
