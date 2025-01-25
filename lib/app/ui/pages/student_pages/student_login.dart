// ignore_for_file: unused_local_variable

import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/utils/screen_utils.dart';
import 'package:final_tpc_app/app/controllers/login_contoller/student_login_controller.dart';
import 'package:flutter/services.dart';

import '../../widgets/loading_progress_design.dart';

class StudentLogin extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final StudentLoginController controller = Get.put(StudentLoginController());

  StudentLogin({super.key});

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtils.getWidth(context);
    double height = ScreenUtils.getHeight(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeController.primaryColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: themeController.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        systemOverlayStyle: themeController.isDarkMode
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        title: Text(
          'Student Login',
          style: TextStyle(
            color: themeController.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: controller.animation,
        builder: (context, child) {
          return Opacity(
            opacity: controller.animation.value,
            child: Transform.translate(
              offset: Offset(0.0, 30 * (1 - controller.animation.value)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Hero(
                        tag: 'student_icon',
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 40 * controller.animation.value,
                          child: Icon(
                            Icons.school,
                            size: 50,
                            color: themeController.tertiaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "STUDENT LOGIN",
                        style: TextStyle(
                          color: themeController.secondaryColor,
                          fontSize: width * 0.07 * controller.animation.value,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Opacity(
                        opacity: 0.6,
                        child: Text(
                          "Login to your account",
                          style: TextStyle(
                            fontSize: width * 0.04 * controller.animation.value,
                            color: themeController.isDarkMode
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: Column(
                              children: <Widget>[
                                makeInput(label: "Username"),
                                makeInput(label: "Password", obscureText: true),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: Obx(() {
                              return ElevatedButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : () async {
                                        FocusScope.of(context).unfocus();
                                        bool sucess = await controller.validateAndLogin();
                                      },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(0),
                                ),
                                child: controller.isLoading.value
                                    ? CustomLoadingWidget(
                                        color: themeController.secondaryColor,
                                        size: 40,
                                      )
                                    : Ink(
                                        decoration: BoxDecoration(
                                          color: themeController.secondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          constraints: BoxConstraints(
                                            minHeight: height * 0.07,
                                            maxWidth: width * 0.50,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: width * 0.045,
                                            ),
                                          ),
                                        ),
                                      ),
                              );
                            }),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: controller.navigateToForgotPassword,
                            child: Text(
                              "Forgotten Password",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.045,
                                color: themeController.isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget makeInput({required String label, bool obscureText = false}) {
    final StudentLoginController controller =
        Get.find<StudentLoginController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: themeController.isDarkMode
                ? Colors.white70
                : themeController.secondaryColor,
          ),
        ),
        const SizedBox(height: 5),
        Obx(() {
          return TextField(
            obscureText: label == "Password"
                ? !controller.isPasswordVisible.value
                : obscureText,
            style: TextStyle(
              color: themeController.isDarkMode ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: themeController.isDarkMode
                        ? Colors.white30
                        : Colors.black12),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: themeController.isDarkMode
                        ? Colors.white30
                        : Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: themeController.isDarkMode
                        ? Colors.blueAccent
                        : Colors.blue),
              ),
              hintText: label,
              hintStyle: TextStyle(
                color: themeController.isDarkMode
                    ? Colors.white60
                    : Colors.black54,
              ),
              suffixIcon: label == "Password"
                  ? IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: themeController.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                      onPressed: () {
                        controller.togglePasswordVisibility();
                      },
                    )
                  : null,
            ),
            controller: label == "Username"
                ? controller.usernameController
                : controller.passwordController,
          );
        }),
        const SizedBox(height: 30),
      ],
    );
  }
}
