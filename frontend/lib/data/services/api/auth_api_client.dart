import 'package:dio/dio.dart';
import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/core/errors/custom_exception.dart';
import 'package:frontend/data/services/api/model/login_response.dart';
import 'package:frontend/domain/models/user_model.dart';
import 'package:frontend/utils/result.dart';
//import 'package:logging/logging.dart';

class AuthApiClient {
  final Dio _dio;
  //final _log = Logger('AuthApiClient');
  AuthApiClient({
    Dio? dio,
  }) : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: '${Constants.backendUrl}/auth',
              ),
            );

  Future<Result<LoginResponse>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 201) {
        return Result.ok(LoginResponse.fromJson(response.data));
      } else {
        return const Result.error(CustomException(message: 'Login failed'));
      }
    } on DioException catch (e) {
      return Result.error(
        CustomException(
          message: e.response?.data['message'] ?? 'Login failed',
          errors: e.response?.data['errors'],
          statusCode: e.response?.statusCode,
          status: e.response?.data['status'],
        ),
      );
    }
  }

  Future<Result<UserModel>> signup(
      String name, String email, String password) async {
    try {
      final response = await _dio.post(
        '/signup',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 201) {
        return Result.ok(UserModel.fromMap(response.data));
      } else {
        return const Result.error(CustomException(message: 'Signup failed'));
      }
    } on DioException catch (e) {
      return Result.error(
        CustomException(
          message: e.response?.data['message'] ?? 'Signup failed',
          errors: e.response?.data['errors'],
          statusCode: e.response?.statusCode,
          status: e.response?.data['status'],
        ),
      );
    }
  }
}
