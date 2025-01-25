import 'package:final_tpc_app/app/controllers/student_pages_controller/drawer_controller/HomeScreenController/ApplyJobController/joblistController.dart';
import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/data/models/student_model.dart';
import 'package:final_tpc_app/app/ui/pages/student_pages/drawer/HomeScreen/ApplyJob/applyJob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class JobListPage extends StatelessWidget {
  final Student? studentProfile;    // Student with Application,Department
  final themeController = Get.put(ThemeController());
  final jobListController = Get.put(JobListController());

  JobListPage({super.key, required this.studentProfile});

  @override
  Widget build(BuildContext context) {
    // Set system status bar styling
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness:
            themeController.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );

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
            color: themeController.tertiaryColor,
          ),
        ),
        title: Text(
          "JOB LIST",
          style: TextStyle(color: themeController.textColor),
        ),
      ),
      backgroundColor: themeController.primaryColor,
      body: Obx(
        () {
          if (jobListController.isLoading.value) {
            // Add a delay before showing the shimmer effect
            Future.delayed(Duration(seconds: 1), () {
              if (!jobListController.isLoading.value) {
                jobListController.isLoading.value = false;
              }
            });

            return RefreshIndicator(
              onRefresh: jobListController.refreshJobList,
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  color: Colors.grey[300],
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.grey[300],
                                      height: 20,
                                      width: double.infinity,
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      color: Colors.grey[300],
                                      height: 14,
                                      width: double.infinity,
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      color: Colors.grey[300],
                                      height: 14,
                                      width: 100,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (jobListController.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                'Error: ${jobListController.errorMessage}',
                style: TextStyle(color: themeController.textColor),
              ),
            );
          } else if (jobListController.driveList.isEmpty) {
            return Center(
              child: Text(
                'No data available',
                style: TextStyle(color: themeController.textColor),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: jobListController.refreshJobList,
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: jobListController.driveList.length,
                itemBuilder: (context, index) {
                  final job = jobListController.driveList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      color: themeController.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ApplyJobPage(
                                job: job,
                                student: studentProfile!,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                      borderRadius: BorderRadius.circular(8),
  child: Image.network(
    job.company!.logoUrl,
    width: 50,
    height: 50,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      // Return a default image from assets when the image fails to load
      return Image.asset(
        'assets/images/user.jpg',  // Replace with your asset path
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    },
  ),
),

                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      job.company!.companyName,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: themeController.textColor,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      job.description ??
                                          "No description available",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: themeController.textColor
                                            .withOpacity(0.8),
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Upto ${job.salary} per annum',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: themeController.tertiaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
