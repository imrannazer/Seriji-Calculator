import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/calculation_engine/exclusion/exclusion_engine.dart';
import 'package:siraji/calculation_engine/eligibility/eligibility_engine.dart';
import 'package:siraji/domain/models/heir.dart';
import 'package:siraji/domain/models/relationship.dart';

void main() {
  group('ExclusionEngine Tests', () {
    const engine = ExclusionEngine();

    test('Eligible heirs remain unexcluded in Phase 0 stub', () {
      const eligibleHeir = Heir(id: 'h1', relationship: Relationship.son);
      final results = engine.apply([
        const EligibilityResult(heir: eligibleHeir, isEligible: true),
      ]);

      expect(results.length, 1);
      expect(results.first.isExcluded, isFalse);
    });
  });
}
