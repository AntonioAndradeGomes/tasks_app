import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/data/services/tasks/task_client_http.dart';
import 'package:frontend/domain/dtos/task_dto.dart';
import 'package:frontend/domain/models/filter_model.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

class TasksRepositoryRemote extends TasksRepository {
  final TaskClientHttp _taskClientHttp;

  TasksRepositoryRemote({
    required TaskClientHttp taskClientHttp,
  }) : _taskClientHttp = taskClientHttp;

  final _log = Logger('TasksRepositoryRemote');
  final List<TaskModel> _tasks = [];
  FilterModel _filter = FilterModel.empty();

  @override
  List<TaskModel> get tasks => _tasks;

  @override
  AsyncResult<TaskModel> createTask(TaskDto task) async {
    final result = await _taskClientHttp.createTask(task);
    return result.fold(
      (task) {
        _log.finer('Successfully created task');
        _tasks.insert(0, task);
        notifyListeners();
        return Success(task);
      },
      (error) {
        _log.severe('Failed to create task', error);
        return Failure(error);
      },
    );
  }

  @override
  AsyncResult<Unit> deleteTask(String id) async {
    final result = await _taskClientHttp.deleteTask(id);
    return result.fold(
      (_) {
        _log.finer('Successfully deleted task');
        _tasks.removeWhere((task) => task.id == id);
        notifyListeners();
        return const Success(unit);
      },
      (error) {
        _log.severe('Failed to delete task', error);
        return Failure(error);
      },
    );
  }

  @override
  AsyncResult<List<TaskModel>> fetchTasks(FilterModel filter) async {
    _filter = filter;
    _log.finer('Searching for tasks');
    final result = await _taskClientHttp.getUserTasks(filter);
    return result.fold(
      (result) {
        _log.finer('Tasks successfully searched');
        _tasks.clear();
        _tasks.addAll(result);
        notifyListeners();
        return Success(result);
      },
      (error) {
        _log.severe('Failed to search for tasks', error);
        _tasks.clear();
        notifyListeners();
        return Failure(error);
      },
    );
  }

  @override
  AsyncResult<TaskModel> getMyTaskById(String id) async {
    final result = await _taskClientHttp.getUserTaskById(id);
    return result.fold(
      (task) {
        _log.finer('Successfully got task');
        return Success(task);
      },
      (error) {
        _log.severe('Failed to get task', error);
        return Failure(error);
      },
    );
  }

  @override
  AsyncResult<TaskModel> updateTask(TaskDto task) async {
    final result = await _taskClientHttp.updateTask(task);
    return result.fold(
      (task) {
        _log.finer('Successfully updated task');
        final index = _tasks.indexWhere((element) => element.id == task.id);
        if (index != -1) {
          _tasks[index] = task;
        } else {
          _tasks.insert(0, task);
        }
        notifyListeners();
        return Success(task);
      },
      (error) {
        _log.severe('Failed to update task', error);
        return Failure(error);
      },
    );
  }
}
