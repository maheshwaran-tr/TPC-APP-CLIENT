import 'dart:convert';

import 'package:http/http.dart' as http;
import '../token/token_storage.dart';
import '../models/drive_model.dart';  // Correct model for Drive
import 'urls.dart';

class DriveRequests {

  static Future<List<Drive>> getAllDrives() async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.driveUrl}/";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Drive> drives = jsonData.map((e) => Drive.fromJson(e)).toList();
        return drives;
      } else {
        throw Exception('Failed to load drives');
      }
    } catch (e) {
      throw Exception('Failed to load drives: $e');
    }
  }

  static Future<Drive> getDriveById(String id) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.driveUrl}/$id";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return Drive.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load drive');
      }
    } catch (e) {
      throw Exception('Failed to get drive: $e');
    }
  }

  static Future<Drive> createDrive(Drive drive) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = Urls.driveUrl;
      
      final response = await http.post(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(drive.toJson()));
      if (response.statusCode == 201) {
        return Drive.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create drive');
      }
    } catch (e) {
      throw Exception('Failed to create drive: $e');
    }
  }

  static Future<Drive> updateDrive(Drive drive) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.driveUrl}/${drive.driveId}";  // Replace 'id' with the correct field for the model
      final response = await http.put(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(drive.toJson()));
      if (response.statusCode == 200) {
        return Drive.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update drive');
      }
    } catch (e) {
      throw Exception('Failed to update drive: $e');
    }
  }

  static Future<Drive> deleteDrive(String driveId) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.driveUrl}/$driveId";
      final response = await http.delete(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 204) {
        return Drive.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to delete drive');
      }
    } catch (e) {
      throw Exception('Failed to delete drive: $e');
    }
  }

}