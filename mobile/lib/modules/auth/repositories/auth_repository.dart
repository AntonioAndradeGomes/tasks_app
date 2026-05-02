import 'package:flutter/foundation.dart';
import 'package:frontend/modules/auth/dtos/credentials.dart';
import 'package:frontend/modules/auth/dtos/user_registration.dart';
import 'package:frontend/modules/auth/models/login_response.dart';
import 'package:result_dart/result_dart.dart';

//AsyncResult = Future<Result<S, E>>

abstract class AuthRepository extends ChangeNotifier {
  bool? get isAuthenticated;
  AsyncResult<LoginResponse> login(Credentials credentials);
  AsyncResult<Unit> logout();
  AsyncResult<Unit> signup(UserRegistration userRegistration);
}
