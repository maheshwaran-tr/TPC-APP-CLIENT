import 'package:flutter/material.dart';

class MenuOptions {
  static final home = MenuOption(Icons.home, "Home");
  static final profile = MenuOption(Icons.person, "Profile");
  static final resume = MenuOption(Icons.file_copy, "Resume");
  static final changePass = MenuOption(Icons.lock_person, "Change Password");
  static final about = MenuOption(Icons.info_outline, "About");
  static final logout = MenuOption(Icons.logout, "Logout");

  static final allOptions = [home, profile, resume, changePass, about, logout];
}

class MenuOption {
  final IconData icon;
  final String title;

  MenuOption(this.icon, this.title);
}
