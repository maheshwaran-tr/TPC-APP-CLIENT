import 'dart:convert';
import 'dart:io';
import 'package:final_tpc_app/app/data/api/urls.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class FileRequests {
  /// Upload file to the server
  static Future<String?> uploadFile(
      File file, String fileName, String folderContext) async {
        print("Uploading.... $fileName in $folderContext");
    try {
      final uri = Uri.parse("${Urls.fileUrl}/upload/$folderContext/$fileName");
      print(uri);
      final request = http.MultipartRequest("POST", uri);

      // Add the file to the request
      request.files.add(http.MultipartFile(
          'file', file.readAsBytes().asStream(), file.lengthSync(),
          filename: fileName,
          contentType: MediaType(
              'image', 'jpeg'))); // Update content type based on your file

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        print("File uploaded successfully!");
        final responseBody = await response.stream.bytesToString();
        final responseData = json.decode(responseBody);

        final String message = responseData['message'];
        final String fileUrl = responseData['url'];

        print("Message: $message");
        print("Uploaded file URL: $fileUrl");
        return fileUrl;
      } else {
        print("File upload failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error uploading file: $e");
      return null;
    }
  }
}
