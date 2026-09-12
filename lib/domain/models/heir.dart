import 'package:equatable/equatable.dart';
import 'relationship.dart';

class Heir extends Equatable {
  const Heir({
    required this.id,
    required this.relationship,
    this.name,
    this.isAlive = true,
    this.hasChildren = false,
    this.count = 1,
  });

  final String id;
  final Relationship relationship;
  final String? name;
  final bool isAlive;
  final bool hasChildren;
  final int count;

  Heir copyWith({
    String? id,
    Relationship? relationship,
    String? name,
    bool? isAlive,
    bool? hasChildren,
    int? count,
  }) {
    return Heir(
      id: id ?? this.id,
      relationship: relationship ?? this.relationship,
      name: name ?? this.name,
      isAlive: isAlive ?? this.isAlive,
      hasChildren: hasChildren ?? this.hasChildren,
      count: count ?? this.count,
    );
  }

  @override
  List<Object?> get props => [id, relationship, name, isAlive, hasChildren, count];
}
