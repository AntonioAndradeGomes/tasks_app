import 'package:frontend/core/constants/constants.dart';
import 'package:frontend/data/services/client_http.dart';
import 'package:frontend/domain/dtos/credentials.dart';
import 'package:frontend/domain/dtos/user_registration.dart';
import 'package:frontend/domain/models/login_response.dart';
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
