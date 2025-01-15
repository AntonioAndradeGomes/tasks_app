import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/utils/command.dart';
import 'package:frontend/utils/result.dart';
import 'package:logging/logging.dart';

class LoginViewModel {
  final AuthRepository _repository;
  final _log = Logger('LoginViewModel');

  LoginViewModel({
    required AuthRepository repository,
  }) : _repository = repository {
    login = Command1<void, (String email, String password)>(_login);
    _log.fine('LofinViewModel created');
  }

  late Command1 login;

  Future<Result<void>> _login((String, String) credentials) async {
    final (email, password) = credentials;
    final result = await _repository.login(email: email, password: password);
    if (result is Error<void>) {
      _log.warning('Error logging in: ${result.error}');
    }
    return result;
  }
}
