import 'package:flutter/material.dart';
import 'package:project_fourth/db/functions/db_functions.dart';
import 'package:project_fourth/screens/widgets/add_student_widget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Student Information',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
           body:AddStudentWidget(),
    );
  }
}
