import 'package:final_tpc_app/app/data/models/admin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboardController extends GetxController {
  final Admin admin;
  AdminDashboardController(this.admin);

  final drawerController = RxBool(false);
  RxString greeting = ''.obs;
  Rx<IconData> greetingIcon = Icons.wb_sunny.obs;
  RxList<String> catNames = [
    "Dept Student List",
    "Non Willing Students",
    "Add Staff",
    "Posted Job",
    "Staff List",
    "Post Job",
  ].obs;

  final List<Icon> catIcons = [
    Icon(Icons.assignment, color: Colors.white, size: 25),
    Icon(Icons.no_accounts, color: Colors.white, size: 25),
    Icon(Icons.post_add_outlined, color: Colors.white, size: 25),
    Icon(Icons.person_add_alt_1, color: Colors.white, size: 25),
    Icon(Icons.badge_outlined, color: Colors.white, size: 25),
    Icon(Icons.approval, color: Colors.white, size: 25),
  ];
  
  Rx<ImageProvider?> adminImage = AssetImage('assets/images/user.jpg').obs;

  @override
  void onInit() {
    super.onInit();
    _setGreeting();
    // fetchAdminImage();
  }

  void _setGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      greeting.value = 'Good Morning';
      greetingIcon.value = Icons.wb_sunny;
    } else if (hour < 17) {
      greeting.value = 'Good Afternoon';
      greetingIcon.value = Icons.brightness_5;
    } else if (hour < 21) {
      greeting.value = 'Good Evening';
      greetingIcon.value = Icons.brightness_4;
    } else {
      greeting.value = 'Good Night';
      greetingIcon.value = Icons.nightlight_round;
    }
  }

  // Future<void> fetchAdminImage() async {
  //   try {
  //     final imageBytes = await AdminRequests.fetchImageByAdminId(admin.id);
  //     adminImage.value = MemoryImage(imageBytes);
  //   } catch (e) {
  //     print("Error fetching admin image: $e");
  //   }
  // }

  void toggleDrawer() {
    drawerController.value = !drawerController.value;
  }
}