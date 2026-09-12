import '../../core/result/result.dart';

abstract interface class PreferencesRepository {
  Future<Result<String?>> getLanguageCode();
  Future<Result<void>> setLanguageCode(String code);
  Future<Result<bool>> isFirstLaunch();
  Future<Result<void>> setFirstLaunchComplete();
  Future<Result<String?>> getThemeMode();
  Future<Result<void>> setThemeMode(String mode);
}
