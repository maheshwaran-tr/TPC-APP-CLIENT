import 'package:final_tpc_app/app/data/api/student_requests.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/models/student_model.dart';


// Controller for managing placement willing students
class DeptStudentListController extends GetxController {
  final String deptId;
  
  var isLoading = true.obs;
  var students = <Student>[].obs;
  var filteredStudents = <Student>[].obs; // For filtering students
  var sections = <String>[].obs; // List of sections
  var selectedSection = ''.obs;

  DeptStudentListController({required this.deptId}); // Currently selected section

  @override
  void onInit() {
    super.onInit();
    filteredStudents.value = [];
    fetchStudents();
  }


  @override
  void onClose() {
    super.onClose();
    // Reset the students and filtered list when navigating away
    students.clear();
    filteredStudents.clear();
  }


  void fetchStudents() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate loading

    // Populate sections dynamically
    // Clear previous data before fetching new department data
    students.clear();
    filteredStudents.clear();

    List<Student> deptStudents = await StudentRequests.getStudentsByDept(deptId);

    List<Student> placementWillingStudents = [];
    for (Student s in deptStudents) {
      if (s.placementWilling!.toLowerCase() == 'yes') {
        placementWillingStudents.add(s);
      }
    }

    sections.value = placementWillingStudents.map((student) => student.section??"NA").toSet().toList();
    students.value = placementWillingStudents;
    filteredStudents.value = placementWillingStudents; // Initially, display all students

    isLoading.value = false;
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
