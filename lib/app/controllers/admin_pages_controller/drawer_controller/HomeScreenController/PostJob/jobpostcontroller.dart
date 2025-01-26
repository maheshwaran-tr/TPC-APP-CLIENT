import 'package:final_tpc_app/app/data/api/company_requests.dart';
import 'package:final_tpc_app/app/data/api/department_requests.dart';
import 'package:final_tpc_app/app/data/models/company_model.dart';
import 'package:final_tpc_app/app/data/models/department_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class JobPostController extends GetxController {
  var companyLogo = Rxn<XFile>();
  var selectedDepartments = <String>[].obs; // Observed list for selected departments
  RxList<Company> companyList = <Company>[].obs; // Holds company names
  RxList<String> departments = <String>[].obs; // Holds department names
  RxBool isLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  /// Fetches the initial data for companies and departments
  Future<void> fetchInitialData() async {
    print("Fetching initial data...");
    isLoaded.value = false; // Set loading state to false before fetching data

    try {
      // Fetch companies and departments concurrently for better performance
      final results = await Future.wait([
        CompanyRequests.getAllCompanies(),
        DepartmentRequests.getAllDepartments(),
      ]);

      // Extract data from the results
      final companies = results[0] as List<Company>;
      final allDepts = results[1] as List<Department>;

      // Update company list
      companyList.value = companies;

      // Update department list with "All" followed by department names
      departments.value = ["All", ...allDepts.map((dept) => dept.name)];

      print("Departments: ${departments.toList()}");
      print("Companies: ${companyList.toList()}");
    } catch (e) {
      print("Error fetching initial data: $e");
      // Optionally: Show some error message or feedback
    } finally {
      isLoaded.value = true; // Set the loading state to true after fetching data
    }
  }

  /// Handles department selection logic
  void handleDepartmentSelection(List<String> selected) {
    if (selected.contains("All")) {
      selectedDepartments.value = List<String>.from(departments.where((department) => department != "All")); // Select all departments
    } else {
      selectedDepartments.value = List<String>.from(selected); // Select specific departments
    }
  }
}
