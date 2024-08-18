import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fourth/db/functions/db_functions.dart';
import 'package:project_fourth/controllers/student_list_controller.dart';

class AlertPopup extends StatelessWidget {
  final int itemId;

  const AlertPopup({super.key, required this.itemId});

  Future<void> showAlertDialog(BuildContext context) async {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed: () {
        deleteStudents(itemId);
        Get.find<ListStudentController>().refreshList();
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Data"),
      content: const Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
