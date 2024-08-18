import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fourth/controllers/edit_user_data_controller.dart';


class EditUserDataPage2 extends StatelessWidget {
  final int idvalue;

  const EditUserDataPage2({super.key, required this.idvalue, required void Function() refreshCallback});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditUserDataController(idvalue: idvalue));

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
