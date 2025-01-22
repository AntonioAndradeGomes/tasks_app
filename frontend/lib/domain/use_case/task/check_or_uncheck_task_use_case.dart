import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/utils/result.dart';

class CheckOrUncheckTaskUseCase {
  final TasksRepository _repository;

  CheckOrUncheckTaskUseCase({
    required TasksRepository repository,
  }) : _repository = repository;

  Future<Result<TaskModel>> call(TaskModel task) async {
    if (task.completedAt != null) {
      task.completedAt = null;
      return _repository.updateTask(task);
    } else {
      task.completedAt = DateTime.now();

      return _repository.updateTask(task);
    }
  }
}
