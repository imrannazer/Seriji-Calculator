import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/core/result/result.dart';
import 'package:siraji/data/backup/siraji_backup_service.dart';
import 'package:siraji/domain/models/calculation.dart';
import 'package:siraji/domain/models/relationship.dart';
import 'package:siraji/domain/models/will.dart';
import 'package:siraji/domain/repositories/calculation_repository.dart';
import 'package:siraji/domain/repositories/will_repository.dart';
import 'package:siraji/features/calculations/providers/calculation_flow_provider.dart';
import 'package:siraji/features/will/providers/will_provider.dart';

class MockCalculationRepository implements CalculationRepository {
  final List<Calculation> _store = [];

  MockCalculationRepository(List<Calculation> initial) {
    _store.addAll(initial);
  }

  @override
  Future<Result<List<Calculation>>> getAllCalculations() async => Success(List.from(_store));

  @override
  Future<Result<Calculation?>> getCalculationById(String id) async =>
      Success(_store.where((c) => c.id == id).firstOrNull);

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

class MockWillRepository implements WillRepository {
  final List<Will> _store = [];

  MockWillRepository(List<Will> initial) {
    _store.addAll(initial);
  }

  @override
  Future<Result<List<Will>>> getAllWills() async => Success(List.from(_store));

  @override
  Future<Result<Will?>> getWillById(String id) async =>
      Success(_store.where((w) => w.id == id).firstOrNull);

  @override
  Future<Result<void>> saveWill(Will will) async {
    _store.removeWhere((w) => w.id == will.id);
    _store.add(will);
    return const Success(null);
  }

  @override
  Future<Result<void>> deleteWill(String id) async {
    _store.removeWhere((w) => w.id == id);
    return const Success(null);
  }

  @override
  Future<Result<void>> deleteAllWills() async {
    _store.clear();
    return const Success(null);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final sampleWill = Will(
    id: 'will_1',
    testatorName: 'Late Ahmad',
    createdAt: DateTime.now(),
    status: WillStatus.reviewed,
    bequestNotes: '1/3 to Orphanage and Masjid',
    dataJson: jsonEncode({
      'grossAssets': 500000.0,
      'debts': 20000.0,
      'funeralExpenses': 10000.0,
      'bequestAmount': 50000.0,
      'heirs': {'wife': 1, 'son': 2, 'daughter': 1},
    }),
  );

  final sampleCalc = Calculation(
    id: 'calc_1',
    title: 'Late Ahmad — 500000',
    createdAt: DateTime.now(),
    dataJson: jsonEncode({
      'deceasedName': 'Late Ahmad',
      'grossAssets': 500000.0,
      'netDistributableEstate': 420000.0,
      'shares': <Map<String, dynamic>>[],
    }),
  );

  group('Phase 6 Will & Backup Import/Export Tests', () {
    test('WillProvider creates, searches, updates, and deletes profiles', () async {
      final mockWillRepo = MockWillRepository([sampleWill]);
      final provider = WillProvider(repository: mockWillRepo);

      await provider.loadWills();
      expect(provider.wills.length, 1);
      expect(provider.getWillById('will_1'), isNotNull);

      // Search matching
      provider.setSearchQuery('Ahmad');
      expect(provider.getFilteredWills().length, 1);

      // Search non-matching
      provider.setSearchQuery('NonExistent');
      expect(provider.getFilteredWills().isEmpty, isTrue);

      provider.clearSearch();

      // Update
      final updated = sampleWill.copyWith(status: WillStatus.finalized);
      await provider.saveWill(updated);
      expect(provider.getWillById('will_1')?.status, WillStatus.finalized);

      // Delete
      final deleted = await provider.deleteWill('will_1');
      expect(deleted, isTrue);
      expect(provider.wills.isEmpty, isTrue);
    });

    test('SirajiBackupService generates valid backup and validates import correctly', () async {
      final mockCalcRepo = MockCalculationRepository([sampleCalc]);
      final mockWillRepo = MockWillRepository([sampleWill]);
      final service = SirajiBackupService(
        calculationRepository: mockCalcRepo,
        willRepository: mockWillRepo,
      );

      // 1. Generate Backup
      final backupRes = await service.generateBackupJson();
      expect(backupRes.isSuccess, isTrue);
      final jsonStr = backupRes.valueOrNull!;
      expect(jsonStr.contains('siraji'), isTrue);
      expect(jsonStr.contains('Late Ahmad'), isTrue);

      // 2. Validate Import with Valid Payload
      final valRes = service.validateImportJson(jsonStr);
      expect(valRes.isSuccess, isTrue);
      final preview = valRes.valueOrNull!;
      expect(preview.calculationCount, 1);
      expect(preview.willCount, 1);
      expect(preview.schemaVersion, 1);

      // 3. Restore from Preview
      final restoreRes = await service.restoreFromPreview(preview);
      expect(restoreRes.isSuccess, isTrue);
      expect(restoreRes.valueOrNull, 2);

      // 4. Reject Corrupt JSON
      final corruptRes = service.validateImportJson('{ invalid json');
      expect(corruptRes.isFailure, isTrue);

      // 5. Reject Foreign Format
      final foreignRes = service.validateImportJson(jsonEncode({'format': 'other', 'schemaVersion': 1}));
      expect(foreignRes.isFailure, isTrue);

      // 6. Reject Future Schema Version
      final futureRes = service.validateImportJson(jsonEncode({'format': 'siraji', 'schemaVersion': 99}));
      expect(futureRes.isFailure, isTrue);
    });

    test('Will profile data correctly feeds into CalculationFlowProvider and calculates', () {
      final flowProvider = CalculationFlowProvider();

      final dataMap = jsonDecode(sampleWill.dataJson!) as Map<String, dynamic>;
      flowProvider.setDeceasedInfo(
        name: sampleWill.testatorName,
        gender: Gender.male,
        maritalStatus: 'married',
      );
      flowProvider.setEstateInfo(
        grossAssets: (dataMap['grossAssets'] as num).toDouble(),
        debts: (dataMap['debts'] as num).toDouble(),
        funeralExpenses: (dataMap['funeralExpenses'] as num).toDouble(),
        bequestAmount: (dataMap['bequestAmount'] as num).toDouble(),
      );

      flowProvider.setHeirCount(Relationship.wife, 1);
      flowProvider.setHeirCount(Relationship.son, 2);
      flowProvider.setHeirCount(Relationship.daughter, 1);

      final calculated = flowProvider.calculate();
      expect(calculated, isTrue);
      expect(flowProvider.result?.shares.length, 3);
      expect(flowProvider.netDistributableEstate, 420000.0);
    });
  });
}
