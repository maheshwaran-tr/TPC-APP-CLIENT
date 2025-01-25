import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_tpc_app/app/ui/theme/app_colors/app_color.dart';

class ThemeController extends GetxController {
  // Light Theme Colors
  final _primaryColor = AppColors.primaryColor.obs;
  final _secondaryColor = AppColors.secondaryColor.obs;
  final _tertiaryColor = AppColors.tertiaryColor.obs;
  final _textColorLight = AppColors.textColorLight.obs;

  // Dark Theme Colors
  final _primaryColorDark = AppColors.primaryColorDark.obs;
  final _secondaryColorDark = AppColors.secondaryColorDark.obs;
  final _tertiaryColorDark = AppColors.tertiaryColorDark.obs;
  final _textColorDark = AppColors.textColorDark.obs;

  // Dark mode status
  final _isDarkMode = false.obs;

  // SharedPreferences key
  static const _themeKey = "isDarkMode";

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  // Getters for colors and dark mode
  Color get primaryColor =>
      _isDarkMode.value ? _primaryColorDark.value : _primaryColor.value;
  Color get secondaryColor =>
      _isDarkMode.value ? _secondaryColorDark.value : _secondaryColor.value;
  Color get tertiaryColor =>
      _isDarkMode.value ? _tertiaryColorDark.value : _tertiaryColor.value;
  Color get textColor =>
      _isDarkMode.value ? _textColorDark.value : _textColorLight.value;
  bool get isDarkMode => _isDarkMode.value;

  // Methods to update colors
  void updatePrimaryColor(Color color) {
    _primaryColor.value = color;
  }

  void updateSecondaryColor(Color color) {
    _secondaryColor.value = color;
  }

  void updateTertiaryColor(Color color) {
    _tertiaryColor.value = color;
  }

  // Method to toggle dark mode
  void toggleDarkMode() async {
    _isDarkMode.value = !_isDarkMode.value;
    await _saveThemePreference();
  }

  // Save theme preference to SharedPreferences
  Future<void> _saveThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode.value);
  }

  // Load theme preference from SharedPreferences
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode.value = prefs.getBool(_themeKey) ?? false;
  }
}
