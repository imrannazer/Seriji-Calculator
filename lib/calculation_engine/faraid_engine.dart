import '../domain/models/estate.dart';
import '../domain/models/calculation_result.dart';
import '../core/result/result.dart';
import 'validation/calculation_validator.dart';
import 'eligibility/eligibility_engine.dart';
import 'exclusion/exclusion_engine.dart';
import 'shares/share_calculator.dart';

class FaraidEngine {
  FaraidEngine({
    CalculationValidator? validator,
    EligibilityEngine? eligibilityEngine,
    ExclusionEngine? exclusionEngine,
    ShareCalculator? shareCalculator,
  })  : _validator = validator ?? const CalculationValidator(),
        _eligibilityEngine = eligibilityEngine ?? const EligibilityEngine(),
        _exclusionEngine = exclusionEngine ?? const ExclusionEngine(),
        _shareCalculator = shareCalculator ?? const ShareCalculator();

  final CalculationValidator _validator;
  final EligibilityEngine _eligibilityEngine;
  final ExclusionEngine _exclusionEngine;
  final ShareCalculator _shareCalculator;

  Result<CalculationResult> calculate(Estate estate) {
    final validation = _validator.validate(estate);
    if (validation.isFailure) {
      return Failure(validation.errorOrNull!);
    }

    final eligibilityResults = _eligibilityEngine.evaluate(estate);
    final exclusionResults = _exclusionEngine.apply(eligibilityResults);
    final shares = _shareCalculator.calculate(
      exclusionResults: exclusionResults,
      netDistributableValue: estate.netDistributableValue,
    );

    final result = CalculationResult(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      estate: estate,
      shares: shares,
      calculatedAt: DateTime.now(),
      explanation: 'Phase 0 architecture verification.',
      warnings: const [
        'Phase 0 Foundation. Full rule set active in Phase 3.'
      ],
    );

    return Success(result);
  }
}
