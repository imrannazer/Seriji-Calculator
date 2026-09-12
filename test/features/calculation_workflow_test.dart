import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/calculation_engine/faraid_engine.dart';
import 'package:siraji/domain/models/relationship.dart';
import 'package:siraji/domain/models/share.dart';
import 'package:siraji/features/calculations/providers/calculation_flow_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late FaraidEngine engine;
  late CalculationFlowProvider flowProvider;

  setUp(() {
    engine = FaraidEngine();
    flowProvider = CalculationFlowProvider(engine: engine);
  });

  group('Phase 2 Faraid Calculation Workflow Tests', () {
    test('Estate calculation correctly deducts debts, funeral, and bequest', () {
      flowProvider.setEstateInfo(
        grossAssets: 1000000.0,
        debts: 100000.0,
        funeralExpenses: 50000.0,
        bequestAmount: 150000.0,
      );

      expect(flowProvider.grossAssets, 1000000.0);
      expect(flowProvider.debts, 100000.0);
      expect(flowProvider.funeralExpenses, 50000.0);
      expect(flowProvider.bequestAmount, 150000.0);
      expect(flowProvider.netDistributableEstate, 700000.0);
    });

    test('Faraid calculation produces valid Quranic shares for Husband, Mother, Sons, Daughters', () {
      flowProvider.setDeceasedInfo(
        name: 'Late Fatima',
        gender: Gender.female,
        maritalStatus: 'married',
      );
      flowProvider.setEstateInfo(
        grossAssets: 600000.0,
        debts: 0.0,
        funeralExpenses: 0.0,
        bequestAmount: 0.0,
      );
      flowProvider.setHeirCount(Relationship.husband, 1);
      flowProvider.setHeirCount(Relationship.mother, 1);
      flowProvider.setHeirCount(Relationship.son, 2);
      flowProvider.setHeirCount(Relationship.daughter, 1);

      final success = flowProvider.calculate();
      expect(success, isTrue);

      final result = flowProvider.result;
      expect(result, isNotNull);
      expect(result!.shares.isNotEmpty, isTrue);

      // Husband: 1/4 (25%) = 150,000
      final husbandShare = result.shares.firstWhere((s) => s.heirId == Relationship.husband.name);
      expect(husbandShare.fractionString, '1/4');
      expect(husbandShare.shareType, ShareType.fixed);
      expect(husbandShare.amount, closeTo(150000.0, 0.01));

      // Mother: 1/6 (16.67%) = 100,000
      final motherShare = result.shares.firstWhere((s) => s.heirId == Relationship.mother.name);
      expect(motherShare.fractionString, '1/6');
      expect(motherShare.shareType, ShareType.fixed);
      expect(motherShare.amount, closeTo(100000.0, 0.01));

      // 2 Sons (4 units) + 1 Daughter (1 unit) = 5 units
      // Son share (4/5 of 350k) = 280,000 (140,000 each)
      final sonShare = result.shares.firstWhere((s) => s.heirId == Relationship.son.name);
      expect(sonShare.shareType, ShareType.residual);
      expect(sonShare.count, 2);
      expect(sonShare.amount, closeTo(280000.0, 0.01));
      expect(sonShare.individualAmount, closeTo(140000.0, 0.01));

      // Daughter share (1/5 of 350k) = 70,000
      final daughterShare = result.shares.firstWhere((s) => s.heirId == Relationship.daughter.name);
      expect(daughterShare.shareType, ShareType.residual);
      expect(daughterShare.count, 1);
      expect(daughterShare.amount, closeTo(70000.0, 0.01));

      // Total distributed = 600,000
      final totalDistributed = result.shares.fold(0.0, (sum, s) => sum + s.amount);
      expect(totalDistributed, closeTo(600000.0, 0.01));
    });
  });
}
