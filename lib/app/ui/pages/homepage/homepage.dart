import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/ui/pages/admin_pages/admin_login.dart';
import 'package:final_tpc_app/app/ui/pages/staff_pages/staff_login.dart';
import 'package:final_tpc_app/app/ui/pages/student_pages/student_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/controllers/homepage_controller.dart';
import 'package:final_tpc_app/app/utils/screen_utils.dart';

class HomePage extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final HomePageController controller = Get.put(HomePageController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = ScreenUtils.getWidth(context);
    double height = ScreenUtils.getHeight(context);

    return Scaffold(
      backgroundColor: themeController.primaryColor,
      body: GetBuilder<HomePageController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.08,
                  vertical: height * 0.07,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildLogoSection(height, width),
                    SizedBox(height: height * 0.06),
                    _buildButtonSection(width, height),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogoSection(double height, double width) {
    return Column(
      children: <Widget>[
        Container(
          height: height * 0.14,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/Sethu_Institute_of_Technology_Logo.png'),
            ),
          ),
        ),
        SizedBox(height: height * 0.05),
        Text(
          "SETHU INSTITUTE OF TECHNOLOGY",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: width * 0.041,
            color: themeController.textColor,
          ),
        ),
        SizedBox(height: height * 0.02),
        Text.rich(
          TextSpan(
            text: "An Autonomous Institution | Accredited with ",
            style: TextStyle(
              color: themeController.textColor,
              fontWeight: FontWeight.w900,
              fontSize: width * 0.025,
            ),
            children: [
              TextSpan(
                text: 'A++',
                style: TextStyle(
                  color: themeController.tertiaryColor,
                  fontWeight: FontWeight.w900,
                  fontSize: width * 0.025,
                ),
              ),
              const TextSpan(
                text:
                    " Grade by NAAC\nPermanently Affiliated to Anna University Chennai, Approved by ",
              ),
              TextSpan(
                text: 'AICTE',
                style: TextStyle(
                  color: themeController.tertiaryColor,
                ),
              ),
              const TextSpan(
                text: ' - New Delhi',
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: height * 0.06),
        Text(
          "TRAINING AND PLACEMENT CELL",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: themeController.secondaryColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            fontSize: width * 0.05,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonSection(double width, double height) {
    return SlideTransition(
      position: controller.slideAnimation,
      child: Column(
        children: <Widget>[
          _buildCustomButton(
            text: "ADMIN",
            onTap: () => Get.to(() => AdminLogin()),
            width: width,
            height: height,
          ),
          SizedBox(height: height * 0.02),
          _buildCustomButton(
            text: "STAFF",
            onTap: () => Get.to(() => StaffLoginPage()),
            width: width,
            height: height,
          ),
          SizedBox(height: height * 0.02),
          _buildCustomButton(
            text: "STUDENT",
            onTap: () => Get.to(() => StudentLogin()),
            width: width,
            height: height,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomButton({
    required String text,
    required VoidCallback onTap,
    required double width,
    required double height,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 4,
        child: Container(
          width: width * 0.50,
          height: height * 0.07,
          decoration: BoxDecoration(
            color: themeController.secondaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: width * 0.045,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
