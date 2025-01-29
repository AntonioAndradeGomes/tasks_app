import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/domain/dtos/credentials.dart';
import 'package:frontend/domain/models/login_response.dart';
import 'package:logging/logging.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class LoginViewModel {
  final AuthRepository _repository;
  final _log = Logger('LoginViewModel');

  LoginViewModel({
    required AuthRepository repository,
  }) : _repository = repository {
    _log.fine('LofinViewModel created');
    login = Command1(_login);
  }

  late Command1<void, Credentials> login;

  AsyncResult<LoginResponse> _login(Credentials credentials) {
    return _repository.login(credentials);
  }
}
