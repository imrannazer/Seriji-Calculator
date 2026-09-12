import '../../domain/models/estate.dart';
import '../../core/result/result.dart';

class CalculationValidator {
  const CalculationValidator();

  Result<void> validate(Estate estate) {
    if (estate.deceasedName.trim().isEmpty) {
      return const Failure('Deceased name cannot be empty.');
    }
    if (estate.heirs.isEmpty) {
      return const Failure('At least one heir must be specified.');
    }
    if (estate.grossValue < 0) {
      return const Failure('Estate gross value cannot be negative.');
    }
    if (estate.totalDebts < 0) {
      return const Failure('Total debts cannot be negative.');
    }
    if (estate.funeralExpenses < 0) {
      return const Failure('Funeral expenses cannot be negative.');
    }
    if (estate.bequestFraction < 0 || estate.bequestFraction > 1 / 3) {
      return const Failure(
          'Bequest fraction must be between 0 and 1/3 (per Islamic law).');
    }

    final duplicateHeirs = _findDuplicateHeirIds(estate);
    if (duplicateHeirs.isNotEmpty) {
      return Failure('Duplicate heir IDs found: ${duplicateHeirs.join(', ')}');
    }
    return const Success(null);
  }

  List<String> _findDuplicateHeirIds(Estate estate) {
    final seen = <String>{};
    final duplicates = <String>[];
    for (final heir in estate.heirs) {
      if (!seen.add(heir.id)) {
        duplicates.add(heir.id);
      }
    }
    return duplicates;
  }
}
