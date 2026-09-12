import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/config/app_config.dart';
import 'package:siraji/core/extensions/string_extensions.dart';

void main() {
  group('Localization & RTL Tests', () {
    test('Supported locales include Urdu, English, and Arabic only', () {
      final codes = AppConfig.supportedLocales.map((l) => l.languageCode).toList();
      expect(codes, contains('en'));
      expect(codes, contains('ur'));
      expect(codes, contains('ar'));
      expect(codes.contains('fa'), isFalse); // Strict check: NO Farsi
      expect(codes.length, 3);
    });

    test('RTL detection for Arabic and Urdu scripts', () {
      expect('سراجی'.isRTL, isTrue);
      expect('علم الفرائض'.isRTL, isTrue);
      expect('Siraji'.isRTL, isFalse);
      expect('Inheritance'.isRTL, isFalse);
    });
  });
}
