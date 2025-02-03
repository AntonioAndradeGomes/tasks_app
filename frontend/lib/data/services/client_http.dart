import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:frontend/data/exceptions/http_exception.dart';
import 'package:frontend/data/exceptions/http_unauthorized_exception.dart';
import 'package:frontend/data/services/auth/interceptor/auth_interceptor.dart';
import 'package:result_dart/result_dart.dart';

class ClientHttp {
  final Dio _dio;

  ClientHttp({
    required Dio dio,
    required AuthInterceptor authInterceptor,
  }) : _dio = dio {
    _dio.interceptors.add(authInterceptor);
  }

  AsyncResult<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool requiresAuth = false,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          extra: {'requiresAuth': requiresAuth},
        ),
      );
      return Success(response);
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 401) {
        return Failure(
          HttpUnauthorizedException(
            e.response?.data['message'] ?? 'No auth token, access denied!',
            s,
          ),
        );
      }
      return Failure(
        HttpException(
          e.response?.data['message'] ?? 'Get failed',
          errors: e.response?.data['errors'],
          statusCode: e.response?.statusCode,
          status: e.response?.data['status'],
          s,
        ),
      );
    }
  }

  AsyncResult<Response> post(
    String url, {
    Map<String, dynamic>? headers,
    required Map<String, dynamic> data,
    bool requiresAuth = false,
  }) async {
    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: headers,
          extra: {'requiresAuth': requiresAuth},
        ),
        data: data,
      );
      return Success(response);
    } on DioException catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      if (e.response?.statusCode == 401) {
        return Failure(
          HttpUnauthorizedException(
            e.response?.data['message'] ?? 'No auth token, access denied!',
            s,
          ),
        );
      }
      return Failure(
        HttpException(
          e.response?.data['message'] ?? 'Post failed',
          s,
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
    bool requiresAuth = false,
  }) async {
    try {
      final response = await _dio.put(
        url,
        options: Options(
          headers: headers,
          extra: {'requiresAuth': requiresAuth},
        ),
        data: data,
      );
      return Success(response);
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 401) {
        return Failure(
          HttpUnauthorizedException(
              e.response?.data['message'] ?? 'No auth token, access denied!',
              s),
        );
      }
      return Failure(
        HttpException(
          e.response?.data['message'] ?? 'Put failed',
          s,
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
    bool requiresAuth = false,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        options: Options(
          headers: headers,
          extra: {'requiresAuth': requiresAuth},
        ),
      );
      return Success(response);
    } on DioException catch (e, s) {
      if (e.response?.statusCode == 401) {
        return Failure(
          HttpUnauthorizedException(
            e.response?.data['message'] ?? 'No auth token, access denied!',
            s,
          ),
        );
      }
      return Failure(
        HttpException(
          e.response?.data['message'] ?? 'Delete failed',
          s,
          errors: e.response?.data['errors'],
          statusCode: e.response?.statusCode,
          status: e.response?.data['status'],
        ),
      );
    }
  }
}
