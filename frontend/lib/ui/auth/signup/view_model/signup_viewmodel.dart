import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/utils/command.dart';
import 'package:frontend/utils/result.dart';
import 'package:logging/logging.dart';

class SignupViewmodel {
  final AuthRepository _repository;
  final _log = Logger('LoginViewModel');

  SignupViewmodel({
    required AuthRepository repository,
  }) : _repository = repository {
    _log.fine('SignupViewmodel created');
    signup =
        Command1<void, (String name, String email, String password)>(_signup);
  }

  late Command1 signup;

  Future<Result<void>> _signup((String, String, String) credentials) async {
    final (name, email, password) = credentials;
    final result =
        await _repository.signup(name: name, email: email, password: password);
    if (result is Error<void>) {
      _log.warning('Error signing up: ${result.error}');
    }
    return result;
  }
}
