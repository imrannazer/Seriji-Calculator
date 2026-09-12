import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/calculation_engine/shares/share_calculator.dart';
import 'package:siraji/calculation_engine/exclusion/exclusion_engine.dart';
import 'package:siraji/domain/models/heir.dart';
import 'package:siraji/domain/models/relationship.dart';

void main() {
  group('ShareCalculator Tests', () {
    const calculator = ShareCalculator();

    test('Calculation pipeline produces share entries', () {
      const heir = Heir(id: 'h1', relationship: Relationship.son);
      final shares = calculator.calculate(
        exclusionResults: [
          const ExclusionResult(heir: heir, isExcluded: false),
        ],
        netDistributableValue: 100000.0,
      );

      expect(shares.length, 1);
      expect(shares.first.heirId, 'h1');
    });
  });
}
