import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'core/providers/locale_provider.dart';
import 'data/database/daos/calculations_dao.dart';
import 'data/database/daos/wills_dao.dart';
import 'data/database/siraji_database.dart';
import 'data/preferences/preferences_helper.dart';
import 'data/repositories/calculation_repository_impl.dart';
import 'data/repositories/will_repository_impl.dart';
import 'domain/repositories/calculation_repository.dart';
import 'domain/repositories/will_repository.dart';
import 'features/calculations/providers/calculation_flow_provider.dart';
import 'features/knowledge/providers/knowledge_provider.dart';
import 'features/reports/providers/reports_provider.dart';
import 'features/will/providers/will_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final preferencesHelper = PreferencesHelper(prefs);
  final isFirstLaunch = preferencesHelper.isFirstLaunch;

  final database = SirajiDatabase();
  final calculationsDao = CalculationsDao(database);
  final willsDao = WillsDao(database);

  final calculationRepository = CalculationRepositoryImpl(calculationsDao);
  final willRepository = WillRepositoryImpl(willsDao);

  runApp(
    MultiProvider(
      providers: [
        Provider<CalculationRepository>.value(value: calculationRepository),
        Provider<CalculationRepositoryImpl>.value(value: calculationRepository),
        Provider<WillRepository>.value(value: willRepository),
        ChangeNotifierProvider(
          create: (_) => LocaleProvider(preferencesHelper),
        ),
        ChangeNotifierProvider(
          create: (_) => CalculationFlowProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => KnowledgeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReportsProvider(repository: calculationRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => WillProvider(repository: willRepository),
        ),
      ],
      child: SirajiApp(isFirstLaunch: isFirstLaunch),
    ),
  );
}
