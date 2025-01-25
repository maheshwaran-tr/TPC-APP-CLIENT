import 'dart:convert';

import 'package:final_tpc_app/app/data/models/student_register_model.dart';
import 'package:http/http.dart' as http;
import '../models/student_model.dart';
import '../token/token_storage.dart';
import 'urls.dart';

class StudentRequests {
  static Future<List<Student>> getAllStudents() async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.studentUrl}/";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        List<Student> allStudents =
            jsonData.map((e) => Student.fromJson(e)).toList();

        return allStudents;
      } else {
        throw Exception('Cannot get all students');
      }
    } catch (e) {
      throw Exception('Error in getting all students');
    }
  }

  static Future<Student> getStudentById(String studentId) async {
    try {
      

      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.studentUrl}/$studentId";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      
      if (response.statusCode == 200) {
        return Student.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Cannot get student by this id');
      }
    } catch (e) {
      throw Exception('Error in getting student by id $e');
    }
  }


  static Future<Student> getStudentByUserId(String userId) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.studentUrl}/byUser/$userId";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return Student.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Cannot get student by this user id');
      }
    } catch (e) {
      throw Exception('Error in getting student by user id');
    }
  }

  static Future<Student> getStudentByRollno(String rollno) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.studentUrl}/byRollno/$rollno";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return Student.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Cannot get student by this rollno');
      }
    } catch (e) {
      throw Exception('Error in getting student by rollno');
    }
  }

  static Future<Student> createStudent(StudentRegisterModel student) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.authUrl}/";

      final response = await http.post(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(student.toJson()));

      if (response.statusCode == 200) {
        return Student.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Cannot create student');
      }
    } catch (e) {
      throw Exception('Error in creating student');
    }
  }

  static Future<Student> updateStudent(Student student) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.studentUrl}/${student.studentId}";

      final response = await http.put(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(student.toJson()));

      if (response.statusCode == 200) {
        return Student.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Cannot update student');
      }
    } catch (e) {
      throw Exception('Error in updating student');
    }
  }

  static Future<Student> deleteStudent(String studentId) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.studentUrl}/$studentId";

      final response = await http.delete(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return Student.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Cannot delete student');
      }
    } catch (e) {
      throw Exception('Error in deleting student');
    }
  }

  static Future<List<Student>> getStudentsByDept(String deptId) async {
    try {
      String token = await TokenStorage.getAccessToken();
      if (token.isEmpty) {
        throw Exception('Token is null');
      }
      String endpoint = "${Urls.studentUrl}/byDept/$deptId";
      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        List<Student> students =
            jsonData.map((e) => Student.fromJson(e)).toList();
        return students;
      } else {
        throw Exception('Cannot get students by this department');
      }
    } catch (e) {
      throw Exception('Error in getting students by department');
    }
  }

  static Future<List<Student>> getStudentsByPlacementWilling(
      String placementWilling) async {
    try {
      String token = await TokenStorage.getAccessToken();
      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      if (placementWilling.toLowerCase() != 'yes' && placementWilling.toLowerCase() != 'no') {
        throw Exception('Placement willing should be either yes or no');
      }

      String endpoint =
          "${Urls.studentUrl}/byPlacementWilling/$placementWilling";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        List<Student> students =
            jsonData.map((e) => Student.fromJson(e)).toList();
        return students;
      } else {
        throw Exception('Cannot get students by placement willing');
      }
    } catch (e) {
      throw Exception('Error in getting students by placement willing $e');
    }
  }
}
