import 'package:final_tpc_app/app/controllers/staff_pages_contoller/drawer_controllers/staff_drawer_controller.dart';
import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/data/models/staff_model.dart';
import 'package:final_tpc_app/app/ui/pages/staff_pages/drawer/staff_dashboard.dart';
import 'package:final_tpc_app/app/ui/pages/staff_pages/drawer/staff_menupage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class StaffDrawerHome extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final StaffDrawerController staffDrawerController =
      Get.put(StaffDrawerController());
  final Staff staff;

  StaffDrawerHome({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
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
      body: GetBuilder<StaffDrawerController>(
        builder: (controller) {
          return ZoomDrawer(
            controller: controller.zoomDrawerController,
            style: DrawerStyle.defaultStyle,
            menuScreen: StaffMenuPage(
              selectedIndex: staffDrawerController.selectedIndex.value,
              staff: staff,
            ),
            mainScreen: StaffDashBoard(
              staff: staff,
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
