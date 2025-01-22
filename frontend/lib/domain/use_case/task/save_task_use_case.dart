import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/utils/result.dart';

class SaveTaskUseCase {
  final TasksRepository _repository;

  SaveTaskUseCase({
    required TasksRepository repository,
  }) : _repository = repository;

  Future<Result<TaskModel>> call(TaskModel task) async {
    if (task.id != null) {
      return _repository.updateTask(task);
    }
    return _repository.createTask(task);
  }
}
