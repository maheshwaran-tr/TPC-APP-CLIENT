import 'package:final_tpc_app/app/controllers/student_pages_controller/drawer_controller/HomeScreenController/ApplyJobController/applyJobController.dart';
import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:final_tpc_app/app/data/models/student_model.dart';

import '../../../../../../data/models/drive_model.dart';

class ApplyJobPage extends StatelessWidget {
  final Student student;  // Student with Applications,Department
  final Drive job;   // Drive with Company, Applications
  final themeController = Get.put(ThemeController());
  ApplyJobPage({super.key, required this.student, required this.job}) {
    final ApplyJobController controller = Get.put(ApplyJobController());
    controller.initialize(student);
  }

  @override
  Widget build(BuildContext context) {
    final ApplyJobController controller = Get.find<ApplyJobController>();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness:
            themeController.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    // Reactive variable to track active tab
    final RxInt activeTab = 0.obs;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeController.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: themeController.textColor,
          ),
        ),
        title: Text(
          "Apply Job",
          style: TextStyle(color: themeController.textColor),
        ),
      ),
      backgroundColor: themeController.primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40.r,
                backgroundImage: AssetImage('assets/images/ill.png'),
              ),
            ),
            SizedBox(height: 16.h),
            Center(
              child: Text(
                job.jobRole,
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: themeController.textColor),
              ),
            ),
            Center(
              child: Text(
                job.company!.companyName,
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color:
                      themeController.isDarkMode ? Colors.white70 : Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDetailItem('Location', job.venue ?? "N/A"),
                _buildDetailItem('Job Type', job.jobType ?? "N/A"),
                _buildDetailItem('Campus Type', job.campusMode ?? "N/A"),
              ],
            ),
            SizedBox(height: 24.h),
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        activeTab.value = 0; // Switch to Description tab
                      },
                      child: Obx(() {
                        return Container(
                          decoration: BoxDecoration(
                            color: activeTab.value == 0
                                ? themeController.secondaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              'Description',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: activeTab.value == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        activeTab.value = 1; // Switch to Company tab
                      },
                      child: Obx(() {
                        return Container(
                          decoration: BoxDecoration(
                            color: activeTab.value == 1
                                ? themeController.secondaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              'Company',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: activeTab.value == 1
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Obx(() {
              // Switch between Description and Company content
              if (activeTab.value == 0) {
                return Text(
                  job.description ?? "N/A",
                  style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      height: 1.5,
                      color: themeController.textColor),
                );
              } else {
                return Text(
                  'Company Details: ${job.description ?? "No details available"}',
                  style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      height: 1.5,
                      color: themeController.textColor),
                );
              }
            }),
            SizedBox(height: 16.h),
            Text(
              'Requirements',
              style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: themeController.textColor),
            ),
            SizedBox(height: 8.h),
            ...job.requiredSkills!.map((requirement) {
              return _buildRequirementItem(requirement);
            }),
            Spacer(),
            Obx(() {
              final isEligible = controller.checkEligibility(student, job);

              return ElevatedButton(
                onPressed: () {
                  if (isEligible) {
                    controller.applyJob(
                        student.studentId.toString(), job.driveId.toString());
                  } else {
                    Get.snackbar(
                      "Not Eligible",
                      "You do not meet the eligibility criteria for this job.",
                      backgroundColor: Colors.red.shade50,
                      colorText: Colors.red,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEligible
                      ? themeController.secondaryColor
                      : Colors.grey.shade400,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: controller.isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        isEligible ? 'Apply Job' : 'Not Eligible',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              );
            }),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: themeController.isDarkMode ? Colors.white70 : Colors.black54,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: themeController.textColor),
        ),
      ],
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20.r),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  height: 1.5,
                  color: themeController.textColor),
            ),
          ),
        ],
      ),
    );
  }
}
