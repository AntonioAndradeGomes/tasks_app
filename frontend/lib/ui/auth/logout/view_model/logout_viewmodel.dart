import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:logging/logging.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';

class LogoutViewmodel {
  final AuthRepository _authRepository;
  final _log = Logger('LogoutViewmodel');

  LogoutViewmodel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    logout = Command0(_logout);
    _log.fine('LogoutViewmodel created');
  }

  late Command0 logout;

  AsyncResult<Unit> _logout() {
    return _authRepository.logout();
  }
}
