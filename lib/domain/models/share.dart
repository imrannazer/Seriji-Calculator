import 'package:equatable/equatable.dart';

class Share extends Equatable {
  const Share({
    required this.heirId,
    required this.numerator,
    required this.denominator,
    required this.decimalValue,
    this.amount = 0.0,
    this.shareType = ShareType.residual,
    this.explanation,
    this.count = 1,
    this.individualAmount = 0.0,
  });

  final String heirId;
  final int numerator;
  final int denominator;
  final double decimalValue;
  final double amount;
  final ShareType shareType;
  final String? explanation;
  final int count;
  final double individualAmount;

  String get fractionString => '$numerator/$denominator';
  String get percentageString => '${(decimalValue * 100).toStringAsFixed(2)}%';

  static const Share zero = Share(
    heirId: '',
    numerator: 0,
    denominator: 1,
    decimalValue: 0.0,
    amount: 0.0,
    shareType: ShareType.excluded,
  );

  @override
  List<Object?> get props => [heirId, numerator, denominator, decimalValue, amount, shareType, count];
}

enum ShareType { fixed, residual, excluded, ineligible }
