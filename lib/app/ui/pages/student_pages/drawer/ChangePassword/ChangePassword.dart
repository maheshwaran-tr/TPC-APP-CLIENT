import 'package:final_tpc_app/app/controllers/student_pages_controller/ChangePasswordController/ChangePasswordController.dart';
import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/data/models/student_model.dart';
import 'package:final_tpc_app/app/ui/pages/student_pages/drawer/student_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class StudentChangePasswordPage extends StatefulWidget {
  final Student student; // Add the student field

  const StudentChangePasswordPage({super.key, required this.student});

  @override
  State<StudentChangePasswordPage> createState() =>
      _StudentChangePasswordPageState();
}

class _StudentChangePasswordPageState extends State<StudentChangePasswordPage> {
  final _controller = Get.put(StudentChangePasswordController());
  final _drawerController = ZoomDrawerController();
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ZoomDrawer(
          controller: _drawerController,
          style: DrawerStyle.defaultStyle,
          menuScreen: MenuPage(
            student: widget.student,
            selectedIndex: 2,
          ),
          mainScreen: buildMainScreen(context),
          borderRadius: 25.0,
          angle: 0,
          // Adjust the angle for a more dynamic appearance
          mainScreenScale: 0.2,
          // Adjust the scale for the main screen
          slideWidth: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }

  Widget buildMainScreen(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor:
            themeController.primaryColor, // Apply theme dynamically
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          _drawerController.toggle!(); // Open the drawer
                        },
                        icon: Icon(
                          Icons.menu_open, // Menu icon to open the drawer
                          size: 30,
                          color: themeController.textColor,
                        ),
                      ),
                    ),
                    // Title in the center
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Change Password', // Title of the page
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: themeController.textColor, // Apply theme color
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Icon(
                  Icons.lock_outline,
                  size: 100,
                  color: themeController.secondaryColor,
                ),
                SizedBox(height: 20.0),
                buildPasswordField(
                  controller: _controller.currentPasswordController,
                  labelText: 'Current Password',
                ),
                SizedBox(height: 16.0),
                buildPasswordField(
                  controller: _controller.newPasswordController,
                  labelText: 'New Password',
                ),
                SizedBox(height: 16.0),
                buildPasswordField(
                  controller: _controller.confirmPasswordController,
                  labelText: 'Confirm Password',
                ),
                SizedBox(height: 16.0),
                Obx(() => Text(
                      _controller.errorText.value,
                      style: TextStyle(color: themeController.textColor),
                    )),
                SizedBox(height: 32.0),
                Obx(() => ElevatedButton(
                      onPressed: _controller.isLoading.value
                          ? null
                          : _controller.changePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeController.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: _controller.isLoading.value
                          ? CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              'Change Password',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: themeController.textColor),
                            ),
                    )),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
