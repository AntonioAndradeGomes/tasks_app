import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/domain/dtos/user_registration.dart';

import 'package:logging/logging.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class SignupViewmodel {
  final AuthRepository _repository;
  final _log = Logger('LoginViewModel');

  SignupViewmodel({
    required AuthRepository repository,
  }) : _repository = repository {
    _log.fine('SignupViewmodel created');
    signup = Command1(_signup);
  }

  late Command1<void, UserRegistration> signup;

  AsyncResult<Unit> _signup(UserRegistration credentials) async {
    final result = await _repository.signup(credentials);
    if (result.isError()) {
      _log.warning('Error signing up: ${result.exceptionOrNull()}');
    }
    return result;
  }
}
