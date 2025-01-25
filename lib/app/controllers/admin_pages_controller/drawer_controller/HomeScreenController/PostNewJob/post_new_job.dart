import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class PostNewJob extends StatefulWidget {
  const PostNewJob({super.key});

  @override
  _PostNewJobState createState() => _PostNewJobState();
}

class _PostNewJobState extends State<PostNewJob> {
  final _formKey = GlobalKey<FormBuilderState>();
  XFile? _companyLogo; // Variable to hold the image

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickCompanyLogo() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _companyLogo = pickedFile;
      });
    }
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
                  labelText: 'Requirements',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.checklist),
                ),
                maxLines: 3,
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
                inputType: InputType.date,
                decoration: InputDecoration(
                  labelText: 'Application Deadline',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                format: DateFormat('yyyy-MM-dd'),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderDropdown(
                name: 'department',
                decoration: InputDecoration(
                  labelText: 'Department/Field of Study',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
                items: [
                  'Computer Science',
                  'Mechanical',
                  'Electrical',
                  'Civil',
                  'Business'
                ]
                    .map((field) =>
                        DropdownMenuItem(value: field, child: Text(field)))
                    .toList(),
                validator: FormBuilderValidators.required(),
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
              const SizedBox(height: 30),

              // **Interview Details Section**
              Text('Interview Details',
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal)),
              const SizedBox(height: 10),
              FormBuilderDateTimePicker(
                name: 'interviewDate',
                inputType: InputType.date,
                decoration: InputDecoration(
                  labelText: 'Interview Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                format: DateFormat('yyyy-MM-dd'),
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
              ),
              const SizedBox(height: 16),

              // **Company Logo (Image Picker)**
              GestureDetector(
                onTap: _pickCompanyLogo,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.teal.withOpacity(0.1),
                  ),
                  child: _companyLogo == null
                      ? Center(child: Text("Select Company Logo"))
                      : Image.file(
                          File(_companyLogo!.path),
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // **Attachment Section**
              FormBuilderFilePicker(
                name: 'attachments',
                decoration: InputDecoration(
                  labelText: 'Attachments',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_file),
                ),
                allowMultiple: true,
                allowedExtensions: ['pdf', 'docx', 'jpg', 'png'],
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 30),

              // **Preview and Post Button**
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.saveAndValidate()) {
                    final formData = _formKey.currentState!.value;
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: SingleChildScrollView(
                          // Add SingleChildScrollView here
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Preview Job Post',
                                  style: GoogleFonts.lato(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Job details list
                                Column(
                                  children: formData.entries
                                      .map(
                                        (e) => Card(
                                          color: Colors.teal.withOpacity(0.1),
                                          elevation: 2,
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.info_outline,
                                                  color: Colors.teal,
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    '${e.key}: ${e.value}',
                                                    style: GoogleFonts.lato(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // Cancel button
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      child: Text(
                                        'Close',
                                        style: GoogleFonts.lato(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    // Post Job button
                                    ElevatedButton(
                                      onPressed: () async {
                                        // Add job posting logic here

                                        print("Job Posted!");
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Job posted successfully!'),
                                          ),
                                        );
                                        Navigator.pop(context); // Close preview
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      child: Text(
                                        'Post Job',
                                        style: GoogleFonts.lato(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Please complete all required fields.')),
                    );
                  }
                },
                child: Text('Preview and Post',
                    style: GoogleFonts.lato(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
