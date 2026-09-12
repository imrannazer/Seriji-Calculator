enum Environment { development, testing, production }

class AppEnvironment {
  AppEnvironment._();

  static const Environment _current = Environment.development;

  static Environment get current => _current;
  static bool get isDevelopment => _current == Environment.development;
  static bool get isTesting => _current == Environment.testing;
  static bool get isProduction => _current == Environment.production;
}
