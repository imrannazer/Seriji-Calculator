import 'package:flutter/material.dart';

class AppConfig {
  AppConfig._();

  static const String appName = 'Siraji';
  static const String appNameUrdu = 'سراجی';
  static const String appNameArabic = 'سراجي';
  static const String version = '1.0.0';
  static const int buildNumber = 1;
  static const String applicationId = 'com.siraji.app';

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ur'),
    Locale('ar'),
  ];

  static const Locale defaultLocale = Locale('en');
  static const String fallbackLanguageCode = 'en';
}
