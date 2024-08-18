import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fourth/db/functions/database_helper.dart';

class EditUserDataController extends GetxController {
  final int idvalue;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final rollController = TextEditingController();
  
  final DatabaseHelper _dbHelper = DatabaseHelper();

  EditUserDataController({required this.idvalue});

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    await _dbHelper.initializeDataBase2();
    retrieveData();
  }

  Future<void> retrieveData() async {
    final data = await _dbHelper.retrieveData(idvalue);
    if (data != null) {
      nameController.text = data['name'];
      ageController.text = data['age'];
      phoneController.text = data['phone'];
      rollController.text = data['roll'];
    }
  }

  Future<void> updateUserData() async {
    await _dbHelper.updateUserData(
      idvalue,
      nameController.text,
      ageController.text,
      phoneController.text,
      rollController.text,
    );
    Get.back(result: true); // Navigate back with success result
  }
}
