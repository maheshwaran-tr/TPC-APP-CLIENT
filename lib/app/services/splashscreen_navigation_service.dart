import 'package:final_tpc_app/app/data/api/admin_requests.dart';
import 'package:final_tpc_app/app/data/api/staff_requests.dart';
import 'package:final_tpc_app/app/data/api/student_requests.dart';
import 'package:final_tpc_app/app/data/models/user_model.dart';
import 'package:final_tpc_app/app/data/models/user_role_model.dart';
import 'package:final_tpc_app/app/ui/pages/admin_pages/drawer/admin_drawer.dart';
import 'package:final_tpc_app/app/ui/pages/staff_pages/drawer/staff_drawer.dart';
import 'package:final_tpc_app/app/ui/pages/student_pages/drawer/student_drawer_home.dart';
import 'package:get/get.dart';
import "../ui/pages/homepage/homepage.dart";
import '../data/models/admin_model.dart';
import '../data/models/staff_model.dart';
import '../data/models/student_model.dart';

class NavigationService {
  static Future<void> navigateToHomeScreen(User? user) async {
    if (user == null) {
      Get.off(() => HomePage());
      return;
    }
    UserRole role = user.role;
    
    switch (role) {
      case UserRole.student:
        Student theStudent = await StudentRequests.getStudentById(user.student!.studentId.toString());
        Get.off(() => StudentDrawerHome(student: theStudent));
        break;
      case UserRole.staff:
        Staff theStaff = await StaffRequests.getStaffById(user.staff!.staffId.toString());
        Get.off(() => StaffDrawerHome(staff: theStaff));
        break;
      case UserRole.admin:
        Admin theAdmin = await AdminRequests.getAdminById(user.admin!.adminId.toString());
        Get.off(() => AdminDrawerHome(admin: theAdmin));
        break;
    }
  }
}
