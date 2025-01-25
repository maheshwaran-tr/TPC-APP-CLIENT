import 'package:flutter/material.dart';

class AdminMenuOptions {
  static final home = AdminMenuOption(Icons.home, "Home");
  static final profile = AdminMenuOption(Icons.person, "Profile");
  static final manageStudents =
      AdminMenuOption(Icons.supervised_user_circle, "Manage Students");
  static final manageTasks = AdminMenuOption(Icons.task, "Manage Tasks");
  static final settings = AdminMenuOption(Icons.settings, "Settings");
  static final logout = AdminMenuOption(Icons.logout, "Logout");

  static final adminOptions = [
    home,
    profile,
    manageStudents,
    manageTasks,
    settings,
    logout
  ];
}

class AdminMenuOption {
  final IconData icon;
  final String title;

  AdminMenuOption(this.icon, this.title);
}
