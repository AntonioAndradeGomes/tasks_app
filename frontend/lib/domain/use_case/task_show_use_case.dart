import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/utils/result.dart';
import 'package:logging/logging.dart';

class TaskShowUseCase {
  final _log = Logger('TaskShowUseCase');
  final TasksRepository _repository;

  TaskShowUseCase({
    required TasksRepository repository,
  }) : _repository = repository;

  Future<Result<TaskModel>> call(String? id) async {
    if (id == null) {
      _log.fine('Task id is null');
      return Result.ok(
        TaskModel(
          id: null,
          title: '',
          description: null,
          hexColor: Constants.colors.first,
          userId: null,
        ),
      );
    }
    _log.fine('Task id is $id');
    return _repository.getMyTaskById(id);
  }
}
