import 'package:frontend/data/repositories/auth/auth_repository.dart';
import 'package:frontend/utils/command.dart';
import 'package:frontend/utils/result.dart';

class LogoutViewmodel {
  final AuthRepository _authRepository;

  LogoutViewmodel({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    logout = Command0(_logout);
  }

  late Command0 logout;

  Future<Result> _logout() async {
    return await _authRepository.logout();
  }
}
