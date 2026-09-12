import 'package:flutter_test/flutter_test.dart';
import 'package:siraji/domain/models/heir.dart';
import 'package:siraji/domain/models/relationship.dart';

void main() {
  group('Heir Model Tests', () {
    test('Heir instantiation and properties', () {
      const heir = Heir(
        id: 'h1',
        relationship: Relationship.son,
        name: 'Ahmad',
        isAlive: true,
      );

      expect(heir.id, 'h1');
      expect(heir.relationship, Relationship.son);
      expect(heir.relationship.isMale, isTrue);
      expect(heir.relationship.isFemale, isFalse);
      expect(heir.name, 'Ahmad');
      expect(heir.isAlive, isTrue);
    });

    test('Relationship gender check', () {
      expect(Relationship.daughter.isFemale, isTrue);
      expect(Relationship.mother.isFemale, isTrue);
      expect(Relationship.wife.isFemale, isTrue);
      expect(Relationship.father.isMale, isTrue);
      expect(Relationship.husband.isMale, isTrue);
    });
  });
}
