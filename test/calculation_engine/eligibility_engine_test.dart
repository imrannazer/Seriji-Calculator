import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/calculation_engine/eligibility/eligibility_engine.dart';
import 'package:siraji/domain/models/estate.dart';
import 'package:siraji/domain/models/heir.dart';
import 'package:siraji/domain/models/relationship.dart';

void main() {
  group('EligibilityEngine Tests', () {
    const engine = EligibilityEngine();

    test('Living heirs are eligible, deceased heirs are ineligible', () {
      const estate = Estate(
        id: 'e1',
        deceasedName: 'Khalid',
        heirs: [
          Heir(id: 'h1', relationship: Relationship.son, isAlive: true),
          Heir(id: 'h2', relationship: Relationship.daughter, isAlive: false),
        ],
        assets: [],
      );

      final results = engine.evaluate(estate);
      expect(results.length, 2);
      expect(results[0].isEligible, isTrue);
      expect(results[1].isEligible, isFalse);
      expect(results[1].reason, contains('deceased'));
    });
  });
}
