import 'package:frontend/modules/tasks/repositories/tasks/tasks_repository.dart';
import 'package:frontend/modules/tasks/models/task_model.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

class TaskShowUseCase {
  final _log = Logger('TaskShowUseCase');
  final TasksRepository _repository;

  TaskShowUseCase({
    required TasksRepository repository,
  }) : _repository = repository;

  AsyncResult<TaskModel> call(String? id) async {
    if (id == null) {
      _log.fine('Task id is null');
      return Success(
        TaskModel(
          title: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    }
    _log.fine('Task id is $id');
    return _repository.getMyTaskById(id);
  }
}
