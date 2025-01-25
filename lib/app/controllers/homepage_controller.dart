import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void onInit() {
    super.onInit();

    fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeInOut,
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeInOut,
      ),
    );

    fadeController.forward();
  }

  @override
  void onClose() {
    fadeController.dispose();
    super.onClose();
  }
}
