import 'package:equatable/equatable.dart';

enum AssetType { realEstate, land, company, cash, vehicle, jewelry, other }
enum DivisibilityType { divisible, indivisible, partiallyDivisible }

class Asset extends Equatable {
  const Asset({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
    this.divisibility = DivisibilityType.divisible,
    this.notes,
  });

  final String id;
  final String name;
  final AssetType type;
  final double value;
  final DivisibilityType divisibility;
  final String? notes;

  bool get isIndivisible => divisibility == DivisibilityType.indivisible;

  @override
  List<Object?> get props => [id, name, type, value, divisibility, notes];
}
