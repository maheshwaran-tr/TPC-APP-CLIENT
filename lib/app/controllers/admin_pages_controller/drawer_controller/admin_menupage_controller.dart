import 'package:final_tpc_app/app/data/models/admin_model.dart';
import 'package:final_tpc_app/app/ui/components/admin_page/menu_options.dart';
import 'package:final_tpc_app/app/ui/pages/admin_pages/drawer/admin_drawer.dart';
import 'package:final_tpc_app/app/ui/pages/homepage/homepage.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../../data/token/token_storage.dart';

class AdminMenuController extends GetxController {
  var selectedIndex = 0.obs; // Observable index for selected menu
  final Admin admin;
  late RxString adminName;

  AdminMenuController(this.selectedIndex, this.admin);
  @override
  void onInit() {
    super.onInit();
    adminName = admin.name.obs; // Ensure the student name is observable
  }

  // Handle menu item taps
  Future<void> handleMenuOptionTap(AdminMenuOption option, int index) async {
    selectedIndex.value = index;
    update();
    if (option == AdminMenuOptions.home) {
      Get.to(() => AdminDrawerHome(admin: Get.arguments));
    } else if (option == AdminMenuOptions.profile) {
      //Get.to(() => AdminProfilePage(admin: Get.arguments));
    } else if (option == AdminMenuOptions.settings) {
      //Get.to(() => AdminChangePasswordPage(admin: Get.arguments));
    } else if (option == AdminMenuOptions.logout) {
      bool res = await TokenStorage.deleteTokens();
      if (res) {
        Get.offAll(() => HomePage());
      } else {
        print("Error in logout");
      }
    }

    // Close the drawer after handling the tap
    ZoomDrawer.of(Get.context!)!.close();
  }
}
