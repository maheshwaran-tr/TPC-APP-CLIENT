import 'dart:convert';
import 'package:final_tpc_app/app/data/models/RequestModels/login_request_model.dart';
import 'package:http/http.dart' as http;
import '../api/urls.dart';
import '../models/login_response.dart';
import '../token/token_storage.dart';

class AuthRequests {
  static Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      String username = loginRequest.username;
      String password = loginRequest.password;

      if (username.isEmpty || password.isEmpty) {
        throw Exception("Username or password cannot be empty");
      }

      var regBody = {"username": username, "password": password};

      String endpoint = "${Urls.authUrl}/login";

      var response = await http.post(Uri.parse(endpoint),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(responseBody);
        await TokenStorage.saveTokens(
            loginResponse.accessToken, loginResponse.refreshToken);
        return loginResponse;
      } else {
        throw Exception(
            "Login failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("########@@@@@@@@@@@@@@@@@@@@@@@@@@#########333");
      print(e);
      throw Exception("Error during login: $e");
    }
  }

  static Future<LoginResponse> refreshToken() async {
    try {
      final token = await TokenStorage.getRefreshToken();

      if (token.isEmpty) {
        throw Exception("Refresh token is empty");
      }

      String endpoint = "${Urls.authUrl}/refresh-token";

      final response = await http.post(Uri.parse(endpoint),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"refreshToken": token}));

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(responseBody);
        await TokenStorage.saveTokens(
            loginResponse.accessToken, loginResponse.refreshToken);
        return loginResponse;
      } else {
        throw Exception(
            "Refresh token failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error during refresh token: $e");
    }
  }
}
