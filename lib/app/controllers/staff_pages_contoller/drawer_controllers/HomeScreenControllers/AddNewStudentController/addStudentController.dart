import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/data/api/student_requests.dart';
import 'package:final_tpc_app/app/data/models/student_register_model.dart';
import 'package:final_tpc_app/app/data/models/user_role_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStudentController extends GetxController {
  final Map<String, TextEditingController> controllers = {};
  final List<Map<String, dynamic>> fields = [];
  bool? placementWilling = true;
  bool isProcessing = false;
  String errorMessage = "";
  DateTime? selectedDob;

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
  }

  void _initializeFields() {
    final fieldData = [
      {'key': 'studentName', 'label': 'Student Name'},
      {'key': 'rollNo', 'label': 'Roll No'},
      {'key': 'regNo', 'label': 'Reg No'},
      {'key': 'cgpa', 'label': 'CGPA', 'isNumeric': true},
      {'key': 'standingArrears', 'label': 'Standing Arrear', 'isNumeric': true},
      {
        'key': 'historyOfArrears',
        'label': 'History of Arrear',
        'isNumeric': true
      },
      {'key': 'department', 'label': 'Department'},
      {'key': 'section', 'label': 'Section'},
      {'key': 'gender', 'label': 'Gender'},
      {'key': 'placeOfBirth', 'label': 'Place of Birth'},
      {'key': 'email', 'label': 'Email'},
      {'key': 'phoneNumber', 'label': 'Phone Number'},
      {'key': 'permanentAddress', 'label': 'Permanent Address'},
      {'key': 'presentAddress', 'label': 'Present Address'},
      {'key': 'community', 'label': 'Community'},
      {'key': 'fatherName', 'label': 'Father Name'},
      {'key': 'fatherOccupation', 'label': 'Father Occupation'},
      {'key': 'motherName', 'label': 'Mother Name'},
      {'key': 'motherOccupation', 'label': 'Mother Occupation'},
      {'key': 'score10th', 'label': '10th Score', 'isNumeric': true},
      {'key': 'board10th', 'label': '10th Board'},
      {'key': 'yearOfPassing10th', 'label': 'Year of Passing 10th'},
      {'key': 'score12th', 'label': '12th Score', 'isNumeric': true},
      {'key': 'board12th', 'label': '12th Board'},
      {'key': 'yearOfPassing12th', 'label': 'Year of Passing 12th'},
      {'key': 'scoreDiploma', 'label': 'Diploma Score'},
      {'key': 'branchDiploma', 'label': 'Diploma Branch'},
      {'key': 'yearOfPassingDiploma', 'label': 'Year of Passing Diploma'},
      {'key': 'parentPhoneNumber', 'label': 'Parent Phone Number'},
      {'key': 'aadhar', 'label': 'Aadhar'},
      {'key': 'batch', 'label': 'Batch', 'isNumeric': true},
      {'key': 'currentSem', 'label': 'Current Sem', 'isNumeric': true},
    ];

    for (final field in fieldData) {
      controllers[field['key'] as String] = TextEditingController();
      fields.add(field);
    }
  }

  Future<void> validateAndSubmit() async {
    isProcessing = true;
    errorMessage = "";
    update();

    StudentRegisterModel newStudent = StudentRegisterModel(
        role: UserRole.student.toString(),
        password: controllers['rollNo']!.text,
        username: controllers['rollNo']!.text,
        regno: controllers['regNo']!.text,
        name: controllers['studentName']?.text ?? "",
        deptId: int.parse(controllers['department']?.text ?? "0"),
        gender: controllers['gender']!.text,
        fatherName: controllers['fatherName']!.text,
        dob: selectedDob!, // Use DateTime value
        score10Th: int.tryParse(controllers['score10th']!.text)!,
        board10Th: controllers['board10th']!.text,
        yop10Th: int.tryParse(controllers['yearOfPassing10th']?.text ?? "")!,
        score12Th: int.tryParse(controllers['score12th']?.text ?? "")!,
        board12Th: controllers['board12th']!.text,
        yop12Th: int.tryParse(controllers['yearOfPassing12th']?.text ?? "")!,
        scoreDiploma: int.tryParse(controllers['scoreDiploma']?.text ?? "")!,
        branchDiploma: controllers['branchDiploma']!.text,
        yopDiploma:
            int.tryParse(controllers['yearOfPassingDiploma']?.text ?? "")!,
        cgpa: double.tryParse(controllers['cgpa']?.text ?? "")!,
        historyOfArrears:
            int.tryParse(controllers['historyOfArrears']?.text ?? "")!,
        currentArrears:
            int.tryParse(controllers['standingArrears']?.text ?? "")!,
        phoneNumber: controllers['phoneNumber']!.text,
        email: controllers['email']!.text,
        resumeUrl: controllers['resumeUrl']?.text,
        profileUrl: controllers['profileUrl']?.text,
        placementWilling: "Yes");

    await StudentRequests.createStudent(newStudent);
    isProcessing = false;

    Get.snackbar('Success', 'Student Added Successfully',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    for (var controller in controllers.values) {
      controller.clear();
    }
    placementWilling = true;
    selectedDob = null; // Reset dob
      update();
  }

  final ThemeController themeController = Get.find();

  Widget buildTextField({
    required String labelText,
    required String key,
    bool isNumeric = false,
    bool readOnly = false,
    void Function()? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controllers[key],
        readOnly: readOnly,
        style: TextStyle(color: themeController.textColor),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              color: themeController.textColor
                  .withOpacity(0.7)), // Label text color
          hintText: 'Enter $labelText',
          hintStyle:
              TextStyle(color: themeController.textColor.withOpacity(0.5)),
          border: const OutlineInputBorder(),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildDobField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: _selectDate,
        child: AbsorbPointer(
          child: TextFormField(
            controller: TextEditingController(
                text: selectedDob?.toLocal().toString().split(' ')[0] ?? ""),
            readOnly: true,
            style: TextStyle(color: themeController.textColor),
            decoration: InputDecoration(
              labelText: "Date of Birth",
              labelStyle: TextStyle(
                  color: themeController.textColor
                      .withOpacity(0.7)), // Label text color
              hintText: 'Select Date of Birth',
              hintStyle:
                  TextStyle(color: themeController.textColor.withOpacity(0.5)),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPlacementWillingField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Placement Willing',
              style: TextStyle(
                  fontSize: 16,
                  color: themeController.textColor,
                  fontWeight: FontWeight.w600)),
          Row(
            children: [
              Radio<bool>(
                value: true,
                groupValue: placementWilling,
                onChanged: (value) {
                  placementWilling = value;
                  update();
                },
              ),
              Text(
                'Yes',
                style: TextStyle(color: themeController.textColor),
              ),
              Radio<bool>(
                value: false,
                groupValue: placementWilling,
                onChanged: (value) {
                  placementWilling = value;
                  update();
                },
              ),
              Text('No', style: TextStyle(color: themeController.textColor)),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      selectedDob = pickedDate;
      update();
    }
  }

  @override
  void onClose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.onClose();
  }
}
