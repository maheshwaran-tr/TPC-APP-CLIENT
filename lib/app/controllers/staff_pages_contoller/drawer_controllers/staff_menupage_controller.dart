import 'package:final_tpc_app/app/data/models/staff_model.dart';
import 'package:final_tpc_app/app/ui/components/staff_page/menu_options.dart';
import 'package:final_tpc_app/app/ui/pages/homepage/homepage.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../../data/token/token_storage.dart';

class StaffMenuPageController extends GetxController {
  var selectedIndex = 0.obs;
  final Staff staff;
  late RxString staffName;

  StaffMenuPageController(this.selectedIndex, this.staff);
  @override
  void onInit() {
    super.onInit();
    staffName = staff.name.obs; // Ensure the student name is observable
  }

  Future<void> handleMenuOptionTap(StaffMenuOption option, int index) async {
    selectedIndex.value = index;
    update();

    // // Handle menu option tap logic here
    if (option == StaffMenuOptions.home) {
      //   Navigator.push(
      //     Get.context!,
      //     MaterialPageRoute(
      //       builder: (context) => StaffDrawerHome(staff: staff),
      //     ),
      //   );
      //   // Add your logic for Home here
    }
    // else if (option == StaffMenuOptions.profile) {
    //   print('Tapped on Profile');
    //   Navigator.push(
    //     Get.context!,
    //     MaterialPageRoute(
    //       builder: (context) => StaffProfilePage(staff: staff),
    //     ),
    //   );
    //   // Add your logic for Profile here
    // } else if (option == StaffMenuOptions.changePass) {
    //   print('Tapped on ChangePassword');
    //   Navigator.push(
    //     Get.context!,
    //     MaterialPageRoute(
    //       builder: (context) => StaffChangePasswordPage(staff: staff),
    //     ),
    //   );
    //   // Add your logic for Setting here
    // }
    else if (option == StaffMenuOptions.logout) {
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
