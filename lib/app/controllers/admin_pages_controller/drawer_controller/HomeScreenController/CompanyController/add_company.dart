import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../../data/api/file_requests.dart';

class AddCompanyController extends GetxController {
  var fullName = ''.obs;
  var shortName = ''.obs;
  var image = Rxn<File>();

  final _picker = ImagePicker();

  // Method to pick an image
  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  // Method to handle form submission
  Future<void> addCompany() async {
    if (fullName.isNotEmpty && shortName.isNotEmpty) {
      // Add company logic here
      String? fileurl =
          await FileRequests.uploadFile(image.value!,shortName.value, "company-logo");
      print(fileurl);
      // Example: Show success snackbar
      Get.snackbar('Success', 'Company added successfully!');

      // Clear form fields
    
      fullName.value = '';
      shortName.value = '';
      image.value = null;
    } else {
      Get.snackbar('Error', 'Please fill all the fields!');
    }
  }
}
