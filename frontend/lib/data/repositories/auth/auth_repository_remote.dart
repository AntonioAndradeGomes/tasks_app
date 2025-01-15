import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/data/services/api/auth_api_client.dart';
import 'package:frontend/data/services/api/model/login_response.dart';
import 'package:frontend/data/services/shared_preferences_service.dart';
import 'package:frontend/utils/result.dart';
import 'package:logging/logging.dart';

class AuthRepositoryRemote extends AuthRepository {
  final AuthApiClient _apiClient;
  final SharedPreferencesService _sharedPreferencesService;

  AuthRepositoryRemote({
    required AuthApiClient apiClient,
    required SharedPreferencesService sharedPreferencesService,
  })  : _apiClient = apiClient,
        _sharedPreferencesService = sharedPreferencesService {
    _fetchToken();
  }

  bool? _isAuthenticated;
  String? _authToken;
  final _log = Logger('AuthRepositoryRemote');

  Future<void> _fetchToken() async {
    final result = await _sharedPreferencesService.fetchToken();
    switch (result) {
      case Ok<String?>():
        _authToken = result.value;
        _isAuthenticated = _authToken != null;
      case Error<String?>():
        _log.severe(
          'Failed to fech Token from SharedPreferences',
          result.error,
        );
    }
    notifyListeners();
  }

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _apiClient.login(email, password);
      switch (result) {
        case Ok<LoginResponse>():
          _log.finer('Login successful');
          _isAuthenticated = true;
          _authToken = result.value.token;
          await _sharedPreferencesService.saveToken(result.value.token);
          return const Result.ok(null);
        case Error<LoginResponse>():
          _log.warning('Error logging in: ${result.error}');
          return Result.error(result.error);
      }
    } finally {
      notifyListeners();
    }
  }

  @override
  bool? get isAuthenticated => _isAuthenticated;

  @override
  Future<Result<void>> logout() async {
    _log.info('User logged out');
    try {
      final result = await _sharedPreferencesService.saveToken(null);
      if (result is Error<void>) {
        _log.severe('Error logging out: ${result.error}');
      }

      _authToken = null;
      _isAuthenticated = false;
      return result;
    } finally {
      notifyListeners();
    }
  }
}
