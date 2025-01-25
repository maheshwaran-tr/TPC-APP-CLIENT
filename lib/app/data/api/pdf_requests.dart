import '../token/token_storage.dart';
import 'urls.dart';
import 'package:http/http.dart' as http;

class PdfRequests {
  static Future<bool> downloadPdf() async {
    try {
      String endpoint = Urls.pdfUrl;
      String token = await TokenStorage.getAccessToken();

      if (token.isEmpty) {
        throw Exception('Token is null');
      }
      final response = await http.get(Uri.parse(endpoint), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Error in getting admin');
    }
  }
}
