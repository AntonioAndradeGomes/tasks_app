import 'package:flutter/foundation.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class TasksRepository extends ChangeNotifier {
  List<TaskModel> get tasks;
  AsyncResult<List<TaskModel>> fetchTasks();
  AsyncResult<TaskModel> getMyTaskById(String id);
  AsyncResult<TaskModel> createTask(TaskModel task);
  AsyncResult<TaskModel> updateTask(TaskModel task);
  AsyncResult<Unit> deleteTask(String id);
}
