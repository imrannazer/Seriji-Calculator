import '../../domain/models/heir.dart';
import '../../domain/models/estate.dart';

class EligibilityResult {
  const EligibilityResult({
    required this.heir,
    required this.isEligible,
    this.reason,
  });

  final Heir heir;
  final bool isEligible;
  final String? reason;
}

class EligibilityEngine {
  const EligibilityEngine();

  List<EligibilityResult> evaluate(Estate estate) {
    return estate.heirs.map((heir) => _checkEligibility(heir)).toList();
  }

  EligibilityResult _checkEligibility(Heir heir) {
    if (!heir.isAlive) {
      return EligibilityResult(
        heir: heir,
        isEligible: false,
        reason: 'Heir is deceased.',
      );
    }
    return EligibilityResult(
      heir: heir,
      isEligible: true,
    );
  }
}
