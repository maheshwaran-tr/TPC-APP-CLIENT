// Controller File: student_change_password_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentChangePasswordController extends GetxController {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var errorText = ''.obs;
  var isLoading = false.obs;

  void changePassword() async {
    errorText.value = '';

    String currentPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      errorText.value = 'Please fill in all fields';
    } else if (newPassword.length < 8) {
      errorText.value = 'New Password must be at least 8 characters';
    } else if (newPassword != confirmPassword) {
      errorText.value = 'New Password and Confirm Password do not match';
    } else {
      isLoading.value = true;

      await Future.delayed(Duration(seconds: 2));

      isLoading.value = false;

      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      Get.snackbar('Success', 'Password Changed Successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    }
  }
}
