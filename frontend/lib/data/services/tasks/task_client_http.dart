import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/data/services/client_http.dart';
import 'package:frontend/domain/dtos/task_dto.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:result_dart/result_dart.dart';

class TaskClientHttp {
  final ClientHttp _clientHttp;
  final String _baseUrl;

  TaskClientHttp({
    required ClientHttp clientHttp,
    String? baseUrl,
  })  : _clientHttp = clientHttp,
        _baseUrl = baseUrl ?? '${Constants.backendUrl}/tasks';

  AsyncResult<List<TaskModel>> getUserTasks() async {
    final response = await _clientHttp.get(
      _baseUrl,
      requiresAuth: true,
    );

    return response.map((response) => (response.data as List)
        .map((task) => TaskModel.fromMap(task))
        .toList());
  }

  AsyncResult<TaskModel> getUserTaskById(
    String taskId,
  ) async {
    final response = await _clientHttp.get(
      _baseUrl,
      requiresAuth: true,
      queryParameters: {
        'taskId': taskId,
      },
    );
    return response.map((response) => TaskModel.fromMap(response.data));
  }

  AsyncResult<TaskModel> createTask(
    TaskDto taskDto,
  ) async {
    final response = await _clientHttp.post(
      _baseUrl,
      requiresAuth: true,
      data: taskDto.toMap(),
    );
    return response.map((response) => TaskModel.fromMap(response.data));
  }

  AsyncResult<TaskModel> updateTask(
    TaskDto taskDto,
  ) async {
    final response = await _clientHttp.put(
      '$_baseUrl/${taskDto.id}',
      requiresAuth: true,
      data: taskDto.toMap(),
    );
    return response.map((response) => TaskModel.fromMap(response.data));
  }

  AsyncResult<Unit> deleteTask(String taskId) async {
    final response = await _clientHttp.delete(
      '$_baseUrl/$taskId',
      requiresAuth: true,
    );
    return response.map((response) => unit);
  }
}
