import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/api/student_requests.dart';
import '../../../../../data/models/staff_model.dart';
import '../../../../../data/models/student_model.dart';

class NonWillingStudentsController extends GetxController {
  final Staff staff;
  var isLoading = true.obs;
  var students = <Student>[].obs;
  var filteredStudents = <Student>[].obs; // For filtering students
  var sections = <String>[].obs; // List of sections
  var selectedSection = ''.obs;

  NonWillingStudentsController({required this.staff}); // Currently selected section

  @override
  void onInit() {
    super.onInit();
    fetchStudents();
  }

  void fetchStudents() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate loading
    List<Student> deptStudents =
        await StudentRequests.getStudentsByDept(staff.deptId.toString());

    List<Student> placementWillingStudents = [];
    for (Student s in deptStudents) {
      if (s.placementWilling!.toLowerCase() == 'no') {
        placementWillingStudents.add(s);
      }
    }
    
    students.value = placementWillingStudents;
    isLoading.value = false;

    // Populate sections dynamically
    sections.value =
        students.map((student) => student.section??"NA").toSet().toList();
    filteredStudents.value = students; // Initially, display all students
  }

  void filterStudentsByName(String query) {
    if (query.isEmpty) {
      filteredStudents.value = students;
    } else {
      filteredStudents.value = students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void filterStudentsBySection(String? section) {
    selectedSection.value = section ?? '';
    if (section == null || section.isEmpty) {
      filteredStudents.value = students;
    } else {
      filteredStudents.value =
          students.where((student) => student.section == section).toList();
    }
  }

  void resetFilters() {
    selectedSection.value = '';
    filteredStudents.value = students; // Reset to show all students
  }

  void openFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Obx(() {
                return DropdownButton<String>(
                  value: selectedSection.value.isEmpty
                      ? null
                      : selectedSection.value,
                  hint: Text("Select Section"),
                  items: sections.map((section) {
                    return DropdownMenuItem<String>(
                      value: section,
                      child: Text(section),
                    );
                  }).toList(),
                  onChanged: (value) {
                    filterStudentsBySection(value);
                    Navigator.pop(context); // Close the filter modal
                  },
                  isExpanded: true,
                );
              }),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  resetFilters(); // Reset filters
                  Navigator.pop(context); // Close the filter modal
                },
                child: Text('Reset Filters'),
              ),
            ],
          ),
        );
      },
    );
  }
}
