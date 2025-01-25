// department_list.dart

import 'package:final_tpc_app/app/ui/pages/admin_pages/drawer/HomeScreen/NonWillingList/dept_student_nonwilling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/admin_pages_controller/drawer_controller/HomeScreenController/NonWillingController/department_list_controller.dart';
import '../../../../../../controllers/theme_controller/app_color_controller.dart';

class DepartmentList extends StatelessWidget {
  const DepartmentList({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate the controller using Get.put to make it accessible in the widget tree
    Get.put(ThemeController());

    final DepartmentController controller = Get.put(DepartmentController());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Department List",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
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
                            style: TextStyle(fontSize: 16, color: Colors.grey),
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
                            print(index);
                            final department = controller.filteredDept[index];
                            print(
                                "******************DEPT NAV##################");
                            print(department[index]);
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => DeptNonWillingStudentList(
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
                                        Colors.black.withOpacity(0.6),
                                        Colors.transparent,
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
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
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
