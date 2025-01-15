import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/utils/command.dart';
import 'package:frontend/utils/result.dart';
import 'package:logging/logging.dart';

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

  Future<Result> _logout() async {
    return await _authRepository.logout();
  }
}
