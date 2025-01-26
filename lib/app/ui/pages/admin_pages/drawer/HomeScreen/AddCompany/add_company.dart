import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/admin_pages_controller/drawer_controller/HomeScreenController/CompanyController/add_company.dart';

class AddCompanyPage extends StatelessWidget {
  AddCompanyPage({super.key});

  // Use GetX controller
  final AddCompanyController controller = Get.put(AddCompanyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Company'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Full Name Field
                Obx(() => TextFormField(
                      initialValue: controller.fullName.value,
                      onChanged: (value) => controller.fullName.value = value,
                      decoration: InputDecoration(
                        labelText: 'Full Name of Company',
                        prefixIcon: const Icon(Icons.business,
                            color: Colors.deepOrangeAccent),
                        border: const OutlineInputBorder(),
                      ),
                    ).animate().fadeIn(duration: 500.ms)),

                const SizedBox(height: 20),

                // Short Name Field
                Obx(() => TextFormField(
                      initialValue: controller.shortName.value,
                      onChanged: (value) => controller.shortName.value = value,
                      decoration: InputDecoration(
                        labelText: 'Short Name of Company',
                        prefixIcon: const Icon(Icons.short_text,
                            color: Colors.deepOrangeAccent),
                        border: const OutlineInputBorder(),
                      ),
                    ).animate().fadeIn(duration: 500.ms)),

                const SizedBox(height: 20),

                // Image Picker for logo
                GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: Colors.deepOrangeAccent, width: 2),
                      color: Colors.deepOrange.shade50,
                    ),
                    child: Obx(() => controller.image.value == null
                        ? const Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 60,
                              color: Colors.deepOrangeAccent,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(controller.image.value!,
                                fit: BoxFit.cover),
                          )),
                  ),
                ).animate().fadeIn(duration: 700.ms),

                const SizedBox(height: 30),

                // Add Button
                Center(
                  child: ElevatedButton.icon(
                    onPressed: controller.addCompany,
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('Add Company'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ).animate().slide(duration: 700.ms),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
