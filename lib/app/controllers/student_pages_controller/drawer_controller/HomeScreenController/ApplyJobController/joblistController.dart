import 'package:final_tpc_app/app/data/api/drive_requests.dart';
import 'package:get/get.dart';

import '../../../../../data/models/drive_model.dart';

class JobListController extends GetxController {

  var driveList = <Drive>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      isLoading(true);
      
      driveList.value = await DriveRequests.getAllDrives();
      print(driveList);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshJobList() async {
    await fetchJobs(); // Fetch data again on refresh
  }
}
