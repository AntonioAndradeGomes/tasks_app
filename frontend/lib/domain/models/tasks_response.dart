import 'package:equatable/equatable.dart';
import 'package:frontend/domain/models/filter_model.dart';
import 'package:frontend/domain/models/task_model.dart';

class TasksResponse extends Equatable {
  final List<TaskModel> tasks;
  final FilterModel filter;

  const TasksResponse({
    required this.tasks,
    required this.filter,
  });

  factory TasksResponse.fromMap(Map<String, dynamic> json) {
    return TasksResponse(
      tasks: (json['tasks'] as List)
          .map((task) => TaskModel.fromMap(task))
          .toList(),
      filter: FilterModel.fromMap(json['filter']),
    );
  }

  @override
  List<Object?> get props => [tasks, filter];
}
