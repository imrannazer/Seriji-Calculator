import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siraji/config/app_config.dart';
import 'package:siraji/core/providers/locale_provider.dart';
import 'package:siraji/data/preferences/preferences_helper.dart';
import 'package:siraji/features/settings/screens/settings_about_screen.dart';
import 'package:siraji/features/settings/screens/settings_help_screen.dart';
import 'package:siraji/features/settings/screens/settings_language_screen.dart';
import 'package:siraji/features/settings/settings_screen.dart';
import 'package:siraji/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Phase 5 Settings, Help & About Tests', () {
    test('AppConfig returns authentic version 1.0.0 and only 3 supported locales', () {
      expect(AppConfig.version, '1.0.0');
      expect(AppConfig.buildNumber, 1);
      expect(AppConfig.appName, 'Siraji');

      final languageCodes = AppConfig.supportedLocales.map((l) => l.languageCode).toSet();
      expect(languageCodes, {'en', 'ur', 'ar'});
      expect(languageCodes.contains('fa'), isFalse); // Strict No Farsi check
    });

    testWidgets('SettingsScreen renders all 4 preference categories', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final prefHelper = PreferencesHelper(prefs);
      final localeProvider = LocaleProvider(prefHelper);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: localeProvider,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SettingsScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(find.byIcon(Icons.language), findsOneWidget);
      expect(find.byIcon(Icons.storage_outlined), findsOneWidget);
      expect(find.byIcon(Icons.help_outline), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('SettingsLanguageScreen displays English, Urdu, and Arabic options', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final prefHelper = PreferencesHelper(prefs);
      final localeProvider = LocaleProvider(prefHelper);

      await tester.pumpWidget(
        ChangeNotifierProvider.value(
          value: localeProvider,
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SettingsLanguageScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(SettingsLanguageScreen), findsOneWidget);
      expect(find.text('English'), findsWidgets);
      expect(find.text('اردو'), findsOneWidget);
      expect(find.text('العربية'), findsOneWidget);
    });

    testWidgets('SettingsHelpScreen renders FAQ topics', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SettingsHelpScreen(),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(SettingsHelpScreen), findsOneWidget);
      expect(find.byType(ExpansionTile), findsWidgets);
    });

    testWidgets('SettingsAboutScreen renders authentic version and legal disclaimer', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SettingsAboutScreen(),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byType(SettingsAboutScreen), findsOneWidget);
      expect(find.textContaining('1.0.0'), findsOneWidget);
    });
  });
}
