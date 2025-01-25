import 'package:flutter/material.dart';

class StaffMenuOptions {
  static final home = StaffMenuOption(Icons.home, "Home");
  static final profile = StaffMenuOption(Icons.person, "Profile");
  static final manageStudents =
      StaffMenuOption(Icons.supervised_user_circle, "Manage Students");
  static final manageTasks = StaffMenuOption(Icons.task, "Manage Tasks");
  static final settings = StaffMenuOption(Icons.settings, "Settings");
  static final logout = StaffMenuOption(Icons.logout, "Logout");

  static final staffOptions = [
    home,
    profile,
    manageStudents,
    manageTasks,
    settings,
    logout
  ];
}

class StaffMenuOption {
  final IconData icon;
  final String title;

  StaffMenuOption(this.icon, this.title);
}
