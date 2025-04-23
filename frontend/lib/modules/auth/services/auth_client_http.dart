import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/core/services/client_http.dart';
import 'package:frontend/modules/auth/dtos/credentials.dart';
import 'package:frontend/modules/auth/dtos/user_registration.dart';
import 'package:frontend/modules/auth/models/login_response.dart';
import 'package:result_dart/result_dart.dart';

class AuthClientHttp {
  final ClientHttp _clientHttp;
  final String _baseUrl;

  AuthClientHttp({
    required ClientHttp clientHttp,
    String? baseUrl,
  })  : _clientHttp = clientHttp,
        _baseUrl = baseUrl ?? '${Constants.backendUrl}/auth';

  AsyncResult<LoginResponse> login(
    Credentials credentials,
  ) async {
    final response = await _clientHttp.post(
      '$_baseUrl/login',
      data: credentials.toJson(),
    );
    return response.map((response) {
      return LoginResponse.fromJson(response.data);
    });
  }

  AsyncResult<Unit> signup(
    UserRegistration userRegistration,
  ) async {
    final response = await _clientHttp.post(
      '$_baseUrl/signup',
      data: userRegistration.toJson(),
    );
    return response.map((response) => unit);
  }
}
