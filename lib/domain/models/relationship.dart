enum Gender { male, female }

enum Relationship {
  husband,
  wife,
  son,
  daughter,
  father,
  mother,
  grandfather,
  grandmother,
  maternalGrandmother,
  grandson,
  granddaughter,
  fullBrother,
  fullSister,
  paternalHalfBrother,
  paternalHalfSister,
  maternalHalfBrother,
  maternalHalfSister,
  paternalUncle,
  paternalUnclesSon,
}

extension RelationshipExtension on Relationship {
  bool get isMale => switch (this) {
        Relationship.husband ||
        Relationship.son ||
        Relationship.father ||
        Relationship.grandfather ||
        Relationship.grandson ||
        Relationship.fullBrother ||
        Relationship.paternalHalfBrother ||
        Relationship.maternalHalfBrother ||
        Relationship.paternalUncle ||
        Relationship.paternalUnclesSon =>
          true,
        _ => false,
      };

  bool get isFemale => !isMale;
  Gender get gender => isMale ? Gender.male : Gender.female;
}
