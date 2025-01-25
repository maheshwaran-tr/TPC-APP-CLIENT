import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class StudentDrawerController extends GetxController {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  final RxInt selectedIndex = 0.obs;

  void toggleDrawer() {
    if (zoomDrawerController.isOpen!()) {
      zoomDrawerController.close!();
    } else {
      zoomDrawerController.open!();
    }
    update();
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
    update();
  }
}
