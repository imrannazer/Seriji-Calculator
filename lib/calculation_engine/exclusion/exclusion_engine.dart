import '../../domain/models/heir.dart';
import '../../domain/models/relationship.dart';
import '../eligibility/eligibility_engine.dart';

class ExclusionResult {
  const ExclusionResult({
    required this.heir,
    required this.isExcluded,
    this.reason,
  });

  final Heir heir;
  final bool isExcluded;
  final String? reason;
}

class ExclusionEngine {
  const ExclusionEngine();

  List<ExclusionResult> apply(List<EligibilityResult> eligibilityResults) {
    final eligibleHeirs = eligibilityResults
        .where((r) => r.isEligible)
        .map((r) => r.heir)
        .toList();

    final hasSon = eligibleHeirs.any((h) => h.relationship == Relationship.son);
    final hasFather = eligibleHeirs.any((h) => h.relationship == Relationship.father);
    final hasMother = eligibleHeirs.any((h) => h.relationship == Relationship.mother);
    final hasBrother = eligibleHeirs.any((h) => h.relationship == Relationship.fullBrother);

    return eligibilityResults.map((result) {
      if (!result.isEligible) {
        return ExclusionResult(
          heir: result.heir,
          isExcluded: true,
          reason: result.reason ?? 'Ineligible',
        );
      }

      final rel = result.heir.relationship;

      // Islamic Hajb (Exclusion) Rules:
      // 1. Son excludes Grandson & Granddaughter
      if ((rel == Relationship.grandson || rel == Relationship.granddaughter) && hasSon) {
        return ExclusionResult(
          heir: result.heir,
          isExcluded: true,
          reason: 'Excluded by the presence of a direct Son (Hajb Hirman).',
        );
      }

      // 2. Father excludes Grandfather, Brothers, Sisters, and Paternal Uncles
      if (hasFather) {
        if (rel == Relationship.grandfather ||
            rel == Relationship.fullBrother ||
            rel == Relationship.fullSister ||
            rel == Relationship.paternalHalfBrother ||
            rel == Relationship.paternalHalfSister ||
            rel == Relationship.maternalHalfBrother ||
            rel == Relationship.maternalHalfSister ||
            rel == Relationship.paternalUncle ||
            rel == Relationship.paternalUnclesSon) {
          return ExclusionResult(
            heir: result.heir,
            isExcluded: true,
            reason: 'Excluded by the presence of the Father (Hajb Hirman).',
          );
        }
      }

      // 3. Son excludes all Brothers, Sisters, and Uncles
      if (hasSon) {
        if (rel == Relationship.fullBrother ||
            rel == Relationship.fullSister ||
            rel == Relationship.paternalHalfBrother ||
            rel == Relationship.paternalHalfSister ||
            rel == Relationship.maternalHalfBrother ||
            rel == Relationship.maternalHalfSister ||
            rel == Relationship.paternalUncle ||
            rel == Relationship.paternalUnclesSon) {
          return ExclusionResult(
            heir: result.heir,
            isExcluded: true,
            reason: 'Excluded by the presence of male descendant (Son).',
          );
        }
      }

      // 4. Mother excludes Paternal & Maternal Grandmothers
      if (hasMother && (rel == Relationship.grandmother || rel == Relationship.maternalGrandmother)) {
        return ExclusionResult(
          heir: result.heir,
          isExcluded: true,
          reason: 'Excluded by the presence of the Mother.',
        );
      }

      // 5. Full Brother excludes Paternal Half-Brothers/Sisters and Uncles
      if (hasBrother && (rel == Relationship.paternalHalfBrother ||
          rel == Relationship.paternalHalfSister ||
          rel == Relationship.paternalUncle ||
          rel == Relationship.paternalUnclesSon)) {
        return ExclusionResult(
          heir: result.heir,
          isExcluded: true,
          reason: 'Excluded by the presence of a Full Brother.',
        );
      }

      return ExclusionResult(heir: result.heir, isExcluded: false);
    }).toList();
  }
}
