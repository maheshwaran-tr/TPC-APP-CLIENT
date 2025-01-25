import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentJobStatus extends StatelessWidget {
  const StudentJobStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          CupertinoIcons.back,
          color: CupertinoColors.activeBlue,
        ),
        centerTitle: true,
        title: const Text(
          'ZoHo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            buildTextField(
              label: "Job ID",
              initialValue: "62489335479656",
            ),
            const SizedBox(height: 20),
            buildTextField(
              label: "Company Name",
              initialValue: "ZOHO",
            ),
            const SizedBox(height: 20),
            buildTextField(
              label: "Role",
              initialValue: "Software Developer",
            ),
            const SizedBox(height: 20),
            buildDropdownField(
              label: "Status",
              items: ['Selected', 'Pending', 'Rejected'],
              value: 'Selected',
            ),
            const SizedBox(height: 30),
            const Text(
              "Upload",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              dashPattern: const [6, 3],
              color: CupertinoColors.systemGrey,
              child: Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.cloud_upload,
                      color: CupertinoColors.systemGrey,
                      size: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Upload your Proof",
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton.filled(
                onPressed: () {},
                child: const Text("Update"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({required String label, required String initialValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        CupertinoTextField(
          controller: TextEditingController(text: initialValue),
          readOnly: true,
          decoration: BoxDecoration(
            color: CupertinoColors.extraLightBackgroundGray,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: CupertinoColors.systemGrey4),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownField({
    required String label,
    required List<String> items,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: CupertinoColors.extraLightBackgroundGray,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: CupertinoColors.systemGrey4),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: const SizedBox(),
            value: value,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (newValue) {},
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
