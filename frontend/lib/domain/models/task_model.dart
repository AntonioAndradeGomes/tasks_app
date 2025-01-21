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

class TaskModel extends Equatable {
  final String? id;
  final String title;
  final String? description;
  final String hexColor;
  final String? userId;
  final DateTime? dueAt;
  final DateTime? completedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.hexColor,
    required this.userId,
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

  TaskModel taskWithDueAt(DateTime? dueAt) {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      hexColor: hexColor,
      userId: userId,
      dueAt: dueAt,
      completedAt: completedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  TaskModel taskWithChecked(DateTime? completedAt) {
    return TaskModel(
      id: id,
      title: title,
      description: description,
      hexColor: hexColor,
      userId: userId,
      dueAt: dueAt,
      completedAt: completedAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'hexColor': hexColor,
      'user_id': userId,
      'due_at': dueAt?.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      hexColor: map['hexColor'] as String,
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
        title,
        description,
        hexColor,
        userId,
        dueAt,
        completedAt,
        createdAt,
        updatedAt
      ];
}
