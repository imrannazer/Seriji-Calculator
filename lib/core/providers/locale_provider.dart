import 'package:flutter/material.dart';
import '../../config/app_config.dart';
import '../../data/preferences/preferences_helper.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(this._preferencesHelper) {
    _loadSavedLocale();
  }

  final PreferencesHelper _preferencesHelper;
  Locale _locale = AppConfig.defaultLocale;

  Locale get locale => _locale;
  String get languageCode => _locale.languageCode;

  bool get isRTL => _locale.languageCode == 'ur' || _locale.languageCode == 'ar';
  TextDirection get textDirection => isRTL ? TextDirection.rtl : TextDirection.ltr;

  void _loadSavedLocale() {
    final savedCode = _preferencesHelper.languageCode;
    if (savedCode != null && _isSupported(savedCode)) {
      _locale = Locale(savedCode);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale newLocale) async {
    if (!_isSupported(newLocale.languageCode)) return;
    if (_locale.languageCode == newLocale.languageCode) return;

    _locale = newLocale;
    await _preferencesHelper.setLanguageCode(newLocale.languageCode);
    notifyListeners();
  }

  Future<void> setLanguageCode(String code) async {
    await setLocale(Locale(code));
  }

  bool _isSupported(String code) {
    return AppConfig.supportedLocales.any((l) => l.languageCode == code);
  }
}
