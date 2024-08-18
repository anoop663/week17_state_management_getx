
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fourth/controllers/student_list_controller.dart';
import 'package:project_fourth/db/models/data_model.dart';
import 'package:project_fourth/screens/widgets/student_delete_alert_pop.dart';
import 'package:project_fourth/screens/widgets/update_student_widget.dart';
import 'package:project_fourth/screens/widgets/view_student_widget.dart';


Widget buildEmptyListWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'List is Empty',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Add Student'),
          ),
        ],
      ),
    );
  }

  Widget buildListView(List<StudentModel> filteredList) {
    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (ctx, index) {
        final data = filteredList[index];
        return buildListTile(data);
      },
    );
  }

  Widget buildGridView(List<StudentModel> filteredList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: filteredList.length,
      itemBuilder: (ctx, index) {
        final data = filteredList[index];
        return buildGridTile(data);
      },
    );
  }

  Widget buildListTile(StudentModel data) {
    return ListTile(
      leading: Image.asset('lib/assets/student1.png'),
      title: Text(data.name),
      subtitle: Row(
        children: [
          const SizedBox(width: 10),
          TextButton(
            onPressed: () async {
              if (data.id != null) {
                final result = await Get.to(() => EditUserDataPage2(
                      idvalue: data.id!, refreshCallback: () {  },
                    ));

                if (result == true) {
                  Get.find<ListStudentController>().refreshList();
                }
              } else {
                // ignore: avoid_print
                print('The Id value of the data is null');
              }
            },
            child: const Text('Edit'),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              if (data.id != null) {
                Get.to(() => ViewStudentWidget(student: data));
              } else {
              // ignore: avoid_print
                print('The Id value of the data is null');
              }
            },
            child: const Text('View'),
          ),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          if (data.id != null) {
            AlertPopup(itemId: data.id!).showAlertDialog(Get.context!);
          } else {
          // ignore: avoid_print
            print('Student ID is null, unable to delete');
          }
        },
      ),
    );
  }

  Widget buildGridTile(StudentModel data) {
    return GridTile(
      child: Card(
        child: InkWell(
          onTap: () {
            if (data.id != null) {
              Get.to(() => ViewStudentWidget(student: data));
            } else {
              // ignore: avoid_print
              print('The Id value of the data is null');
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.asset(
                  'lib/assets/student1.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


