import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_fourth/controllers/add_student_controller.dart';
import 'package:project_fourth/db/functions/db_functions.dart';
import 'package:project_fourth/db/models/data_model.dart';

class AddStudentWidget extends StatelessWidget {
  AddStudentWidget({super.key});

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _rollController = TextEditingController();

  final StudentController studentController = Get.put(StudentController());

  Future<void> _pickImage(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      studentController.setImage(File(pickedImage.path));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image selected successfully'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Handle user profile dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Age',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Age is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _rollController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Roll Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Roll number is Empty';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: () {
                    _pickImage(context);
                  },
                  child: const Text('Upload Image'),
                ),
                const SizedBox(height: 10),
                Obx(() {
                  final image = studentController.selectedImage.value;
                  return image != null
                      ? Image.file(image,
                          height: 100, width: 100, fit: BoxFit.cover)
                      : const Text('No image selected');
                }),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          onAddStudentButtonClicked(context);
                        },
                        child: const Text('Add Information'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Get.toNamed('/liststudent');
                        },
                        child: const Text('View Student List'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final age = _ageController.text.trim();
      final phone = _phoneController.text.trim();
      final roll = _rollController.text.trim();

      final image =
          studentController.selectedImage.value?.path;

      final student = StudentModel(
        name: name,
        age: age,
        phone: phone,
        roll: roll,
        imagePath: image,
      );

      addStudent(student);

      _nameController.clear();
      _ageController.clear();
      _phoneController.clear();
      _rollController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student information added successfully'),
        ),
      );

      studentController.setImage(null);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields correctly'),
        ),
      );
    }
  }
}
