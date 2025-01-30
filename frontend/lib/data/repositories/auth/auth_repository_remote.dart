import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/data/services/auth/auth_client_http.dart';
import 'package:frontend/data/services/auth/auth_local_storage.dart';
import 'package:frontend/domain/dtos/credentials.dart';
import 'package:frontend/domain/dtos/user_registration.dart';
import 'package:frontend/domain/models/login_response.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryRemote extends AuthRepository {
  final AuthClientHttp _authClientHttp;
  final AuthLocalStorage _authLocalStorage;

  AuthRepositoryRemote({
    required AuthClientHttp authClientHttp,
    required AuthLocalStorage authLocalStorage,
  })  : _authLocalStorage = authLocalStorage,
        _authClientHttp = authClientHttp {
    _fetchToken();
  }

  bool? _isAuthenticated;
  // ignore: unused_field
  String? _authToken;
  final _log = Logger('AuthRepositoryRemote');

  Future<void> _fetchToken() async {
    final result = await _authLocalStorage.fetchToken();
    result.fold(
      (token) {
        _authToken = token.isEmpty ? null : token;
        _isAuthenticated = token.isNotEmpty;
      },
      (error) => _log.severe(
        'Failed to fech Token from SharedPreferences',
        error,
      ),
    );
    notifyListeners();
  }

  @override
  AsyncResult<LoginResponse> login(Credentials credentials) async {
    final result = await _authClientHttp.login(credentials);
    result.fold(
      (success) {
        _log.info('User logged in successfully');
        _isAuthenticated = true;
        _authToken = success.token;
        _authLocalStorage.saveToken(success.token);
      },
      (error) {
        _log.warning('Error logging in: ${error.toString()}');
      },
    );
    notifyListeners();
    return result;
  }

  @override
  bool? get isAuthenticated => _isAuthenticated;

  @override
  AsyncResult<Unit> logout() async {
    _log.info('User logged out repository');
    final result = await _authLocalStorage.removeToken();
    result.fold(
      (success) {
        _log.info('User logged out successfully');
        _isAuthenticated = false;
        _authToken = null;
      },
      (error) {
        _log.severe(
          'Failed to remove token from SharedPreferences',
          error,
        );
      },
    );
    notifyListeners();
    return result;
  }

  @override
  AsyncResult<Unit> signup(UserRegistration userRegistration) async {
    _log.info('User singup repository');
    final result = await _authClientHttp.signup(userRegistration);
    result.fold(
      (success) {
        _log.info('User signed up successfully');
      },
      (error) {
        _log.warning('Error signing up: ${error.toString()}');
      },
    );
    return result;
  }
}
