import 'package:final_tpc_app/app/controllers/staff_pages_contoller/drawer_controllers/staff_menupage_controller.dart';
import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/data/models/staff_model.dart';
import 'package:final_tpc_app/app/ui/components/staff_page/menu_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/utils/screen_utils.dart';

class StaffMenuPage extends StatelessWidget {
  final int selectedIndex;
  final Staff staff;
  final ThemeController themeController = Get.find();

  StaffMenuPage({super.key, required this.selectedIndex, required this.staff});

  @override
  Widget build(BuildContext context) {
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

    ScreenUtils.getWidth(context);
    ScreenUtils.getHeight(context);
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          backgroundColor: themeController.secondaryColor,
          body: GetBuilder<StaffMenuPageController>(
            init: StaffMenuPageController(selectedIndex.obs, staff),
            builder: (controller) {
              double width = ScreenUtils.getWidth(context);
              double height = ScreenUtils.getHeight(context);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(width * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            ZoomDrawer.of(context)!.close();
                          },
                          child: Icon(
                            Icons.close,
                            color: themeController.textColor,
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
                  Container(
                    padding: EdgeInsets.all(width * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Hello,",
                            style: TextStyle(
                              fontSize: 16,
                              color: themeController.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          controller.staff.name,
                          style: TextStyle(
                            fontSize: 18,
                            color: themeController.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(width * 0.05),
                      decoration: BoxDecoration(
                        color: themeController.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: StaffMenuOptions.staffOptions.length,
                        itemBuilder: (BuildContext context, int index) {
                          final option = StaffMenuOptions.staffOptions[index];
                          return ListTile(
                            tileColor: index == controller.selectedIndex.value
                                ? themeController.secondaryColor
                                : null,
                            leading: Icon(
                              option.icon,
                              color: index == controller.selectedIndex.value
                                  ? themeController.secondaryColor
                                  : themeController.textColor,
                            ),
                            title: Text(
                              option.title,
                              style: TextStyle(
                                fontSize: 18,
                                color: index == controller.selectedIndex.value
                                    ? themeController.secondaryColor
                                    : themeController.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              controller.handleMenuOptionTap(option, index);
                            },
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
