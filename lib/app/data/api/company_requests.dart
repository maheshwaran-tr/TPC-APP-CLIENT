import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/company_model.dart';
import '../token/token_storage.dart';
import 'urls.dart';

class CompanyRequests {
  
  static Future<List<Company>> getAllCompanies() async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.companyUrl}/";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Company> companies =
            jsonData.map((e) => Company.fromJson(e)).toList();
        return companies;
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (e) {
      throw Exception('Failed to load companies: $e');
    }
  }

  static Future<Company> getCompanyById(int id) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.companyUrl}/$id";

      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return Company.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load company');
      }
    } catch (e) {
      throw Exception('Failed to get company: $e');
    }
  }

  static Future<Company> createCompany(Company company) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = Urls.companyUrl;
      final response = await http.post(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(company.toJson()));
      if (response.statusCode == 201) {
        return Company.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create company');
      }
    } catch (e) {
      throw Exception('Failed to create company: $e');
    }
  }

  static Future<Company> updateCompany(Company company) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.companyUrl}/${company.companyId}";
      final response = await http.put(Uri.parse(endpoint),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(company.toJson()));
      if (response.statusCode == 200) {
        return Company.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update company');
      }
    } catch (e) {
      throw Exception('Failed to update company: $e');
    }
  }

  static Future<Company> deleteCompany(String companyId) async {
    try {
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }

      String endpoint = "${Urls.companyUrl}/$companyId";
      final response = await http.delete(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 204) {
        return Company.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to delete company');
      }
    } catch (e) {
      throw Exception('Failed to delete company: $e');
    }
  }

}