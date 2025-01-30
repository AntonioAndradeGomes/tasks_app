import 'package:frontend/domain/models/task_model.dart';

class TaskDto {
  String? id;
  String title;
  String? description;
  String? hexColor;
  DateTime? dueAt;
  DateTime? completedAt;

  TaskDto({
    this.id,
    this.title = '',
    this.description,
    this.hexColor,
    this.dueAt,
    this.completedAt,
  });

  void setTitle(String title) {
    this.title = title;
  }

  void setDescription(String description) {
    this.description = description;
  }

  void setHexColor(String hexColor) {
    this.hexColor = hexColor;
  }

  void setDueAt(DateTime? dueAt) {
    this.dueAt = dueAt;
  }

  void setCompletedAt(DateTime? completedAt) {
    this.completedAt = completedAt;
  }

  factory TaskDto.fromModel(TaskModel task) => TaskDto(
        id: task.id,
        title: task.title,
        description: task.description,
        hexColor: task.hexColor,
        dueAt: task.dueAt,
        completedAt: task.completedAt,
      );

  bool equalsModel(TaskModel model) {
    return id == model.id &&
        title.trim() == model.title.trim() &&
        (description?.trim() ?? '') == (model.description?.trim() ?? '') &&
        (hexColor?.toUpperCase() ?? '') ==
            (model.hexColor?.toUpperCase() ?? '') &&
        dueAt?.toUtc() == model.dueAt?.toUtc() &&
        completedAt?.toUtc() == model.completedAt?.toUtc();
  }

  toMap() => {
        'title': title,
        'description': description,
        'hexColor': hexColor?.toUpperCase(),
        'due_at': dueAt?.toIso8601String(),
        'completed_at': completedAt?.toIso8601String(),
      };
}
