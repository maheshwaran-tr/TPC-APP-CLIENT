import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/department_model.dart';
import '../token/token_storage.dart';
import 'urls.dart';

class DepartmentRequests {

  static Future<List<Department>> getAllDepartments() async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.departmentUrl}/";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Department> departments =
            jsonData.map((e) => Department.fromJson(e)).toList();
        return departments;
      } else {
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      throw Exception('Failed to load departments: $e');
    }
  }

  static Future<Department> getDepartmentById(int id) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.departmentUrl}/$id";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return Department.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load department');
      }
    } catch (e) {
      throw Exception('Failed to get department: $e');
    }
  }

  static Future<Department> createDepartment(Department department) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = Urls.departmentUrl;
      
      final response = await http.post(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(department.toJson()));
      if (response.statusCode == 201) {
        return Department.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create department');
      }
    } catch (e) {
      throw Exception('Failed to create department: $e');
    }
  }

  static Future<Department> updateDepartment(Department department) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.departmentUrl}/${department.deptId}";
      final response = await http.put(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(department.toJson()));
      if (response.statusCode == 200) {
        return Department.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update department');
      }
    } catch (e) {
      throw Exception('Failed to update department: $e');
    }
  }

  static Future<Department> deleteDepartment(String departmentId) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.departmentUrl}/$departmentId";
      final response = await http.delete(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 204) {
        return Department.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to delete department');
      }
    } catch (e) {
      throw Exception('Failed to delete department: $e');
    }
  }

}