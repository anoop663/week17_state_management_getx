import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_fourth/controllers/add_student_controller.dart';
import 'package:project_fourth/controllers/edit_user_data_controller.dart';

class EditUserDataPage2 extends StatelessWidget {
  final int idvalue;
  final StudentController studentController = Get.put(StudentController());

  EditUserDataPage2(
      {super.key,
      required this.idvalue,
      required void Function() refreshCallback});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditUserDataController(idvalue: idvalue));

    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _pickImage(BuildContext context) async {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        controller.selectedImage(File(pickedImage.path));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image selected successfully'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.ageController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.phoneController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.rollController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Roll Number'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                _pickImage(context);
              },
              child: const Text('Update Image'),
            ),
            const SizedBox(height: 10),
            Obx(
              () {
                final image = controller.selectedImage.value;
                return image != null
                    ? Image.file(image,
                        height: 100, width: 100, fit: BoxFit.cover)
                    : const Text('No image selected');
              },
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                controller.updateUserData();
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
