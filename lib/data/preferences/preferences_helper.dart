import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class PreferencesHelper {
  PreferencesHelper(this._prefs);

  final SharedPreferences _prefs;

  String? get languageCode =>
      _prefs.getString(AppConstants.prefLanguageCode);

  Future<void> setLanguageCode(String code) =>
      _prefs.setString(AppConstants.prefLanguageCode, code);

  bool get isFirstLaunch =>
      _prefs.getBool(AppConstants.prefIsFirstLaunch) ?? true;

  Future<void> setFirstLaunchComplete() =>
      _prefs.setBool(AppConstants.prefIsFirstLaunch, false);

  String? get themeMode =>
      _prefs.getString(AppConstants.prefThemeMode);

  Future<void> setThemeMode(String mode) =>
      _prefs.setString(AppConstants.prefThemeMode, mode);
}
