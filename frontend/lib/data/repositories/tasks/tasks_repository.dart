import 'package:flutter/foundation.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/utils/result.dart';

abstract class TasksRepository extends ChangeNotifier {
  List<TaskModel> get tasks;
  Future<Result<List<TaskModel>>> fethcTasks();
  Future<Result<TaskModel>> getMyTaskById(String id);
  Future<Result<TaskModel>> createTask(TaskModel task);
  Future<Result<TaskModel>> updateTask(TaskModel task);
}
