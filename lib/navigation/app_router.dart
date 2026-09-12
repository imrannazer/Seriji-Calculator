import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../features/splash/splash_screen.dart';
import '../features/language/language_screen.dart';
import '../features/home/home_screen.dart';
import '../features/calculations/calculations_screen.dart';
import '../features/calculations/screens/calculation_flow_screen.dart';
import '../features/calculations/screens/calculation_result_screen.dart';
import '../features/knowledge/knowledge_screen.dart';
import '../features/knowledge/screens/knowledge_article_detail_screen.dart';
import '../features/reports/reports_screen.dart';
import '../features/reports/screens/report_detail_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/settings/screens/settings_language_screen.dart';
import '../features/settings/screens/settings_data_screen.dart';
import '../features/settings/screens/settings_help_screen.dart';
import '../features/settings/screens/settings_about_screen.dart';
import '../features/will/will_screen.dart';
import '../features/will/screens/will_editor_screen.dart';

class AppRouter {
  AppRouter._();

  static GoRouter create({required bool isFirstLaunch}) {
    return GoRouter(
      initialLocation: isFirstLaunch ? RouteNames.splash : RouteNames.home,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: RouteNames.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: RouteNames.language,
          builder: (context, state) => const LanguageScreen(),
        ),
        GoRoute(
          path: RouteNames.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RouteNames.calculations,
          builder: (context, state) => const CalculationsScreen(),
        ),
        GoRoute(
          path: RouteNames.calculationFlow,
          builder: (context, state) => const CalculationFlowScreen(),
        ),
        GoRoute(
          path: RouteNames.calculationResult,
          builder: (context, state) => const CalculationResultScreen(),
        ),
        GoRoute(
          path: RouteNames.knowledge,
          builder: (context, state) => const KnowledgeScreen(),
        ),
        GoRoute(
          path: RouteNames.knowledgeArticle,
          builder: (context, state) {
            final articleId = state.pathParameters['articleId'] ?? '';
            return KnowledgeArticleDetailScreen(articleId: articleId);
          },
        ),
        GoRoute(
          path: RouteNames.reports,
          builder: (context, state) => const ReportsScreen(),
        ),
        GoRoute(
          path: RouteNames.reportDetail,
          builder: (context, state) {
            final reportId = state.pathParameters['id'] ?? '';
            return ReportDetailScreen(reportId: reportId);
          },
        ),
        GoRoute(
          path: '/will',
          builder: (context, state) => const WillScreen(),
        ),
        GoRoute(
          path: RouteNames.newWill,
          builder: (context, state) => const WillEditorScreen(),
        ),
        GoRoute(
          path: RouteNames.willDetail,
          builder: (context, state) {
            final willId = state.pathParameters['id'] ?? '';
            return WillEditorScreen(willId: willId);
          },
        ),
        GoRoute(
          path: RouteNames.settings,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: RouteNames.settingsLanguage,
          builder: (context, state) => const SettingsLanguageScreen(),
        ),
        GoRoute(
          path: RouteNames.settingsData,
          builder: (context, state) => const SettingsDataScreen(),
        ),
        GoRoute(
          path: RouteNames.settingsHelp,
          builder: (context, state) => const SettingsHelpScreen(),
        ),
        GoRoute(
          path: RouteNames.settingsAbout,
          builder: (context, state) => const SettingsAboutScreen(),
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Page not found: ${state.uri}'),
            ],
          ),
        ),
      ),
    );
  }
}
