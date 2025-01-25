// department_list.dart

import 'package:final_tpc_app/app/services/pdf_downloader.dart';
import 'package:final_tpc_app/app/ui/pages/admin_pages/drawer/HomeScreen/DeptStudentList/dept_student_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/admin_pages_controller/drawer_controller/HomeScreenController/DeptStudentListController/deptmart_list_controller.dart';
import '../../../../../../controllers/theme_controller/app_color_controller.dart';
import '../../../../../widgets/loading_progress_design.dart';

class DepartmentList extends StatelessWidget {
  const DepartmentList({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller using Get.put to make it accessible in the widget tree
    ThemeController themecontroller = Get.put(ThemeController());

    final DepartmentController controller = Get.put(DepartmentController());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: themecontroller.primaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: themecontroller.textColor,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Department List",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: themecontroller.textColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        DownloadResponse res = await downloadPdf();
                        print(res.message);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(res.message)),
                        );
                      },
                      icon: Icon(
                        Icons.download_sharp,
                        size: 20,
                        color: themecontroller.textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: controller.filterDepartmentsBySearch,
                  decoration: InputDecoration(
                    hintText: 'Search department',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Obx(() {
                    if (controller.isLoaded.value) {
                      if (controller.departments.isEmpty) {
                        return Center(
                          child: Text(
                            "No departments found",
                            style: TextStyle(
                                fontSize: 16, color: themecontroller.textColor),
                          ),
                        );
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: controller.filteredDept.length,
                          itemBuilder: (context, index) {
                            final department = controller.filteredDept[index];

                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => DeptStudentList(
                                    department: department['name']!,
                                    departmentId: department['id']!,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(department['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                      colors: [
                                        themecontroller.isDarkMode
                                            ? Colors.black.withOpacity(0.6)
                                            : Colors
                                                .transparent, // Change for light mode
                                        themecontroller.isDarkMode
                                            ? Colors.white.withOpacity(0.6)
                                            : Colors
                                                .transparent, // Change for light mode
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  child: Text(
                                    department['name']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: themecontroller.isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return Center(
                          child: CustomLoadingWidget(
                        color: themecontroller.secondaryColor,
                        size: 40,
                      ));
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
