// profile_controller.dart
import 'package:get/get.dart';

import '../../../../data/models/student_model.dart';

class ProfileController extends GetxController {
  final Student student;
  var selectedMarkType = '10th'.obs;

  ProfileController(this.student);

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Map<String,String> marks = {"10th":"NA", "12th":"NA", "CGPA":"NA"}.obs;

  void initialize(){
    marks = {
      "10th":student.score10th.toString(),
      "12th":student.score12th.toString(),
      "CGPA":student.cgpa.toString()
    };
  }

  void updateMarkType(String? newValue) {
    if (newValue != null) {
      selectedMarkType.value = newValue;
    }
  }
}
