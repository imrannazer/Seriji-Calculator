import '../../domain/repositories/preferences_repository.dart';
import '../../core/result/result.dart';
import '../preferences/preferences_helper.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  const PreferencesRepositoryImpl(this._helper);

  final PreferencesHelper _helper;

  @override
  Future<Result<String?>> getLanguageCode() async {
    try {
      return Success(_helper.languageCode);
    } catch (e) {
      return Failure('Failed to read language code: $e');
    }
  }

  @override
  Future<Result<void>> setLanguageCode(String code) async {
    try {
      await _helper.setLanguageCode(code);
      return const Success(null);
    } catch (e) {
      return Failure('Failed to save language code: $e');
    }
  }

  @override
  Future<Result<bool>> isFirstLaunch() async {
    try {
      return Success(_helper.isFirstLaunch);
    } catch (e) {
      return Failure('Failed to check first launch: $e');
    }
  }

  @override
  Future<Result<void>> setFirstLaunchComplete() async {
    try {
      await _helper.setFirstLaunchComplete();
      return const Success(null);
    } catch (e) {
      return Failure('Failed to set first launch complete: $e');
    }
  }

  @override
  Future<Result<String?>> getThemeMode() async {
    try {
      return Success(_helper.themeMode);
    } catch (e) {
      return Failure('Failed to read theme mode: $e');
    }
  }

  @override
  Future<Result<void>> setThemeMode(String mode) async {
    try {
      await _helper.setThemeMode(mode);
      return const Success(null);
    } catch (e) {
      return Failure('Failed to save theme mode: $e');
    }
  }
}
