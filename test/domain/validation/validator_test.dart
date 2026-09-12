import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/calculation_engine/validation/calculation_validator.dart';
import 'package:siraji/domain/models/estate.dart';
import 'package:siraji/domain/models/heir.dart';
import 'package:siraji/domain/models/relationship.dart';

void main() {
  group('CalculationValidator Tests', () {
    const validator = CalculationValidator();

    test('Fails on empty deceased name', () {
      const estate = Estate(
        id: 'e1',
        deceasedName: '',
        heirs: [Heir(id: 'h1', relationship: Relationship.son)],
        assets: [],
      );

      final result = validator.validate(estate);
      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, contains('Deceased name cannot be empty'));
    });

    test('Fails when no heirs are present', () {
      const estate = Estate(
        id: 'e1',
        deceasedName: 'Zaid',
        heirs: [],
        assets: [],
      );

      final result = validator.validate(estate);
      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, contains('At least one heir'));
    });

    test('Fails on bequest greater than 1/3', () {
      const estate = Estate(
        id: 'e1',
        deceasedName: 'Zaid',
        heirs: [Heir(id: 'h1', relationship: Relationship.son)],
        assets: [],
        bequestFraction: 0.5,
      );

      final result = validator.validate(estate);
      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, contains('1/3'));
    });

    test('Succeeds on valid estate', () {
      const estate = Estate(
        id: 'e1',
        deceasedName: 'Zaid',
        heirs: [
          Heir(id: 'h1', relationship: Relationship.son),
          Heir(id: 'h2', relationship: Relationship.daughter),
        ],
        assets: [],
        bequestFraction: 0.25,
      );

      final result = validator.validate(estate);
      expect(result.isSuccess, isTrue);
    });
  });
}
