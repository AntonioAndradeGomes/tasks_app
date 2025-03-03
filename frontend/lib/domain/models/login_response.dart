import 'package:equatable/equatable.dart';
import 'package:frontend/domain/models/user_model.dart';

class LoginResponse extends Equatable {
  final String token;
  final UserModel user;

  const LoginResponse({
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      user: UserModel.fromMap(json['user']),
    );
  }

  @override
  List<Object?> get props => [token, user];
}
