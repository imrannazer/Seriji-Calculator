import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/core/result/result.dart';
import 'package:siraji/domain/models/calculation.dart';
import 'package:siraji/domain/repositories/calculation_repository.dart';
import 'package:siraji/features/reports/providers/reports_provider.dart';
import 'package:siraji/pdf/report_pdf_builder.dart';

class MockCalculationRepository implements CalculationRepository {
  final List<Calculation> _store = [];

  MockCalculationRepository(List<Calculation> initial) {
    _store.addAll(initial);
  }

  @override
  Future<Result<List<Calculation>>> getAllCalculations() async {
    return Success(List.from(_store));
  }

  @override
  Future<Result<Calculation?>> getCalculationById(String id) async {
    return Success(_store.where((c) => c.id == id).firstOrNull);
  }

  @override
  Future<Result<void>> saveCalculation(Calculation calculation) async {
    _store.removeWhere((c) => c.id == calculation.id);
    _store.add(calculation);
    return const Success(null);
  }

  @override
  Future<Result<void>> deleteCalculation(String id) async {
    _store.removeWhere((c) => c.id == id);
    return const Success(null);
  }

  @override
  Future<Result<void>> deleteAllCalculations() async {
    _store.clear();
    return const Success(null);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final sampleCalcJson = jsonEncode({
    'id': 'calc_1',
    'deceasedName': 'Marhum Tariq',
    'grossAssets': 1000000.0,
    'debts': 50000.0,
    'funeralExpenses': 25000.0,
    'bequestAmount': 25000.0,
    'netDistributableEstate': 900000.0,
    'calculatedAt': DateTime.now().toIso8601String(),
    'shares': [
      {
        'heirId': 'wife',
        'count': 1,
        'fraction': '1/8',
        'percentage': '12.5%',
        'amount': 112500.0,
        'type': 'fixed',
      },
      {
        'heirId': 'son',
        'count': 2,
        'fraction': '2/3',
        'percentage': '58.33%',
        'amount': 525000.0,
        'type': 'residual',
      },
      {
        'heirId': 'daughter',
        'count': 1,
        'fraction': '1/3',
        'percentage': '29.17%',
        'amount': 262500.0,
        'type': 'residual',
      },
    ],
  });

  final sampleCalculation = Calculation(
    id: 'calc_1',
    title: 'Marhum Tariq — 1000000',
    createdAt: DateTime.now(),
    dataJson: sampleCalcJson,
  );

  group('Phase 4 Reports & PDF Tests', () {
    test('ReportsProvider loads, searches, and deletes calculations', () async {
      final mockRepo = MockCalculationRepository([sampleCalculation]);
      final provider = ReportsProvider(repository: mockRepo);

      await provider.loadCalculations();
      expect(provider.calculations.length, 1);
      expect(provider.getCalculationById('calc_1'), isNotNull);

      // Search matching
      provider.setSearchQuery('Tariq');
      expect(provider.getFilteredCalculations().length, 1);

      // Search non-matching
      provider.setSearchQuery('NonExistent');
      expect(provider.getFilteredCalculations().isEmpty, isTrue);

      provider.clearSearch();
      expect(provider.getFilteredCalculations().length, 1);

      // Delete
      final deleted = await provider.deleteCalculation('calc_1');
      expect(deleted, isTrue);
      expect(provider.calculations.isEmpty, isTrue);
    });

    test('ReportPdfBuilder builds valid PDF bytes for English, Urdu, and Arabic', () async {
      // English PDF
      final enBytes = await ReportPdfBuilder.buildPdf(
        calculation: sampleCalculation,
        languageCode: 'en',
      );
      expect(enBytes.isNotEmpty, isTrue);
      expect(enBytes.length, greaterThan(1000));

      // Urdu PDF
      final urBytes = await ReportPdfBuilder.buildPdf(
        calculation: sampleCalculation,
        languageCode: 'ur',
      );
      expect(urBytes.isNotEmpty, isTrue);
      expect(urBytes.length, greaterThan(1000));

      // Arabic PDF
      final arBytes = await ReportPdfBuilder.buildPdf(
        calculation: sampleCalculation,
        languageCode: 'ar',
      );
      expect(arBytes.isNotEmpty, isTrue);
      expect(arBytes.length, greaterThan(1000));
    });
  });
}
