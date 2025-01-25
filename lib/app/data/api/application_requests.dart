import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/RequestModels/application_request_model.dart';
import '../models/application_model.dart';
import '../models/error_model.dart';
import '../token/token_storage.dart';
import 'urls.dart';

class ApplicationRequests {

  static Future<List<Application>> getAllApplications() async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.applicationUrl}/";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Application> applications =
            jsonData.map((e) => Application.fromJson(e)).toList();
        return applications;
      } else {
        throw Exception('Failed to load applications');
      }
    } catch (e) {
      throw Exception('Failed to load applications');
    }
  }

  static Future<Application> getApplicationById(String id) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.applicationUrl}/$id";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return Application.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load applications');
      }
    } catch (e) {
      throw Exception('Failed to get application $e');
    }
  }

  static Future<String?> createApplication(ApplicationRequest application) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.applicationUrl}/apply";
      
      final response = await http.post(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(application.toJson()));

      if (response.statusCode == 201) {
        return "Success";
      } else {
        ErrorModel err = ErrorModel.fromJson(jsonDecode(response.body));
        return err.message;
      }
    } catch (e) {
      print("Failed $e");
      throw Exception('Failed to create application $e');
    }
  }

  static Future<Application> updateApplication(Application application) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.applicationUrl}/${application.applicationId}";
      final response = await http.put(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(application.toJson()));
      if (response.statusCode == 200) {
        return Application.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update application');
      }
    } catch (e) {
      throw Exception('Failed to update application $e');
    }
  }

  static Future<Application> deleteApplication(String applicationId) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }
      String endpoint = "${Urls.applicationUrl}/$applicationId";
      final response = await http.delete(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 204) {
        return Application.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to delete application');
      }
    } catch (e) {
      throw Exception('Failed to delete application $e');
    }
  }

}