import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _secureStorage = FlutterSecureStorage();

  static Future<bool> saveTokens(
      String accessToken, String refreshToken) async {
    try {
      if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
        await _secureStorage.write(key: "access_token", value: accessToken);
        await _secureStorage.write(key: "refresh_token", value: refreshToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<String> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: "refresh_token") ?? "";
    } catch (e) {
      return "";
    }
  }

  static Future<String> getAccessToken() async {
    try {
      return await _secureStorage.read(key: "access_token") ?? "";
    } catch (e) {
      return "";
    }
  }

  static Future<bool> deleteTokens() async {
    try {
      await _secureStorage.delete(key: "access_token");
      await _secureStorage.delete(key: "refresh_token");
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> saveDeviceToken(String? token) async {
    try {
      if (token != null && token.isNotEmpty) {
        await _secureStorage.write(key: 'device_token', value: token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
