import 'package:final_tpc_app/app/data/api/staff_requests.dart';
import 'package:final_tpc_app/app/data/token/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/ui/pages/staff_pages/drawer/staff_drawer.dart';

import '../../data/api/auth_requests.dart';
import '../../data/models/RequestModels/login_request_model.dart';
import '../../data/models/login_response.dart';
import '../../data/models/staff_model.dart';
import '../../data/models/user_role_model.dart';

class StaffLoginController extends GetxController
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

      String accessToken = loginData.accessToken;
      String refreshToken = loginData.refreshToken;

      await TokenStorage.saveTokens(accessToken, refreshToken);

      UserRole role = loginData.user!.role;

      if (role == UserRole.staff) {
        Staff staff = await StaffRequests.getStaffById(loginData.user!.staff!.staffId.toString());
        await TokenStorage.saveTokens(loginData.accessToken, loginData.refreshToken);
        Get.off(() => StaffDrawerHome(staff: staff));
        return true; // Login successful
      } else {
        showErrorDialog("Access Denied", "Only staff members can login.");
        clearFields();
        return false; // Access denied
      }
    } catch (e) {
      showErrorDialog("Error", "Something went wrong. Please try again.");
      clearFields();
      return false; // Error occurred
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToForgotPassword() {
    // Add navigation to your ForgottenPasswordPage
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
