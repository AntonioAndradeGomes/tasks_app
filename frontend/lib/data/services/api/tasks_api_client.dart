import 'package:dio/dio.dart';
import 'package:frontend/core/errors/custom_exception.dart';
import 'package:frontend/domain/models/task_model.dart';
import 'package:frontend/utils/result.dart';

class TasksApiClient {
  final Dio _dio;
  TasksApiClient({
    Dio? dio,
  }) : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'http://localhost:8000/tasks',
              ),
            );

  Future<Result<List<TaskModel>>> getTasksUserTasks(String token) async {
    try {
      final response = await _dio.get(
        '/',
        options: Options(
          headers: {
            'x-auth-token': token,
          },
        ),
      );
      if (response.statusCode == 200) {
        return Result.ok(
          (response.data as List).map((e) => TaskModel.fromMap(e)).toList(),
        );
      } else {
        return const Result.error(
          CustomException(
            message: 'Get tasks failed',
          ),
        );
      }
    } on DioException catch (e) {
      return Result.error(
        CustomException(
          message: e.response?.data['message'] ?? 'Get tasks failed',
          errors: e.response?.data['errors'],
          statusCode: e.response?.statusCode,
          status: e.response?.data['status'],
        ),
      );
    }
  }

  Future<Result<TaskModel>> getTaskUserTaskById(
    String token,
    String taskId,
  ) async {
    try {
      final response = await _dio.get(
        '/',
        options: Options(
          headers: {
            'x-auth-token': token,
          },
        ),
        queryParameters: {
          'taskId': taskId,
        },
      );
      if (response.statusCode == 200) {
        return Result.ok(TaskModel.fromMap(response.data));
      } else {
        return const Result.error(
          CustomException(
            message: 'Get tasks failed',
          ),
        );
      }
    } on DioException catch (e) {
      return Result.error(
        CustomException(
          message: e.response?.data['message'] ?? 'Get tasks failed',
          errors: e.response?.data['errors'],
          statusCode: e.response?.statusCode,
          status: e.response?.data['status'],
        ),
      );
    }
  }
}
