import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String? id;
  final String title;
  final String? description;
  final String? hexColor;
  final String? userId;
  final DateTime? dueAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaskModel({
    this.id,
    required this.title,
    this.description,
    this.hexColor,
    this.userId,
    this.dueAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

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
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : DateTime.now(),
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
