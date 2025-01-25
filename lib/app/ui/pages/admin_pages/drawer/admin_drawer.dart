import 'package:final_tpc_app/app/controllers/admin_pages_controller/drawer_controller/admin_drawer_controller.dart';
import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/data/models/admin_model.dart';
import 'package:final_tpc_app/app/ui/pages/admin_pages/drawer/admin_dashboard.dart';
import 'package:final_tpc_app/app/ui/pages/admin_pages/drawer/admin_menupage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class AdminDrawerHome extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final AdminDrawerController adminDrawerController =
      Get.put(AdminDrawerController());
  final Admin admin;

  AdminDrawerHome({super.key, required this.admin});

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
      body: GetBuilder<AdminDrawerController>(
        builder: (controller) {
          return ZoomDrawer(
            controller: controller.zoomDrawerController,
            style: DrawerStyle.defaultStyle,
            menuScreen: AdminMenuPage(
              selectedIndex: adminDrawerController.selectedIndex.value,
              admin: admin,
            ),
            mainScreen: AdminDash(
              admin: admin,
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
