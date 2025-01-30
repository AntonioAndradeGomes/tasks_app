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

  AsyncResult<List<TaskModel>> getUserTasks(String token) async {
    final response = await _clientHttp.get(
      _baseUrl,
      headers: {
        'x-auth-token': token,
      },
    );

    return response.map((response) => (response.data as List)
        .map((task) => TaskModel.fromMap(task))
        .toList());
  }

  AsyncResult<TaskModel> getUserTaskById(
    String token,
    String taskId,
  ) async {
    final response = await _clientHttp.get(
      _baseUrl,
      headers: {
        'x-auth-token': token,
      },
      queryParameters: {
        'taskId': taskId,
      },
    );
    return response.map((response) => TaskModel.fromMap(response.data));
  }

  AsyncResult<TaskModel> createTask(
    String token,
    TaskDto taskDto,
  ) async {
    final response = await _clientHttp.post(
      _baseUrl,
      headers: {
        'x-auth-token': token,
      },
      data: taskDto.toMap(),
    );
    return response.map((response) => TaskModel.fromMap(response.data));
  }

  AsyncResult<TaskModel> updateTask(
    String token,
    TaskDto taskDto,
  ) async {
    final response = await _clientHttp.put(
      '$_baseUrl/${taskDto.id}',
      headers: {
        'x-auth-token': token,
      },
      data: taskDto.toMap(),
    );
    return response.map((response) => TaskModel.fromMap(response.data));
  }

  AsyncResult<Unit> deleteTask(String token, String taskId) async {
    final response = await _clientHttp.delete(
      '$_baseUrl/$taskId',
      headers: {
        'x-auth-token': token,
      },
    );
    return response.map((response) => unit);
  }
}
