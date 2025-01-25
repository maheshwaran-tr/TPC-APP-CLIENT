import 'package:final_tpc_app/app/data/token/token_storage.dart';
import 'package:final_tpc_app/app/ui/components/student_page/menu_options.dart';
import 'package:final_tpc_app/app/ui/pages/homepage/homepage.dart';
import 'package:final_tpc_app/app/ui/pages/student_pages/drawer/ChangePassword/ChangePassword.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/data/models/student_model.dart';

import '../../../ui/pages/student_pages/drawer/StudentProfie/student_profile.dart';

class MenuPageController extends GetxController {
  var selectedIndex = 0.obs;
  final Student student;
  late RxString studentName;

  MenuPageController(this.selectedIndex, this.student);

  @override
  void onInit() {
    super.onInit();
    studentName = student.name.obs; // Ensure the student name is observable
  }

  Future<void> handleMenuOptionTap(MenuOption option, int index) async {
    selectedIndex.value = index;
    update();
    // Handle menu option tap logic here
    if (option == MenuOptions.home) {
      // Add your logic for Home here
    } else if (option == MenuOptions.profile) {
      Get.to(() => ProfileScreen(student: student,));
      // Add your logic for Profile here
    } else if (option == MenuOptions.resume) {
      print('Tapped on Setting');
      // Add your logic for Setting here
    } else if (option == MenuOptions.changePass) {
      Get.to(() => StudentChangePasswordPage(student: student));
      print('Tapped on ChangePassword');

      // Add your logic for Setting here
    } else if (option == MenuOptions.logout) {
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
