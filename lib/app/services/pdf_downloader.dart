// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class DownloadResponse {
  bool success;
  String? filePath;
  String message;
  DownloadResponse(this.success, this.filePath, this.message);
}

Future<DownloadResponse> downloadPdf() async {
  PermissionStatus status = await Permission.photos.request();
  if (status.isGranted) {
    try {
      // Send HTTP GET request to your API
      final response = await http.get(Uri.parse('http://192.168.1.7:5500/pdf'));

      if (response.statusCode == 200) {
        // Get the directory to store the file
        // final directory = await getApplicationDocumentsDirectory();
        final filePath = '/storage/emulated/0/Documents/student_report.pdf';
        final file = File(filePath);

        // Write the received data to the file
        await file.writeAsBytes(response.bodyBytes);

        return DownloadResponse(true, filePath, "PDF Downloaded to $filePath");
      } else {
        return DownloadResponse(
            false, null, "Failed to download PDF: ${response.statusCode}");
      }
    } catch (e) {
      return DownloadResponse(false, null, "Error downloading pdf $e");
    }
  } else {
    return DownloadResponse(false, null, "Storage permission denied");
  }
}