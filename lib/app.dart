import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'config/app_config.dart';
import 'core/providers/locale_provider.dart';
import 'l10n/app_localizations.dart';
import 'navigation/app_router.dart';
import 'theme/siraji_theme.dart';

class SirajiApp extends StatefulWidget {
  const SirajiApp({super.key, this.isFirstLaunch = false});

  final bool isFirstLaunch;

  @override
  State<SirajiApp> createState() => _SirajiAppState();
}

class _SirajiAppState extends State<SirajiApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.create(isFirstLaunch: widget.isFirstLaunch);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp.router(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: SirajiTheme.light,
          routerConfig: _router,
          locale: localeProvider.locale,
          supportedLocales: AppConfig.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}
