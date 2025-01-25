import 'package:final_tpc_app/app/data/api/student_requests.dart';
import 'package:final_tpc_app/app/data/models/RequestModels/login_request_model.dart';
import 'package:final_tpc_app/app/data/models/login_response.dart';
import 'package:final_tpc_app/app/data/models/user_role_model.dart';
import 'package:final_tpc_app/app/ui/pages/student_pages/drawer/student_drawer_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/api/auth_requests.dart';
import '../../data/models/student_model.dart';

class StudentLoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final isNotValidate = false.obs;
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<bool> validateAndLogin() async {
    if (!validateInput(usernameController.text, passwordController.text)) {
      return false; // Validation failed
    }

    isLoading.value = true;
    try {
      print("tryyyyyyyy.........");
      LoginRequest loginRequest = LoginRequest(
        username: usernameController.text,
        password: passwordController.text,
      );
      print(loginRequest.username);
      LoginResponse? loginData = await AuthRequests.login(loginRequest);
      print(loginData.accessToken);

      UserRole role = loginData.user!.role;
      print(role);
      if (role == UserRole.student) {
        Student student = await StudentRequests.getStudentById(loginData.user!.student!.studentId.toString());
        Get.off(() => StudentDrawerHome(student: student));
        return true; // Login successful
      } else {
        showErrorDialog("Access Denied", "Only students can login.");
        clearFields();
        return false; // Access denied
      }
    } catch (e) {
      // Log the exact error for debugging
      print("Login error: $e");
      showErrorDialog("Error", "Something went wrong. Please try again.");
      clearFields();
      return false; // Error occurred
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToForgotPassword() {
    // Uncomment and navigate to the forgot password page
    // Get.to(() => ForgottenPasswordPage());
  }

  void clearFields() {
    usernameController.clear();
    passwordController.clear();
  }

  bool validateInput(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      showErrorDialog("Validation Error", "All fields are required.");
      return false;
    }
    return true;
  }

  void showErrorDialog(String title, String message) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () {
        clearFields();
        Get.back();
      },
      barrierDismissible: false,
    );
  }
}
