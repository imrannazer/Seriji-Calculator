class AppConstants {
  AppConstants._();

  // SharedPreferences keys
  static const String prefLanguageCode = 'language_code';
  static const String prefIsFirstLaunch = 'is_first_launch';
  static const String prefThemeMode = 'theme_mode';

  // Database
  static const String databaseName = 'siraji.db';
  static const int databaseVersion = 1;

  // Backup
  static const int backupSchemaVersion = 1;
  static const String backupFileExtension = '.siraji';

  // Layout breakpoints
  static const double breakpointMobile = 600.0;
  static const double breakpointTablet = 1200.0;

  // Animation durations
  static const int animationFastMs = 150;
  static const int animationNormalMs = 300;
  static const int animationSlowMs = 500;

  // Splash
  static const int splashDurationMs = 2800;
}
