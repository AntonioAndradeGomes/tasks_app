import 'package:frontend/data/repositories/tasks/tasks_repository.dart';
import 'package:frontend/data/services/api/tasks_api_client.dart';
import 'package:frontend/data/services/shared_preferences_service.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/utils/result.dart';
import 'package:logging/logging.dart';

class TasksRepositoryRemote extends TasksRepository {
  final TasksApiClient _apiClient;
  final SharedPreferencesService _sharedPreferencesService;

  TasksRepositoryRemote({
    required TasksApiClient apiClient,
    required SharedPreferencesService sharedPreferencesService,
  })  : _apiClient = apiClient,
        _sharedPreferencesService = sharedPreferencesService;

  final _log = Logger('TasksRepositoryRemote');
  List<TaskModel> _tasks = [];

  @override
  Future<Result<TaskModel>> getMyTaskById(String id) async {
    final token = await _sharedPreferencesService.fetchToken();
    switch (token) {
      case Ok<String?>():
        final result = await _apiClient.getTaskUserTaskById(token.value!, id);
        switch (result) {
          case Ok<TaskModel>():
            return Result.ok(result.value);
          case Error<TaskModel>():
            _log.severe('Failed to get tasks', result.error);
            return Result.error(result.error);
        }
      case Error<String?>():
        _log.severe('Failed to get token', token.error);
        return Result.error(token.error);
    }
  }

  @override
  Future<Result<TaskModel>> createTask(TaskModel task) async {
    final token = await _sharedPreferencesService.fetchToken();
    switch (token) {
      case Ok<String?>():
        final result = await _apiClient.createTask(token.value!, task);
        switch (result) {
          case Ok<TaskModel>():
            _log.finer('Successfully created task');
            _tasks.insert(0, result.value);
            notifyListeners();
            return Result.ok(result.value);
          case Error<TaskModel>():
            _log.severe('Failed to create task', result.error);
            return Result.error(result.error);
        }
      case Error<String?>():
        _log.severe('Failed to get token', token.error);
        return Result.error(token.error);
    }
  }

  @override
  Future<Result<TaskModel>> updateTask(TaskModel task) async {
    final token = await _sharedPreferencesService.fetchToken();
    switch (token) {
      case Ok<String?>():
        final result = await _apiClient.updateTask(token.value!, task);
        switch (result) {
          case Ok<TaskModel>():
            final index = _tasks.indexWhere((t) => t.id == task.id);
            if (index != -1) {
              _tasks[index] = result.value; // Atualiza a tarefa
            } else {
              _tasks.insert(0, result.value);
            }
            _log.finer('Successfully updated task');
            notifyListeners(); // Notifica os ouvintes sobre a alteração
            return Result.ok(result.value);
          case Error<TaskModel>():
            _log.severe('Failed to update task', result.error);
            return Result.error(result.error);
        }
      case Error<String?>():
        _log.severe('Failed to get token', token.error);
        return Result.error(token.error);
    }
  }

  @override
  Future<Result<List<TaskModel>>> fethcTasks() async {
    final tokenResult = await _sharedPreferencesService.fetchToken();
    switch (tokenResult) {
      case Ok<String?>():
        final token = tokenResult.value;
        if (token == null) {
          _log.severe('Token is null');
          _tasks.clear();
          notifyListeners();
          return Result.error(Exception('Token is null'));
        }
        final result = await _apiClient.getTasksUserTasks(token);
        switch (result) {
          case Ok<List<TaskModel>>():
            _tasks = result.value;
            _log.finer("Successfully fetched tasks");
          case Error<List<TaskModel>>():
            _log.severe('Failed to fetch tasks', result.error);
        }
        notifyListeners();
        return result;
      case Error<String?>():
        _log.severe('Failed to get token', tokenResult.error);
        _tasks.clear();
        notifyListeners();
        return Result.error(tokenResult.error);
    }
  }

  @override
  List<TaskModel> get tasks => _tasks;
}
