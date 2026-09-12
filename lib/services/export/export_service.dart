import '../../core/result/result.dart';

abstract interface class ExportService {
  Future<Result<String>> exportBackupJson();
}
