import 'package:frontend/modules/auth/repositories/auth_repository.dart';
import 'package:frontend/modules/auth/dtos/credentials.dart';
import 'package:frontend/modules/auth/models/login_response.dart';
import 'package:logging/logging.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class LoginViewModel {
  final AuthRepository _repository;
  final _log = Logger('LoginViewModel');

  LoginViewModel({
    required AuthRepository repository,
  }) : _repository = repository {
    _log.fine('LoginViewModel created');
    login = Command1(_login);
  }

  late Command1<void, Credentials> login;

  AsyncResult<LoginResponse> _login(Credentials credentials) {
    return _repository.login(credentials);
  }
}
