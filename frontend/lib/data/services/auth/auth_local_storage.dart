import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/data/services/local_storage_service.dart';
import 'package:result_dart/result_dart.dart';

class AuthLocalStorage {
  final LocalStorageService _localStorageService;

  AuthLocalStorage({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  AsyncResult<String> fetchToken() => _localStorageService.getData(
        Constants.localStorageTokenKey,
      );

  AsyncResult<void> saveToken(String token) => _localStorageService.saveData(
        Constants.localStorageTokenKey,
        token,
      );

  AsyncResult<Unit> removeToken() => _localStorageService.removeData(
        Constants.localStorageTokenKey,
      );
}
