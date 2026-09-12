import 'package:equatable/equatable.dart';
import 'asset.dart';
import 'heir.dart';

class Estate extends Equatable {
  const Estate({
    required this.id,
    required this.deceasedName,
    required this.heirs,
    required this.assets,
    this.totalDebts = 0.0,
    this.funeralExpenses = 0.0,
    this.bequestFraction = 0.0,
    this.notes,
  });

  final String id;
  final String deceasedName;
  final List<Heir> heirs;
  final List<Asset> assets;
  final double totalDebts;
  final double funeralExpenses;
  final double bequestFraction;
  final String? notes;

  double get grossValue => assets.fold(0.0, (sum, a) => sum + a.value);

  double get netDistributableValue {
    final afterDebts = grossValue - totalDebts - funeralExpenses;
    final bequestAmount = afterDebts * bequestFraction.clamp(0.0, 1 / 3);
    return afterDebts - bequestAmount;
  }

  @override
  List<Object?> get props => [
        id,
        deceasedName,
        heirs,
        assets,
        totalDebts,
        funeralExpenses,
        bequestFraction,
      ];
}
