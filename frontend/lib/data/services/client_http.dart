import 'package:dio/dio.dart';
import 'package:frontend/data/exceptions/http_exception.dart';
import 'package:result_dart/result_dart.dart';

class ClientHttp {
  final Dio _dio;

  ClientHttp({required Dio dio}) : _dio = dio;

  AsyncResult<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(
        HttpException(
          e.response?.data['message'] ?? 'Get failed',
          errors: e.response?.data['errors'],
          statusCode: e.response?.statusCode,
          status: e.response?.data['status'],
        ),
      );
    }
  }

  AsyncResult<Response> post(
    String url, {
    Map<String, dynamic>? headers,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: headers,
        ),
        data: data,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(
        HttpException(
          e.response?.data['message'] ?? 'Post failed',
          errors: e.response?.data['errors'],
          statusCode: e.response?.statusCode,
          status: e.response?.data['status'],
        ),
      );
    }
  }

  AsyncResult<Response> put(
    String url, {
    Map<String, dynamic>? headers,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _dio.put(
        url,
        options: Options(
          headers: headers,
        ),
        data: data,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(
        HttpException(
          e.response?.data['message'] ?? 'Put failed',
          errors: e.response?.data['errors'],
          statusCode: e.response?.statusCode,
          status: e.response?.data['status'],
        ),
      );
    }
  }

  AsyncResult<Response> delete(
    String url, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        options: Options(
          headers: headers,
        ),
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(
        HttpException(
          e.response?.data['message'] ?? 'Delete failed',
          errors: e.response?.data['errors'],
          statusCode: e.response?.statusCode,
          status: e.response?.data['status'],
        ),
      );
    }
  }
}
