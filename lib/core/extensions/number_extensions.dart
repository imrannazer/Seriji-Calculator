import 'package:intl/intl.dart';

extension IntExtensions on int {
  String toLocalizedString(String languageCode) {
    final fmt = NumberFormat.decimalPattern(languageCode);
    return fmt.format(this);
  }
}

extension DoubleExtensions on double {
  String toLocalizedString(String languageCode, {int decimalPlaces = 2}) {
    final fmt = NumberFormat.decimalPatternDigits(
      locale: languageCode,
      decimalDigits: decimalPlaces,
    );
    return fmt.format(this);
  }

  String toFractionString() {
    final commonFractions = {
      0.5: '1/2',
      0.25: '1/4',
      0.125: '1/8',
      1 / 3: '1/3',
      2 / 3: '2/3',
      1 / 6: '1/6',
    };
    for (final entry in commonFractions.entries) {
      if ((this - entry.key).abs() < 0.0001) return entry.value;
    }
    return toStringAsFixed(4);
  }

  bool get isZero => this == 0.0;
  bool get isPositive => this > 0.0;
}
