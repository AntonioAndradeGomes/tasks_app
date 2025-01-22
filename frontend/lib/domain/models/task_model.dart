import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

extension TaskModelDateFormatter on TaskModel {
  String? formattedDueAt() {
    return dueAt != null
        ? DateFormat("d 'de' MMMM 'de' y", 'pt_BR').format(dueAt!)
        : null;
  }

  String? formattedCompletedAt() {
    return completedAt != null
        ? DateFormat('dd/MM/yyyy').format(completedAt!)
        : null;
  }
}

// ignore: must_be_immutable
class TaskModel extends Equatable {
  final String? id;
  String title;
  String? description;
  String? hexColor;
  final String? userId;
  DateTime? dueAt;
  DateTime? completedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TaskModel({
    this.id,
    required this.title,
    this.description,
    this.hexColor,
    this.userId,
    this.dueAt,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? hexColor,
    String? userId,
    DateTime? dueAt,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      hexColor: hexColor ?? this.hexColor,
      userId: userId ?? this.userId,
      dueAt: dueAt ?? this.dueAt,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'hexColor': hexColor?.toUpperCase(),
      'due_at': dueAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      hexColor: (map['hexColor'] as String).toUpperCase(),
      userId: map['user_id'] as String,
      dueAt: map['due_at'] != null
          ? DateTime.parse(map['due_at'] as String)
          : null,
      completedAt: map['completed_at'] != null
          ? DateTime.parse(map['completed_at'] as String)
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title.trim(),
        description?.trim(),
        hexColor?.toUpperCase(),
        userId,
        dueAt,
        completedAt,
        createdAt,
        updatedAt
      ];
}
