// ignore_for_file: unused_local_variable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:final_tpc_app/app/data/api/drive_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/admin_pages_controller/drawer_controller/HomeScreenController/PostJob/jobpostcontroller.dart';
import '../../../../../../data/models/drive_model.dart';

class PostNewJob extends StatefulWidget {
  const PostNewJob({super.key});

  @override
  State<PostNewJob> createState() => _PostNewJobState();
}

class _PostNewJobState extends State<PostNewJob> {
  final _formKey = GlobalKey<FormBuilderState>();

  final JobPostController controller = Get.put(JobPostController());

  // final List<String> company = [
  //   'A_Item1',
  //   'A_Item2',
  //   'A_Item3',
  //   'A_Item4',
  //   'B_Item1',
  //   'B_Item2',
  //   'B_Item3',
  //   'B_Item4',
  // ];

  String? selectedValue;
  String? selectedBatch;
  String? selectedCampusType;

  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController
        .dispose(); // Dispose of your controller or other resources
    super.dispose(); // Call the superclass dispose method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a New Job',
            style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job details section
              Text('Job Details',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal)),
              const SizedBox(height: 10),
              Obx(() {
                if (!controller.isLoaded.value) {
                  return CircularProgressIndicator(); // Show a loader while fetching data
                }
                return FormBuilderField<String>(
                  name: 'company',
                  validator: FormBuilderValidators.required(),
                  builder: (field) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Select Company',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.business),
                        errorText: field.errorText,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select Company',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),
                          ),
                          items: controller.companyList.map((item) {
                            return DropdownMenuItem(
                              value: item.companyId.toString(),
                              child: Text(
                                item.companyName,
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value;
                            });
                            field.didChange(value);
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            width: 200,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search for a company...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase());
                            },
                          ),
                          onMenuStateChange: (isOpen) {
                            if (!isOpen) {
                              textEditingController.clear();
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              }),

              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'jobTitle',
                decoration: InputDecoration(
                  labelText: 'Job Title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.work_outline),
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderDropdown(
                name: 'jobType',
                decoration: InputDecoration(
                  labelText: 'Job Type',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: ['Full-Time', 'Part-Time', 'Internship', 'Contract']
                    .map((type) =>
                    DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'jobDescription',
                decoration: InputDecoration(
                  labelText: 'Job Description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 4,
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'requirements',
                decoration: InputDecoration(
                  hintText: 'Ex: Java, Python, SQL',
                  labelText: 'Requirements',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.checklist),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'package',
                decoration: InputDecoration(
                  hintText: 'Ex:5 LPA or 6 CTC',
                  labelText: 'Package',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.money),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'jobLocation',
                decoration: InputDecoration(
                  labelText: 'Job Location',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderDateTimePicker(
                name: 'applicationDeadline',
                inputType: InputType.both,
                decoration: InputDecoration(
                  labelText: 'Application Deadline',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                format: DateFormat('yyyy-MM-dd hh:mm'),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),

              // **Department/Field of Study** Section
              Text('Department/Field of Study',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal)),
              const SizedBox(height: 10),

              // Wrap the department selection widget inside Obx to trigger reactivity
              FormBuilderField<List<String>>(
                name: 'department',
                validator: FormBuilderValidators.required(),
                builder: (field) {
                  return Obx(() {
                    return MultiSelectDialogField<String>(
                      title: Text("Select Departments"),
                      items: controller.departments
                          .toList() // Access the plain List<String> from RxList
                          .map((department) =>
                          MultiSelectItem<String>(department, department))
                          .toList(),
                      initialValue: controller.selectedDepartments,
                      onConfirm: (values) {
                        controller.handleDepartmentSelection(values);
                        field.didChange(controller.selectedDepartments);
                      },
                      chipDisplay: MultiSelectChipDisplay<String>(
                        chipColor: Colors.transparent,
                      ),
                    );
                  });
                },
              ),

              const SizedBox(height: 30),

              // **Eligibility Criteria Section**
              Text('Eligibility Criteria',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal)),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: '10thEligibility',
                decoration: InputDecoration(
                  labelText: '10th Grade Eligibility',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: '12thEligibility',
                decoration: InputDecoration(
                  labelText: '12th Grade Eligibility',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'cgpaEligibility',
                decoration: InputDecoration(
                  labelText: 'CGPA Eligibility',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.grade),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'HistroryOfarrearsEligibility',
                decoration: InputDecoration(
                  labelText: 'History Of Arrears Eligibility',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.grade),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'StandingArrearsEligibility',
                decoration: InputDecoration(
                  labelText: 'Standing Arrear Eligibility',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.grade),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'numberOfRounds',
                decoration: InputDecoration(
                  labelText: 'Number of Rounds',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.grade),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderDropdown(
                name: 'Batch',
                decoration: InputDecoration(
                  labelText: 'Batch',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.grade),
                ),
                items: [
                  '2025',
                  '2026',
                  '2027',
                  '2028'
                ] // Add the batch options here
                    .map((batch) =>
                    DropdownMenuItem(value: batch, child: Text(batch)))
                    .toList(),
                validator: FormBuilderValidators.required(),
                onChanged: (value) {
                  setState(() {
                    selectedBatch = value;
                  });
                },
                initialValue: selectedBatch,
              ),
              const SizedBox(height: 30),
              // **Interview Details Section**
              Text('Interview Details',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal)),
              const SizedBox(height: 10),
              FormBuilderDateTimePicker(
                name: 'interviewDateTime',
                inputType: InputType.both,
                decoration: InputDecoration(
                  labelText: 'Interview Date and Time',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                format: DateFormat('yyyy-MM-dd hh:mm'),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'interviewVenue',
                decoration: InputDecoration(
                  labelText: 'Interview Venue',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderDropdown(
                name: 'campusType',
                decoration: InputDecoration(
                  labelText: 'Campus Type',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
                items: ['On Campus', 'Off Campus']
                    .map((type) =>
                    DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                validator: FormBuilderValidators.required(),
                onChanged: (value) {
                  setState(() {
                    selectedCampusType = value;
                  });
                },
                initialValue: selectedCampusType,
              ),

              const SizedBox(height: 16),

              // **URL Field**
              FormBuilderTextField(
                name: 'jobLink',
                decoration: InputDecoration(
                  labelText: 'Job Link',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link),
                ),
              ),
              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.saveAndValidate()) {
                    // Submit form data
                    final formData = _formKey.currentState!.value;
                    Get.snackbar('Success', 'Job Posted');
                    // _formKey.currentState!.reset();
                    // Reset fields to clear batch, campus type, and department
                    // setState(() {
                    //   selectedBatch = null;
                    //   selectedCampusType = null;
                    //   controller.selectedDepartments.clear();
                    // });

                    // Trigger submission logic here
                    // postTheJob();
                    Drive newDrive = Drive(
                        companyId: int.parse(formData["company"]),
                        jobRole: formData["jobTitle"],
                        requiredSkills: formData["requirements"].toString().split(","),
                        numberOfRounds: int.parse(formData["numberOfRounds"]),
                        jobType: formData["jobType"],
                        description: formData["jobDescription"],
                        location: formData["jobLocation"],
                        deadLine: formData["applicationDeadline"],
                        departments: formData["department"],
                        salary: formData["package"],
                        eligible10thMark: int.parse(formData["10thEligibility"]),
                        eligible12thMark: int.parse(formData["12thEligibility"]),
                        eligibleCgpa: double.parse(formData["cgpaEligibility"]),
                        eligibleHistoryOfArrears: int.parse(formData["HistroryOfarrearsEligibility"]),
                        eligibleCurrentArrears: int.parse(formData["StandingArrearsEligibility"]),
                        driveDate: formData["interviewDateTime"],
                        venue: formData["interviewVenue"],
                        batch: int.parse(formData["Batch"]),
                        campusMode: formData["campusType"],
                        jobLink: formData["jobLink"]
                    );

                    try{
                      bool res = await DriveRequests.createDrive(newDrive);
                      if(res){
                        Get.snackbar(
                          'Success', 'Drive Created');
                      }else{
                        Get.snackbar(
                          'Error', 'Error in creating drive');
                      }
                    }catch(e){
                      Get.snackbar(
                          'Error', 'Error in creating drive $e');
                    }
                  } else {
                    final formData = _formKey.currentState!.value;
                    print(formData);
                    List<String> sss = formData["requirements"].toString().split(",");
                    print(sss);
                    Get.snackbar(
                        'Error', 'Please complete all required fields.');
                    // Handle validation errors
                  }
                },
                child: Text('Post Job', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
