import 'package:final_tpc_app/app/data/api/student_requests.dart';
import 'package:final_tpc_app/app/data/models/staff_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StaffDashboardController extends GetxController {
  final Staff staff;
  StaffDashboardController(this.staff);

  var department = "".obs;
  var students = [].obs;
  var isDrawerOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    department.value = staff.department!.name;
    var allStudents = await StudentRequests.getStudentsByDept(staff.department!.deptId.toString());
    students.value = allStudents
        .where((student) => student.placementWilling == true)
        .toList();
    }

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  String getGreeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  IconData getIconForGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 6) {
      return Icons.nightlight_round;
    } else if (hour < 12) {
      return Icons.wb_sunny;
    } else if (hour < 17) {
      return Icons.brightness_5;
    } else if (hour < 21) {
      return Icons.brightness_4;
    } else {
      return Icons.nightlight_round;
    }
  }

  final List<String> catName = [
    "Placement Willing",
    "Non Willing",
    "Posted Job",
    "Add Student",
    "Job Applied Students",
    "Approve job Applications"
  ];
  final List<Icon> catIcons = [
    Icon(Icons.assignment, color: Colors.white, size: 25),
    Icon(Icons.no_accounts, color: Colors.white, size: 25),
    Icon(Icons.post_add_outlined, color: Colors.white, size: 25),
    Icon(Icons.person_add_alt_1, color: Colors.white, size: 25),
    Icon(Icons.badge_outlined, color: Colors.white, size: 25),
    Icon(Icons.approval, color: Colors.white, size: 25),
  ];
}
