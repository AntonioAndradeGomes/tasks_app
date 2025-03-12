import 'package:flutter/foundation.dart';
import 'package:frontend/domain/dtos/task_dto.dart';
import 'package:frontend/domain/models/filter_model.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class TasksRepository extends ChangeNotifier {
  List<TaskModel> get tasks;
  AsyncResult<List<TaskModel>> fetchTasks(FilterModel filter);
  AsyncResult<TaskModel> getMyTaskById(String id);
  AsyncResult<TaskModel> createTask(TaskDto task);
  AsyncResult<TaskModel> updateTask(TaskDto task);
  AsyncResult<Unit> deleteTask(String id);
}
