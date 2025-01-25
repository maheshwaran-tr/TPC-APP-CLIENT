import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/data/api/application_requests.dart';
import 'package:final_tpc_app/app/data/api/drive_requests.dart';
import 'package:final_tpc_app/app/data/api/student_requests.dart';
import 'package:final_tpc_app/app/data/models/application_model.dart';
import 'package:final_tpc_app/app/data/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/drive_model.dart';

// Need to optimize whole logic for this page so wait
class StudentDashboardController extends GetxController {

  final Student student; 

  final ThemeController themeController = Get.find();

  StudentDashboardController(this.student);

  var applicationList = <Application>[].obs;
  // List<Drive> driveList = [];

  late Student studentRefreshed;

  var isDrawerOpen = false.obs;

  final List<String> catName = ["Co-Ord", "Upload Status", "Apply Job"];

  final List<Icon> catIcon = [
    Icon(Icons.group, color: Colors.white),
    Icon(Icons.upload, color: Colors.white),
    Icon(Icons.work, color: Colors.white)
  ];

  final companyStatusIcons = <String, IconData>{
    "Selected": Icons.check_circle,
    "Not Selected": Icons.cancel,
    "Waiting for Result": Icons.access_time,
    "Not Attended": Icons.not_interested,
    "No. of Drives": Icons.person_pin_outlined,
  }.obs;

  final companyStatusColors = <String, Color>{
    "Selected": Colors.green,
    "Not Selected": Colors.red,
    "Waiting for Result": Colors.grey,
    "No. of Drives": Colors.amber
  }.obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    studentRefreshed = await StudentRequests.getStudentById(student.studentId.toString());
    for (var application in studentRefreshed.applications!) {
      Application app = await ApplicationRequests.getApplicationById(application.applicationId.toString());
      Drive drive = await DriveRequests.getDriveById(application.driveId.toString());
      print("venue : ${drive.venue}");
      print("jobtype : ${drive.jobType}");
      app.drive = drive;
      applicationList.add(app);
      // driveList.add(drive);
    }
  }

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
  }

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'GOOD MORNING';
    } else if (hour < 17) {
      return 'GOOD AFTERNOON';
    } else if (hour < 21) {
      return 'GOOD EVENING';
    } else {
      return 'GOOD NIGHT';
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

}