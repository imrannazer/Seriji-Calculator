import '../../domain/models/relationship.dart';
import '../../domain/models/share.dart';
import '../exclusion/exclusion_engine.dart';

class ShareCalculator {
  const ShareCalculator();

  List<Share> calculate({
    required List<ExclusionResult> exclusionResults,
    required double netDistributableValue,
  }) {
    final shares = <Share>[];
    final activeHeirs = exclusionResults
        .where((r) => !r.isExcluded)
        .map((r) => r.heir)
        .toList();

    // Check presence of children
    final sons = activeHeirs.where((h) => h.relationship == Relationship.son).fold(0, (s, h) => s + h.count);
    final daughters = activeHeirs.where((h) => h.relationship == Relationship.daughter).fold(0, (s, h) => s + h.count);
    final grandsons = activeHeirs.where((h) => h.relationship == Relationship.grandson).fold(0, (s, h) => s + h.count);
    final granddaughters = activeHeirs.where((h) => h.relationship == Relationship.granddaughter).fold(0, (s, h) => s + h.count);
    final hasChildren = (sons + daughters + grandsons + granddaughters) > 0;

    // Siblings count
    final siblingCount = activeHeirs
        .where((h) =>
            h.relationship == Relationship.fullBrother ||
            h.relationship == Relationship.fullSister ||
            h.relationship == Relationship.paternalHalfBrother ||
            h.relationship == Relationship.paternalHalfSister ||
            h.relationship == Relationship.maternalHalfBrother ||
            h.relationship == Relationship.maternalHalfSister)
        .fold(0, (s, h) => s + h.count);

    double totalFixedFraction = 0.0;
    final Map<String, ({int num, int den, double dec, String exp, ShareType type})> fixedMap = {};

    // 1. Calculate Quranic Fixed Shares (Zawil-Furood)
    for (final result in exclusionResults) {
      if (result.isExcluded) {
        shares.add(Share(
          heirId: result.heir.id,
          numerator: 0,
          denominator: 1,
          decimalValue: 0.0,
          amount: 0.0,
          shareType: ShareType.excluded,
          explanation: result.reason ?? 'Excluded',
          count: result.heir.count,
        ));
        continue;
      }

      final heir = result.heir;
      final rel = heir.relationship;

      if (rel == Relationship.husband) {
        final num = hasChildren ? 1 : 1;
        final den = hasChildren ? 4 : 2;
        final dec = num / den;
        totalFixedFraction += dec;
        fixedMap[heir.id] = (
          num: num,
          den: den,
          dec: dec,
          exp: hasChildren ? 'Quran 4:12 — 1/4 with surviving children' : 'Quran 4:12 — 1/2 without surviving children',
          type: ShareType.fixed,
        );
      } else if (rel == Relationship.wife) {
        final num = hasChildren ? 1 : 1;
        final den = hasChildren ? 8 : 4;
        final dec = num / den;
        totalFixedFraction += dec;
        fixedMap[heir.id] = (
          num: num,
          den: den,
          dec: dec,
          exp: hasChildren
              ? 'Quran 4:12 — 1/8 shared among wives with surviving children'
              : 'Quran 4:12 — 1/4 shared among wives without surviving children',
          type: ShareType.fixed,
        );
      } else if (rel == Relationship.mother) {
        final hasReduction = hasChildren || siblingCount >= 2;
        const num = 1;
        final den = hasReduction ? 6 : 3;
        final dec = num / den;
        totalFixedFraction += dec;
        fixedMap[heir.id] = (
          num: num,
          den: den,
          dec: dec,
          exp: hasReduction
              ? 'Quran 4:11 — 1/6 due to presence of children or multiple siblings'
              : 'Quran 4:11 — 1/3 in absence of children and multiple siblings',
          type: ShareType.fixed,
        );
      } else if (rel == Relationship.father) {
        if (hasChildren) {
          const num = 1;
          const den = 6;
          const dec = 1.0 / 6.0;
          totalFixedFraction += dec;
          fixedMap[heir.id] = (
            num: num,
            den: den,
            dec: dec,
            exp: 'Quran 4:11 — 1/6 fixed share with surviving children',
            type: ShareType.fixed,
          );
        }
      } else if (rel == Relationship.daughter && sons == 0) {
        final count = heir.count;
        final num = count == 1 ? 1 : 2;
        final den = count == 1 ? 2 : 3;
        final dec = num / den;
        totalFixedFraction += dec;
        fixedMap[heir.id] = (
          num: num,
          den: den,
          dec: dec,
          exp: count == 1
              ? 'Quran 4:11 — 1/2 for a single daughter with no sons'
              : 'Quran 4:11 — 2/3 shared equally among daughters with no sons',
          type: ShareType.fixed,
        );
      }
    }

    // 2. Calculate Residual (Asaba) Shares
    final double remainingFraction = (1.0 - totalFixedFraction).clamp(0.0, 1.0);

    final bool hasSonAsaba = sons > 0;
    final int sonUnits = sons * 2;
    final int daughterUnits = daughters * 1;
    final int totalChildUnits = sonUnits + daughterUnits;

    for (final result in exclusionResults) {
      if (result.isExcluded) continue;
      final heir = result.heir;
      final rel = heir.relationship;

      if (fixedMap.containsKey(heir.id)) {
        final f = fixedMap[heir.id]!;
        final shareAmount = f.dec * netDistributableValue;
        final indivAmount = heir.count > 0 ? shareAmount / heir.count : shareAmount;
        shares.add(Share(
          heirId: heir.id,
          numerator: f.num,
          denominator: f.den,
          decimalValue: f.dec,
          amount: shareAmount,
          individualAmount: indivAmount,
          shareType: f.type,
          explanation: f.exp,
          count: heir.count,
        ));
      } else if (hasSonAsaba && (rel == Relationship.son || rel == Relationship.daughter)) {
        final units = rel == Relationship.son ? (heir.count * 2) : (heir.count * 1);
        final heirFraction = totalChildUnits > 0 ? (remainingFraction * (units / totalChildUnits)) : 0.0;
        final shareAmount = heirFraction * netDistributableValue;
        final indivAmount = heir.count > 0 ? shareAmount / heir.count : shareAmount;
        shares.add(Share(
          heirId: heir.id,
          numerator: units,
          denominator: totalChildUnits > 0 ? totalChildUnits : 1,
          decimalValue: heirFraction,
          amount: shareAmount,
          individualAmount: indivAmount,
          shareType: ShareType.residual,
          explanation: 'Quran 4:11 — Asaba bi-ghayriha (2:1 male to female ratio for residue)',
          count: heir.count,
        ));
      } else if (rel == Relationship.father && !hasChildren) {
        final shareAmount = remainingFraction * netDistributableValue;
        shares.add(Share(
          heirId: heir.id,
          numerator: 1,
          denominator: 1,
          decimalValue: remainingFraction,
          amount: shareAmount,
          individualAmount: shareAmount,
          shareType: ShareType.residual,
          explanation: 'Asaba bi-nafsihi — Takes entire residue in absence of descendants',
          count: heir.count,
        ));
      } else {
        final shareAmount = remainingFraction * netDistributableValue;
        shares.add(Share(
          heirId: heir.id,
          numerator: 0,
          denominator: 1,
          decimalValue: remainingFraction,
          amount: shareAmount,
          individualAmount: heir.count > 0 ? shareAmount / heir.count : shareAmount,
          shareType: ShareType.residual,
          explanation: 'Asaba (Residuary Heir) after fixed Quranic shares.',
          count: heir.count,
        ));
      }
    }

    return shares;
  }
}
