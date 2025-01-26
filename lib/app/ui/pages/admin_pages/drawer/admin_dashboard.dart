import 'package:final_tpc_app/app/controllers/admin_pages_controller/drawer_controller/admin_dashboard_controller.dart';
import 'package:final_tpc_app/app/controllers/theme_controller/app_color_controller.dart';
import 'package:final_tpc_app/app/data/models/admin_model.dart';
import 'package:final_tpc_app/app/ui/pages/admin_pages/drawer/HomeScreen/AddCompany/add_company.dart';
import 'package:final_tpc_app/app/ui/pages/admin_pages/drawer/HomeScreen/DeptStudentList/department_list.dart' as dept_student_list;
import 'package:final_tpc_app/app/ui/pages/admin_pages/drawer/HomeScreen/NonWillingList/department_list.dart' as dept_student_nonwilling_list;
import 'package:final_tpc_app/app/ui/pages/admin_pages/drawer/admin_menupage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:final_tpc_app/app/utils/screen_utils.dart';

import 'HomeScreen/JobPost/jobpost.dart'; // Importing ScreenUtils

class AdminDash extends StatelessWidget {
  final Admin admin;
  final ThemeController themeController = Get.find();
  AdminDash({super.key, required this.admin});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 800));
    final AdminDashboardController controller =
        Get.put(AdminDashboardController(admin));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ZoomDrawer(
          controller: ZoomDrawerController(),
          style: DrawerStyle.defaultStyle,
          menuScreen: AdminMenuPage(admin: admin, selectedIndex: 0),
          mainScreen: buildMainScreen(controller, context),
          borderRadius: 25.r,
          angle: 0,
          mainScreenScale: 0.3,
          slideWidth: 0.7.sw,
        ),
      ),
    );
  }

  Widget buildMainScreen(
      AdminDashboardController controller, BuildContext context) {
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
                    padding: EdgeInsets.all(15.w),
                    decoration: BoxDecoration(
                      color: themeController.secondaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r),
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
                                  size: 30.sp,
                                  color: themeController.tertiaryColor),
                            ),
                            GestureDetector(
                              child: Icon(Icons.notification_add_rounded,
                                  size: 30.sp,
                                  color: themeController.tertiaryColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'Hello!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: themeController.textColor),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  controller.greeting(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                          color: themeController.textColor),
                                ),
                                SizedBox(width: 5.w),
                                Icon(
                                  controller.greetingIcon(),
                                  color: themeController.textColor,
                                  size: 20.sp,
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
                                      NetworkImage(admin.profileUrl??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtuphMb4mq-EcVWhMVT8FCkv5dqZGgvn_QiA&s")),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                    child: GridView.builder(
                      itemCount: controller.catNames.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.1,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (controller.catNames[index] ==
                                "Dept Student List") {
                              Get.to(() => dept_student_list.DepartmentList());
                            } else if (controller.catNames[index] ==
                                "Post Job") {
                              Get.to(() => PostNewJob());
                            } else if (controller.catNames[index] ==
                                "Non Willing Students") {
                              Get.to(() => dept_student_nonwilling_list.DepartmentList());
                            }else if (controller.catNames[index] ==
                                "Add Staff") {
                              Get.to(() => AddCompanyPage());
                            }
                            // Future navigation code placeholder
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 60.w,
                                width: 60.w,
                                decoration: BoxDecoration(
                                  color: themeController.secondaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: controller.catIcons[index],
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Expanded(
                                child: Text(
                                  controller.catNames[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                      color: themeController.textColor),
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Center(
                      child: Text(
                        "STUDENT STATUS ",
                        style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w900,
                            color: themeController.textColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.w,
                          mainAxisSpacing: 10.h,
                          children: [
                            itemDashboard(
                                'Job Selected Students Approval ',
                                CupertinoIcons.rectangle_stack_person_crop_fill,
                                themeController.secondaryColor),
                            itemDashboard(
                                'Job Selected List',
                                CupertinoIcons.briefcase_fill,
                                themeController.secondaryColor),
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

  Widget itemDashboard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _navigateToCategory(title),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategory(String category) {
    Get.to(() => AddCompanyPage());
    // if (category == "Add Staff") {
    //   Get.to(() => AddStaffPage());
    // } else if (category == "Dept Student List") {
    //   Get.to(() => DepartmentStudentListPage());
    // }
    // Add additional navigation as required
  }
}
