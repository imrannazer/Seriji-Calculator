import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siraji/app.dart';
import 'package:siraji/core/providers/locale_provider.dart';
import 'package:siraji/data/preferences/preferences_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PreferencesHelper preferencesHelper;
  late LocaleProvider localeProvider;

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'language_code': 'en',
      'is_first_launch': false,
    });
    final prefs = await SharedPreferences.getInstance();
    preferencesHelper = PreferencesHelper(prefs);
    localeProvider = LocaleProvider(preferencesHelper);
  });

  group('Phase 1 App Shell & Navigation Tests', () {
    testWidgets('Renders SirajiApp and reaches Home Dashboard', (tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: localeProvider),
          ],
          child: const SirajiApp(isFirstLaunch: false),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Header & Home Greeting
      expect(find.text('Welcome to Siraji'), findsOneWidget);
      expect(find.text('Faraid Calculation'), findsOneWidget);
      expect(find.text('Start Calculation'), findsOneWidget);

      // Verify 5 navigation tabs
      expect(find.text('Home'), findsWidgets);
      expect(find.text('Calculations'), findsWidgets);
      expect(find.text('Knowledge'), findsWidgets);
      expect(find.text('Reports'), findsWidgets);
      expect(find.text('Settings'), findsWidgets);
    });

    test('LocaleProvider dynamically switches and persists language', () async {
      expect(localeProvider.languageCode, 'en');
      expect(localeProvider.isRTL, isFalse);

      await localeProvider.setLanguageCode('ur');
      expect(localeProvider.languageCode, 'ur');
      expect(localeProvider.isRTL, isTrue);
      expect(preferencesHelper.languageCode, 'ur');

      await localeProvider.setLanguageCode('ar');
      expect(localeProvider.languageCode, 'ar');
      expect(localeProvider.isRTL, isTrue);
      expect(preferencesHelper.languageCode, 'ar');

      await localeProvider.setLanguageCode('en');
      expect(localeProvider.languageCode, 'en');
      expect(localeProvider.isRTL, isFalse);
      expect(preferencesHelper.languageCode, 'en');
    });
  });
}
