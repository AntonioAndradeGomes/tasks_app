import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/domain/dtos/task_dto.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:result_dart/result_dart.dart';

class CheckOrUncheckTaskUseCase {
  final TasksRepository _repository;

  CheckOrUncheckTaskUseCase({
    required TasksRepository repository,
  }) : _repository = repository;

  AsyncResult<TaskModel> call(TaskDto task) async {
    if (task.completedAt != null) {
      task.completedAt = null;
      return _repository.updateTask(task);
    } else {
      task.completedAt = DateTime.now();
      return _repository.updateTask(task);
    }
  }
}
