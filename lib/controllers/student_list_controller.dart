import 'package:get/get.dart';
import 'package:project_fourth/db/models/data_model.dart';

import '../db/functions/db_functions.dart';

class ListStudentController extends GetxController {
  var searchQuery = ''.obs;
  var isGridView = false.obs;
  var studentList = <StudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    refreshList(); // Fetch students when the controller is initialized
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  void clearSearch() {
    searchQuery.value = '';
  }

  void refreshList() async {
    final students = await getAllStudents();
    studentList.assignAll(students);
  }
}

