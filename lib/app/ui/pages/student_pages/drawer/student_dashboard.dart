import 'package:final_tpc_app/app/controllers/student_pages_controller/drawer_controller/dashboard_controller.dart';
import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/data/models/application_model.dart';
import 'package:final_tpc_app/app/data/models/student_model.dart';
import 'package:final_tpc_app/app/ui/pages/student_pages/drawer/HomeScreen/ApplyJob/jobList.dart';
import 'package:final_tpc_app/app/ui/pages/student_pages/drawer/HomeScreen/StudentJobStatus/student_job_status.dart';
import 'package:final_tpc_app/app/ui/pages/student_pages/drawer/student_menu_page.dart';
import 'package:final_tpc_app/app/utils/screen_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/loading_progress_design.dart';

class StudentDashboard extends StatelessWidget {
  final Student student;
  final ThemeController themeController = Get.find();
  StudentDashboard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context, designSize: const Size(360, 800));
    final StudentDashboardController controller = Get.put(StudentDashboardController(student));

    return Scaffold(
      body: SafeArea(
        child: ZoomDrawer(
          controller: ZoomDrawerController(),
          style: DrawerStyle.defaultStyle,
          menuScreen: MenuPage(student: student, selectedIndex: 0),
          mainScreen: buildMainScreen(controller, context),
          borderRadius: 25.0,
          angle: 0,
          mainScreenScale: 0.3,
          slideWidth: ScreenUtils.getWidth(context) * 0.7,
        ),
      ),
    );
  }

  Widget buildMainScreen(
      StudentDashboardController controller, BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Scaffold(
          backgroundColor: themeController.primaryColor,
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(ScreenUtils.getOrientationWidth(
                        context,
                        portrait: 15,
                        landscape: 10)),
                    decoration: BoxDecoration(
                      color: themeController.secondaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                ZoomDrawer.of(context)?.toggle();
                              },
                              child: Icon(Icons.menu_open,
                                  size: ScreenUtils.getOrientationWidth(context,
                                      portrait: 30, landscape: 25),
                                  color: themeController.tertiaryColor),
                            ),
                            GestureDetector(
                              // onTap: () {
                              //   controller.navigateToNotifications();
                              // },
                              child: Icon(Icons.notification_add_rounded,
                                  size: ScreenUtils.getOrientationWidth(context,
                                      portrait: 30, landscape: 25),
                                  color: themeController.tertiaryColor),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: ScreenUtils.getOrientationHeight(context,
                                portrait: 20, landscape: 15)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtils.getOrientationWidth(
                                  context,
                                  portrait: 15,
                                  landscape: 10)),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'Hello!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.white),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  controller.getGreeting(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(color: Colors.white54),
                                ),
                                SizedBox(
                                    width: ScreenUtils.getOrientationWidth(
                                        context,
                                        portrait: 5,
                                        landscape: 4)),
                                Icon(
                                  controller.getIconForGreeting(),
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                            trailing: SizedBox(
                              width: ScreenUtils.getOrientationWidth(context,
                                  portrait: 60, landscape: 50),
                              height: ScreenUtils.getOrientationHeight(context,
                                  portrait: 60, landscape: 50),
                              child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(student.profileUrl??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtuphMb4mq-EcVWhMVT8FCkv5dqZGgvn_QiA&s")),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtils.getOrientationHeight(context,
                            portrait: 20, landscape: 15),
                        left: ScreenUtils.getOrientationWidth(context,
                            portrait: 15, landscape: 10),
                        right: ScreenUtils.getOrientationWidth(context,
                            portrait: 15, landscape: 10)),
                    child: GridView.builder(
                      itemCount: controller.catName.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: ScreenUtils.getOrientationWidth(
                            context,
                            portrait: 1.1,
                            landscape: 1.2),
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (controller.catName[index] == "Co-Ord") {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => CoOrdPage()),
                              // );
                            } else if (controller.catName[index] ==
                                "Upload Status") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const StudentJobStatus()),
                              );
                            } else if (controller.catName[index] ==
                                "Apply Job") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        JobListPage(studentProfile: student)),
                              );
                            }
                          },
                          child: Column(
                            children: [
                              Container(
                                height: ScreenUtils.getOrientationHeight(
                                    context,
                                    portrait: 60,
                                    landscape: 50),
                                width: ScreenUtils.getOrientationWidth(context,
                                    portrait: 60, landscape: 50),
                                decoration: BoxDecoration(
                                  color:
                                      controller.themeController.secondaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: controller.catIcon[index],
                                ),
                              ),
                              SizedBox(
                                  height: ScreenUtils.getOrientationHeight(
                                      context,
                                      portrait: 10,
                                      landscape: 8)),
                              Text(
                                controller.catName[index],
                                style: TextStyle(
                                    fontSize: ScreenUtils.getOrientationWidth(
                                        context,
                                        portrait: 15,
                                        landscape: 13),
                                    fontWeight: FontWeight.w800,
                                    color: themeController.textColor),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                      height: ScreenUtils.getOrientationHeight(context,
                          portrait: 20, landscape: 15)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Text(
                        'Summary',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: themeController.textColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildSummaryCard(
                                'No. of Drives',
                                controller.applicationList.length,
                              ),
                              SizedBox(width: 8.w),
                              _buildSummaryCard(
                                  'Selected',
                                  controller.applicationList
                                      .where((application) =>
                                          application.status!.status == "SEL")
                                      .length),
                              SizedBox(width: 8.w),
                              _buildSummaryCard(
                                  'Waiting for Result',
                                  controller.applicationList
                                      .where((application) =>
                                          application.status!.status ==
                                          "WR")
                                      .length),
                              SizedBox(width: 8.w),
                              _buildSummaryCard(
                                  'Not Selected',
                                  controller.applicationList
                                      .where((application) =>
                                          application.status!.status == "NS")
                                      .length),
                            ],
                          ),
                        ),
                      )),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: Text(
                        'Application Status',
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: themeController.textColor),
                      ),
                    ),
                  ),
                  Obx(() => 
  Expanded(
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: controller.applicationList.isEmpty
              ? Center(child: CustomLoadingWidget(
                                        color: themeController.secondaryColor,
                                        size: 60,
                                      )) // Show loading indicator
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.applicationList.length,
                  itemBuilder: (context, index) {
                    Application application = controller.applicationList[index];

                    return _buildDriveCard(
                      title: application.drive!.company!.companyName.toUpperCase(),
                      location: application.drive!.location ?? "N/A",
                      jobType: application.drive!.jobType ?? "N/A",
                      role: application.drive!.jobRole,
                      salary: application.drive!.salary ?? "N/A",
                      tag: application.drive!.venue ?? "N/A",
                      status: application.status!.status,
                    );
                  },
                ),
          ),
        ],
      ),
    ),
  ),
),

                ],
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildSummaryCard(String title, int count) {
    final controller = Get.find<StudentDashboardController>();

    return Container(
      width: 200.w,
      height: 60.h,
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        color: themeController.isDarkMode
            ? const Color(0xFF5A5A5A)
            : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            // Replace `controller` with your actual controller instance
            final icon = controller.companyStatusIcons[title] ?? Icons.help;
            final color = controller.companyStatusColors[title] ?? Colors.black;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24.sp,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: themeController.textColor),
                ),
                Text(
                  '$count',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w900,
                      color: themeController.textColor),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDriveCard({
  required String title,
  required String location,
  required String jobType,
  required String role,
  required String salary,
  required String tag,
  required String status,
}) {
  return Obx(() {
    return Card(
      elevation: 4,
      color: themeController.isDarkMode
          ? const Color(0xFF5A5A5A)
          : const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.all(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: themeController.textColor)),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(status,
                      style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(location,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                SizedBox(width: 4.w),
                Text(jobType,
                    style: TextStyle(
                        fontSize: 14.sp, color: themeController.textColor)),
              ],
            ),
            SizedBox(height: 8.h),
            Text(role,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: themeController.textColor)),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(salary,
                    style: TextStyle(fontSize: 14.sp, color: Colors.green)),
                Text(tag,
                    style: TextStyle(fontSize: 14.sp, color: Colors.orange)),
              ],
            ),
          ],
        ),
      ),
    );
  });
}

}
