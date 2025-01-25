// lib/app/utils/screen_utils.dart
import 'package:flutter/material.dart';

class ScreenUtils {
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getTopPadding(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getBottomPadding(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static double getOrientationHeight(BuildContext context,
      {required double portrait, required double landscape}) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? portrait
        : landscape;
  }

  static double getOrientationWidth(BuildContext context,
      {required double portrait, required double landscape}) {
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? portrait
        : landscape;
  }
}
