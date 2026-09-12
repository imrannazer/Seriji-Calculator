import 'package:equatable/equatable.dart';

class Calculation extends Equatable {
  const Calculation({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.dataJson,
    this.updatedAt,
    this.schemaVersion = 1,
  });

  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String dataJson;
  final int schemaVersion;

  @override
  List<Object?> get props => [id, title, createdAt, schemaVersion];
}
