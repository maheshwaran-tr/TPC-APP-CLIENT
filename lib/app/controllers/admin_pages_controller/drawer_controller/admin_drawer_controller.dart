import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class AdminDrawerController extends GetxController {
  var selectedIndex = 0.obs;
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  void changeIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  void toggleDrawer() {
    if (zoomDrawerController.isOpen!()) {
      zoomDrawerController.close!();
    } else {
      zoomDrawerController.open!();
    }
    update();
  }
}
