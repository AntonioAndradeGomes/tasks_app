import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/utils/result.dart';

abstract class TasksRepository {
  Future<Result<List<TaskModel>>> getMyTasks();
}
