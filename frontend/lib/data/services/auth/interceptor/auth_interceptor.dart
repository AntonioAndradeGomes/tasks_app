import 'package:dio/dio.dart';
import 'package:frontend/data/services/auth/auth_local_storage.dart';
import 'package:logging/logging.dart';

class AuthInterceptor extends Interceptor {
  final _log = Logger('AuthInterceptor');
  final AuthLocalStorage _authLocalStorage;

  AuthInterceptor({
    required AuthLocalStorage authLocalStorage,
  }) : _authLocalStorage = authLocalStorage;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    _log.info('${options.method} -> ${options.uri}');
    _log.info('${options.data}');
    _log.info('${options.queryParameters}');
    final requiresAuth = options.extra['requiresAuth'] ?? true;
    if (!requiresAuth) {
      handler.next(options);
      return;
    }
    _log.info('Fetching auth token');
    final token = await _authLocalStorage.fetchToken();

    token.fold(
      (token) {
        if (token.isEmpty) {
          _log.warning('No auth token');
          handler.reject(
            DioException(
              requestOptions: options,
              error: 'No auth token',
              response: Response(
                requestOptions: options,
                statusCode: 401,
                data: {
                  'message': 'No auth token, access denied!',
                  'status': 'unauthorized',
                },
              ),
            ),
          );
        } else {
          options.headers['x-auth-token'] = token;
          handler.next(options);
        }
      },
      (error) {
        _log.warning('No auth token');
        handler.reject(
          DioException(
            requestOptions: options,
            error: 'No auth token',
            response: Response(
              requestOptions: options,
              statusCode: 401,
              data: {
                'message': 'No auth token, access denied!',
                'status': 'unauthorized',
              },
            ),
          ),
        );
      },
    );
  }
}
