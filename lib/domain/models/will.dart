import 'package:equatable/equatable.dart';

enum WillStatus { draft, reviewed, finalized }

class Will extends Equatable {
  const Will({
    required this.id,
    required this.testatorName,
    required this.createdAt,
    required this.status,
    this.bequestNotes,
    this.updatedAt,
    this.dataJson,
    this.schemaVersion = 1,
  });

  final String id;
  final String testatorName;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final WillStatus status;
  final String? bequestNotes;
  final String? dataJson;
  final int schemaVersion;

  Will copyWith({
    String? id,
    String? testatorName,
    DateTime? createdAt,
    DateTime? updatedAt,
    WillStatus? status,
    String? bequestNotes,
    String? dataJson,
    int? schemaVersion,
  }) {
    return Will(
      id: id ?? this.id,
      testatorName: testatorName ?? this.testatorName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      bequestNotes: bequestNotes ?? this.bequestNotes,
      dataJson: dataJson ?? this.dataJson,
      schemaVersion: schemaVersion ?? this.schemaVersion,
    );
  }

  @override
  List<Object?> get props => [id, testatorName, createdAt, status, updatedAt, bequestNotes, dataJson, schemaVersion];
}
