import 'package:equatable/equatable.dart';
import 'heir.dart';
import 'share.dart';
import 'estate.dart';

class CalculationResult extends Equatable {
  const CalculationResult({
    required this.id,
    required this.estate,
    required this.shares,
    required this.calculatedAt,
    this.explanation,
    this.warnings = const [],
  });

  final String id;
  final Estate estate;
  final List<Share> shares;
  final DateTime calculatedAt;
  final String? explanation;
  final List<String> warnings;

  bool get hasWarnings => warnings.isNotEmpty;

  Share? shareForHeir(Heir heir) =>
      shares.where((s) => s.heirId == heir.id).firstOrNull;

  @override
  List<Object?> get props => [id, estate, shares, calculatedAt];
}
