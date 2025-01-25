import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/admin_model.dart';
import '../token/token_storage.dart';
import 'urls.dart';

class AdminRequests {

  static Future<Admin> getAdminById(String adminId) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.adminUrl}/$adminId";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return Admin.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Cannot get admin by this id');
      }
    } catch (e) {
      throw Exception('Error in getting admin');
    }
  }
  
}
