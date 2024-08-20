import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fourth/db/models/data_model.dart';
import 'package:project_fourth/screens/widgets/add_student_widget.dart';
import 'package:project_fourth/screens/widgets/list_student_widget.dart';
import 'package:project_fourth/screens/widgets/update_student_widget.dart';
import 'package:project_fourth/screens/widgets/view_student_widget.dart';
import 'package:project_fourth/db/functions/db_functions.dart';

class Routes {
  static const String addStudent = '/addstudent';
  static const String listStudent = '/liststudent';
  static const String updateStudent = '/updatestudent';
  static const String viewStudent = '/viewstudent';

  static final List<GetPage> pages = [
    GetPage(name: addStudent, page: () => AddStudentWidget()),
    GetPage(name: listStudent, page: () => ListStudentWidget()),
    GetPage(
      name: updateStudent,
      page: () {
        final id = int.tryParse(Get.parameters['id'] ?? '0') ?? 0;
        return EditUserDataPage2(
          idvalue: id,
          refreshCallback: () {},
        );
      },
    ),
    GetPage(
      name: viewStudent,
      page: () {
        final id = int.tryParse(Get.parameters['id'] ?? '0') ?? 0;
        return FutureBuilder<StudentModel?>(
          future: getStudentById(id),
          builder: (context, snapshot) {
             if (snapshot.hasData) {
              final student = snapshot.data;
              return ViewStudentWidget(student: student!);
            } else {
              return const Center(child: Text('Student not found'));
            }
          },
        );
      },
    ),
  ];
}
