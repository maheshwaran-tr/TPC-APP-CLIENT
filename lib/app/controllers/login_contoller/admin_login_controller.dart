import 'package:final_tpc_app/app/data/api/admin_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/data/models/admin_model.dart';
import 'package:final_tpc_app/app/ui/pages/admin_pages/drawer/admin_drawer.dart';

import '../../data/api/auth_requests.dart';
import '../../data/models/RequestModels/login_request_model.dart';
import '../../data/models/login_response.dart';
import '../../data/models/user_role_model.dart';
import '../../data/token/token_storage.dart';

class AdminLoginController extends GetxController
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
      duration: const Duration(milliseconds: 800),
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
      LoginRequest loginRequest = LoginRequest(
          username: usernameController.text, password: passwordController.text);
      LoginResponse loginData = await AuthRequests.login(loginRequest);

      UserRole role = loginData.user!.role;

      if (role == UserRole.admin) {
        Admin admin = await AdminRequests.getAdminById(loginData.user!.admin!.adminId.toString());
        await TokenStorage.saveTokens(loginData.accessToken, loginData.refreshToken);
        Get.off(() => AdminDrawerHome(admin: admin));
        return true; // Login successful
      } else {
        showErrorDialog("Access Denied", "Only staff members can login.");
        clearFields();
        return false; // Access denied
      }
    } catch (e) {
      showErrorDialog("Error", "Something went wrong. Please try again.");
      print("Error during login: $e");
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
    if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(username)) {
      showErrorDialog("Validation Error", "Invalid username format.");
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
