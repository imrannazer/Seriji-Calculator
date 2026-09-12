import '../../core/result/result.dart';

abstract interface class ImportService {
  Future<Result<void>> importBackupJson(String jsonString);
}
