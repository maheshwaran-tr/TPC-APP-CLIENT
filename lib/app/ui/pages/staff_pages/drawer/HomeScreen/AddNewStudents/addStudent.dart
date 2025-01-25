import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/utils/screen_utils.dart';
import 'package:final_tpc_app/app/controllers/staff_pages_contoller/drawer_controllers/HomeScreenControllers/AddNewStudentController/addStudentController.dart';

class AddStudentPage extends StatelessWidget {
  const AddStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final AddStudentController controller = Get.put(AddStudentController());

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: themeController.secondaryColor,
          leading: IconButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: themeController.textColor,
            ),
          ),
          title: Text(
            "ADD STUDENT",
            style: TextStyle(color: themeController.textColor),
          ),
        ),
        resizeToAvoidBottomInset:
            true, // Ensures layout resizes when keyboard appears
        body: GestureDetector(
          onTap: () {
            // Dismiss keyboard on tap outside text fields
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Container(
                color: themeController.primaryColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtils.getHeight(context) * 0.02,
                    horizontal: ScreenUtils.getWidth(context) * 0.05,
                  ),
                  child: Column(
                    children: [
                      // Dynamic field generation
                      ...controller.fields.map((field) {
                        return controller.buildTextField(
                          labelText: field['label'],
                          key: field['key'],
                          isNumeric: field['isNumeric'] ?? false,
                          readOnly: field['readOnly'] ?? false,
                          onTap: field['onTap'],
                        );
                      }),
                      controller.buildPlacementWillingField(),
                      SizedBox(height: ScreenUtils.getHeight(context) * 0.03),
                      controller.isProcessing
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeController.secondaryColor,
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        ScreenUtils.getHeight(context) * 0.015,
                                    horizontal:
                                        ScreenUtils.getWidth(context) * 0.10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: controller.validateAndSubmit,
                              child: Text(
                                'Add Student',
                                style:
                                    TextStyle(color: themeController.textColor),
                              ),
                            ),
                      if (controller.errorMessage.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtils.getHeight(context) * 0.02,
                          ),
                          child: Text(
                            controller.errorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenUtils.getHeight(context) * 0.018,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
