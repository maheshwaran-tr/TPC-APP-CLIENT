import 'dart:convert';

import 'package:final_tpc_app/app/data/models/staff_register_model.dart';
import 'package:http/http.dart' as http;
import '../models/staff_model.dart';
import '../token/token_storage.dart';
import 'urls.dart';

class StaffRequests {
  static Future<List<Staff>> getAllStaffs() async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String url = Urls.staffUrl;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Staff> allStaffs = jsonData.map((e) => Staff.fromJson(e)).toList();
        return allStaffs;
      } else {
        throw Exception('Failed to load staffs');
      }
    } catch (e) {
      throw Exception('Exception Failed to load staffs');
    }
  }

  static Future<Staff> getStaffById(String staffId) async {

    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }
      String url = "${Urls.staffUrl}/$staffId";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return Staff.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load staff');
      }
    } catch (e) {
      throw Exception('Exception Failed to load staff $e');
    }
  }

  static Future<Staff> getStaffByUserId(int userId) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }
      String url = "${Urls.staffUrl}/byUser/$userId";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return Staff.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load staff');
      }
    } catch (e) {
      throw Exception('Exception Failed to load staff');
    }
  }

  static Future<Staff> addStaff(StaffRegisterModel staff) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }
      String endpoint = Urls.authUrl;

      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(staff.toJson()),
      );
      if (response.statusCode == 201) {
        return Staff.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add staff');
      }
    } catch (e) {
      throw Exception('Exception Failed to add staff');
    }
  }

  static Future<Staff> deleteStaff(int staffId) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }
      String deleteStaffUrl = "${Urls.staffUrl}/$staffId";

      final response = await http.delete(
        Uri.parse(deleteStaffUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return Staff.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to delete staff');
      }
    } catch (e) {
      throw Exception('Exception Failed to delete staff');
    }
  }

  static Future<Staff> updateStaff(Staff staff) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }
      String endpoint = "${Urls.staffUrl}/${staff.staffId}";

      final response = await http.put(
        Uri.parse(endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(staff.toJson()),
      );

      if (response.statusCode == 200) {
        return Staff.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update staff');
      }
    } catch (e) {
      throw Exception('Exception Failed to update staff');
    }
  }
}
