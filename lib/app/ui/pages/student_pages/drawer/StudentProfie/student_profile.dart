import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controllers/student_pages_controller/drawer_controller/StudentProfileController/student_profile_controller.dart';
import '../../../../../data/models/student_model.dart';

class ProfileScreen extends StatelessWidget {
  final Student student;
  const ProfileScreen({super.key, required this.student});


  @override
  Widget build(BuildContext context) {
  final ProfileController controller = Get.put(ProfileController(student));

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Stack(
        children: [
          _buildHeader(),
          _buildMenu(context, controller),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    print(student.score10th);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 300,
        decoration: const BoxDecoration(
          color: Color(0xFF5A5A5A),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(student.profileUrl??"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtuphMb4mq-EcVWhMVT8FCkv5dqZGgvn_QiA&s"),
              onBackgroundImageError: (_, __) => const Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              student.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              student.regno!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            Text(
              'Placement Willing: ${student.placementWilling}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context, ProfileController controller) {
    return Positioned(
      top: 320,
      left: 20,
      right: 20,
      child: Column(
        children: [
          _buildMenuItem(Icons.app_registration, 'Register Number', student.regno!),
          _buildMenuItem(Icons.email, 'Email Id', student.email!),
          _buildMenuItem(Icons.phone, 'Phone Number', student.phoneNumber!),
          _buildMenuItem(Icons.person, 'Fathers Name', student.fatherName!),
          _buildMenuItem(Icons.person, 'Department', student.department!.name),
          _buildMenuItem(Icons.location_on, 'Date Of Birth', student.dob!),
          _buildDropdownMenu(controller),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 24, color: Colors.black),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownMenu(ProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Marks',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Obx(() => DropdownButton<String>(
                  isExpanded: true,
                  value: controller.selectedMarkType.value,
                  underline: const SizedBox(),
                  onChanged: controller.updateMarkType,
                  items: controller.marks.keys.map((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(
                        key,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                )),
          ),
          const SizedBox(height: 10),
          Obx(() => Text(
                'Selected: ${controller.marks[controller.selectedMarkType.value]}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              )),
        ],
      ),
    );
  }
}
