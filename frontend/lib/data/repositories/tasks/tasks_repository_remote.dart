import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/data/services/auth/auth_local_storage.dart';
import 'package:frontend/data/services/tasks/task_client_http.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

class TasksRepositoryRemote extends TasksRepository {
  final TaskClientHttp _taskClientHttp;
  final AuthLocalStorage _authLocalStorage;

  TasksRepositoryRemote({
    required TaskClientHttp taskClientHttp,
    required AuthLocalStorage authLocalStorage,
  })  : _taskClientHttp = taskClientHttp,
        _authLocalStorage = authLocalStorage;

  final _log = Logger('TasksRepositoryRemote');
  List<TaskModel> _tasks = [];

  @override
  List<TaskModel> get tasks => _tasks;

  @override
  AsyncResult<TaskModel> createTask(TaskModel task) async {
    final token = await _authLocalStorage.fetchToken();
    return token.fold(
      (token) async {
        final result = await _taskClientHttp.createTask(token, task);
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
      },
      (error) async {
        _log.severe('Failed to get token', error);
        return Failure(error);
      },
    );
  }

  @override
  AsyncResult<Unit> deleteTask(String id) async {
    final token = await _authLocalStorage.fetchToken();
    return token.fold(
      (token) async {
        final result = await _taskClientHttp.deleteTask(token, id);
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
      },
      (error) async {
        _log.severe('Failed to get token', error);
        return Failure(error);
      },
    );
  }

  @override
  AsyncResult<List<TaskModel>> fetchTasks() async {
    final token = await _authLocalStorage.fetchToken();
    return token.fold(
      (token) async {
        _log.finer('Searching for tasks');
        final result = await _taskClientHttp.getUserTasks(token);
        return result.fold(
          (list) {
            _log.finer('Tasks successfully searched');
            _tasks = list;
            notifyListeners();
            return Success(list);
          },
          (error) {
            _log.severe('Failed to search for tasks', error);
            _tasks.clear();
            notifyListeners();
            return Failure(error);
          },
        );
      },
      (error) async {
        _log.severe('Failed to get token', error);
        _tasks.clear();
        notifyListeners();
        return Failure(error);
      },
    );
  }

  @override
  AsyncResult<TaskModel> getMyTaskById(String id) async {
    final token = await _authLocalStorage.fetchToken();
    return token.fold(
      (token) async {
        final result = await _taskClientHttp.getUserTaskById(token, id);
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
      },
      (error) async {
        _log.severe('Failed to get token', error);
        return Failure(error);
      },
    );
  }

  @override
  AsyncResult<TaskModel> updateTask(TaskModel task) async {
    final token = await _authLocalStorage.fetchToken();
    return token.fold(
      (token) async {
        final result = await _taskClientHttp.updateTask(token, task);
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
      },
      (error) {
        _log.severe('Failed to get token', error);
        return Failure(error);
      },
    );
  }
}
