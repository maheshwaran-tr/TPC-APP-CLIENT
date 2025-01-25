import 'package:final_tpc_app/app/ui/widgets/loading_progress_design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/controllers/splash_screen_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:final_tpc_app/app/utils/screen_utils.dart';
import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';

class SplashScreen extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final SplashScreenController controller = Get.put(SplashScreenController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(() => AnimatedOpacity(
                opacity: controller.isLoading ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Center(
                  child: Lottie.asset(
                    'assets/lottie/SS.json',
                    fit: BoxFit.fitWidth,
                    width: ScreenUtils.getWidth(context),
                    height: ScreenUtils.getHeight(context),
                    controller: controller.animationController,
                    onLoaded: (composition) {
                      controller.animationController
                        ..duration = composition.duration
                        ..forward(
                            from:
                                0.0); // Ensure animation starts from the beginning
                    },
                  ),
                ),
              )),
          Obx(() => Positioned(
                bottom: ScreenUtils.getHeight(context) * 0.14,
                left: 0,
                right: 0,
                child: controller.isLoading
                    ? CustomLoadingWidget(
                        color: themeController.secondaryColor,
                        size: 50,
                      )
                    : const SizedBox(),
              )),
        ],
      ),
    );
  }
}
