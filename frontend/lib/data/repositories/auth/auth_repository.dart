import 'package:flutter/foundation.dart';
import 'package:frontend/utils/result.dart';

abstract class AuthRepository extends ChangeNotifier {
  bool? get isAuthenticated;
  Future<Result<void>> login({
    required String email,
    required String password,
  });
  Future<Result<void>> logout();
  Future<Result<void>> signup({
    required String name,
    required String email,
    required String password,
  });

  /* Future<Result<UserModel>> getCurrentUser();*/
}
