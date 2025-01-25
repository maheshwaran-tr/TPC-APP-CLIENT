import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/data/models/student_model.dart';
import 'package:final_tpc_app/app/ui/components/student_page/menu_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/controllers/student_pages_controller/drawer_controller/menu_page_controller.dart';
import 'package:final_tpc_app/app/utils/screen_utils.dart';

class MenuPage extends StatelessWidget {
  final int selectedIndex;
  final Student student;
  final ThemeController themeController = Get.find();

  MenuPage({super.key, required this.selectedIndex, required this.student});

  @override
  Widget build(BuildContext context) {
    // Configure System UI Overlay for Status and Navigation Bar
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: themeController.isDarkMode
            ? Colors.black
            : themeController.primaryColor,
        statusBarIconBrightness:
            themeController.isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: themeController.primaryColor,
        systemNavigationBarIconBrightness:
            themeController.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );

    final width = ScreenUtils.getWidth(context);
    final height = ScreenUtils.getHeight(context);

    return Obx(() {
      // Wrap the entire scaffold inside an Obx widget to reactively rebuild
      return SafeArea(
        child: Scaffold(
          backgroundColor: themeController.secondaryColor,
          body: GetBuilder<MenuPageController>(
            init: MenuPageController(selectedIndex.obs, student),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Theme Toggle Icon
                  Padding(
                    padding: EdgeInsets.all(width * 0.05),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Align to right
                      children: [
                        // Close Drawer Icon
                        InkWell(
                          onTap: () => ZoomDrawer.of(context)?.close(),
                          child: Icon(
                            Icons.close,
                            color: themeController.isDarkMode
                                ? Colors.white
                                : themeController.tertiaryColor,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                            width: width * 0.05), // Add space between icons

                        // Theme Toggle Icon
                        InkWell(
                          onTap: () {
                            // Toggle dark mode with animation
                            themeController.toggleDarkMode();
                          },
                          child: AnimatedSwitcher(
                            duration: const Duration(
                                milliseconds: 300), // Duration of the animation
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              // Use a fade and scale transition for the icon
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            child: Icon(
                              themeController.isDarkMode
                                  ? Icons.wb_sunny // Sun icon for light mode
                                  : Icons
                                      .nightlight_round, // Moon icon for dark mode
                              key: ValueKey<bool>(themeController
                                  .isDarkMode), // Unique key to trigger animation on change
                              color: themeController.isDarkMode
                                  ? Colors.white
                                  : themeController.tertiaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Greeting Section
                  Padding(
                    padding: EdgeInsets.all(width * 0.05),
                    child: Column(
                      children: [
                        Text(
                          "Hello,",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          controller.studentName.value,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.03),

                  // Menu Options
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(width * 0.05),
                      decoration: BoxDecoration(
                        color: themeController.primaryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: MenuOptions.allOptions.length,
                        itemBuilder: (context, index) {
                          final option = MenuOptions.allOptions[index];
                          final isSelected =
                              index == controller.selectedIndex.value;

                          return ListTile(
                            tileColor: isSelected
                                ? themeController.secondaryColor
                                : Colors.transparent,
                            leading: Icon(
                              option.icon,
                              color: isSelected
                                  ? themeController.secondaryColor
                                  : (themeController.isDarkMode
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            title: Text(
                              option.title,
                              style: TextStyle(
                                fontSize: 18,
                                color: isSelected
                                    ? themeController.secondaryColor
                                    : (themeController.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () =>
                                controller.handleMenuOptionTap(option, index),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
