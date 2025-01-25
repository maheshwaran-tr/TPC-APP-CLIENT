import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/status_model.dart';  // Correct model for Status
import '../token/token_storage.dart';
import 'urls.dart';

class StatusRequests {

  static Future<List<Status>> getAllStatuses() async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.statusUrl}/";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Status> statuses = jsonData.map((e) => Status.fromJson(e)).toList();
        return statuses;
      } else {
        throw Exception('Failed to load statuses');
      }
    } catch (e) {
      throw Exception('Failed to load statuses: $e');
    }
  }

  static Future<Status> getStatusById(int id) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.statusUrl}/$id";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return Status.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load status');
      }
    } catch (e) {
      throw Exception('Failed to get status: $e');
    }
  }

  static Future<Status> createStatus(Status status) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = Urls.statusUrl;
      
      final response = await http.post(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(status.toJson()));
      if (response.statusCode == 201) {
        return Status.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create status');
      }
    } catch (e) {
      throw Exception('Failed to create status: $e');
    }
  }

  static Future<Status> updateStatus(Status status) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.statusUrl}/${status.statusId}";  // Replace 'statusId' with the correct field for the model
      final response = await http.put(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(status.toJson()));
      if (response.statusCode == 200) {
        return Status.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update status');
      }
    } catch (e) {
      throw Exception('Failed to update status: $e');
    }
  }

  static Future<Status> deleteStatus(String statusId) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.statusUrl}/$statusId";
      final response = await http.delete(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 204) {
        return Status.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to delete status');
      }
    } catch (e) {
      throw Exception('Failed to delete status: $e');
    }
  }

}