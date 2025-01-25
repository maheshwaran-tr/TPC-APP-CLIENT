import 'user_model.dart';

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final User? user;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      user: json['user'] != null ? User.fromJson(json['user']):null,
    );
  }
}