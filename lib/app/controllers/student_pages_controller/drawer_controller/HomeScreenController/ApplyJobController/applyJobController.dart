import 'package:final_tpc_app/app/data/api/application_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/models/RequestModels/application_request_model.dart';
import '../../../../../data/models/student_model.dart';
import '../../../../../data/models/drive_model.dart';

class ApplyJobController extends GetxController {
  var isLoading = false.obs;
  var hasApplied = false.obs;
  var isEligible = false.obs;

  late final Student studentData;

  void initialize(Student student) {
    studentData = student;
  }

  bool checkEligibility(Student student, Drive job) {
    isEligible.value = student.score10th! >= job.eligible10thMark! &&
        student.score12th! >= job.eligible12thMark! &&
        student.cgpa! >= job.eligibleCgpa! &&
        student.currentArrears! <= job.eligibleCurrentArrears! &&
        student.historyOfArrears! <= job.eligibleHistoryOfArrears!;
    return isEligible.value;
  }

  Future<void> applyJob(String studentId, String driveId) async {
    // if (!isEligible.value) {
    //   showResultBox(
    //     "Not Eligible",
    //     "You do not meet the eligibility criteria for this job.",
    //   );
    //   return;
    // }

    // if (hasApplied.value) {
    //   showResultBox(
    //     "Already Applied",
    //     "You have already applied to this job.",
    //   );
    //   return;
    // }

    try {
      isLoading.value = true;

      ApplicationRequest application = ApplicationRequest(
        studentId: studentId,
        driveId: driveId,
      );

      String? res = await ApplicationRequests.createApplication(application);

      showResultBox("Message", res ?? "Unknown Error");

      hasApplied.value = true; // Update state to reflect application success
    } catch (e) {
      showResultBox("Error", "Network or unexpected error: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void showResultBox(String title, String content, {VoidCallback? onRetry}) {
    Get.defaultDialog(
      title: title,
      content: Text(content),
      actions: [
        if (onRetry != null)
          ElevatedButton(
            onPressed: onRetry,
            child: Text("Retry"),
          ),
        ElevatedButton(
          onPressed: () => Get.back(),
          child: Text("OK"),
        ),
      ],
    );
  }
}
