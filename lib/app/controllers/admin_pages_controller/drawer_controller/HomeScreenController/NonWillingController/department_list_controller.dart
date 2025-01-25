// department_controller.dart

import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/data/api/department_requests.dart';
import 'package:final_tpc_app/app/data/models/department_model.dart';
import 'package:get/get.dart';

class DepartmentController extends GetxController {
  RxList<Map<String, String>> departments = <Map<String, String>>[].obs;

  RxBool isLoaded = false.obs;
  RxString searchText = ''.obs;
  var filteredDept = <Map<String, String>>[].obs;

  final ThemeController controller = Get.put(ThemeController());

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  String getUpdatedUrl(String baseUrl) {
    // Regex to extract department name and file extension (e.g., 'cse.png', 'mech.jpg')
    final RegExp fileNamePattern = RegExp(r'([^/]+)\.(png|jpg|jpeg|gif|bmp|webp)$');
    final match = fileNamePattern.firstMatch(baseUrl);

    if (match != null) {
      final String department = match.group(1)!; // Extract department name (e.g., 'cse')
      final String extension = match.group(2)!; // Extract file extension (e.g., 'png', 'jpg')
      final String updatedFileName =
          controller.isDarkMode ? '${department}_light.$extension' : '${department}_dark.$extension';
      return baseUrl.replaceFirst(fileNamePattern, updatedFileName);
    }

    // Return the original URL if no match is found
    return baseUrl;
  }

  Future<void> initializeData() async {
    try {
        
      List<Department> allDepts = await DepartmentRequests.getAllDepartments();

      departments.value = allDepts
          .map((dept) => {
                'id':dept.deptId.toString(),
                'name': dept.name,
                'image': dept.logo != null ? getUpdatedUrl(dept.logo!) : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtuphMb4mq-EcVWhMVT8FCkv5dqZGgvn_QiA&shttps://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtuphMb4mq-EcVWhMVT8FCkv5dqZGgvn_QiA&s"
              })
          .toList();
      
      filteredDept = departments;
      
      isLoaded.value = true;
    } catch (e) {
      print("Error fetching departments: $e");
      isLoaded.value = true;
    }
  }

  void filterDepartmentsBySearch(String query) {
    searchText.value = query;
  }

  void getFilteredDepartments() {
    if (searchText.isEmpty) {
      filteredDept.value =  filteredDept;
    } else {
      filteredDept.value = filteredDept
          .where((dept) =>
              dept['name']!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }
}
