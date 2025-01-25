import 'package:final_tpc_app/app/data/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/controllers/student_pages_controller/drawer_controller/student_drawer_controller.dart';
import 'package:final_tpc_app/app/ui/pages/student_pages/drawer/student_dashboard.dart';
import 'package:final_tpc_app/app/ui/pages/student_pages/drawer/student_menu_page.dart';

class StudentDrawerHome extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final Student student;
  final StudentDrawerController studentDrawerController =
      Get.put(StudentDrawerController());

  StudentDrawerHome({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    // Configure System UI Overlay
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeController.primaryColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: themeController.primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<StudentDrawerController>(
        builder: (controller) {
          return ZoomDrawer(
            controller: controller.zoomDrawerController,
            style: DrawerStyle.defaultStyle,
            mainScreen: StudentDashboard(student: student),
            menuScreen: MenuPage(
              selectedIndex: studentDrawerController.selectedIndex.value,
              student: student,
            ),
            borderRadius: 30.0,
            showShadow: true,
            angle: 0.0,
            drawerShadowsBackgroundColor: Colors.white,
            closeCurve: Curves.easeOutCirc,
          );
        },
      ),
    );
  }
}
