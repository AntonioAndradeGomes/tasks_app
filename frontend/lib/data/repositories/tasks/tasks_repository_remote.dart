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

  @override
  Future<Result<List<TaskModel>>> getMyTasks() async {
    final token = await _sharedPreferencesService.fetchToken();
    switch (token) {
      case Ok<String?>():
        final result = await _apiClient.getTasksUserTasks(token.value!);
        switch (result) {
          case Ok<List<TaskModel>>():
            return Result.ok(result.value);
          case Error<List<TaskModel>>():
            _log.severe('Failed to get tasks', result.error);
            return Result.error(result.error);
        }
      case Error<String?>():
        _log.severe('Failed to get token', token.error);
        return Result.error(token.error);
    }
  }

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
}
