import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fourth/controllers/student_list_controller.dart';
import 'package:project_fourth/controllers/listview_helper_widgets.dart';

class ListStudentWidget extends StatelessWidget {
  final ListStudentController controller = Get.put(ListStudentController());

  ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                    controller.isGridView.value ? Icons.list : Icons.grid_view),
                onPressed: controller.toggleView,
              )),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: controller.clearSearch,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshList,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Search',
                  hintText: 'Enter student name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  controller.searchQuery.value = value;
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                final filteredList = controller.studentList.where((student) {
                  final name = student.name.toLowerCase();
                  final searchQuery =
                      controller.searchQuery.value.toLowerCase();
                  return name.contains(searchQuery);
                }).toList();

                if (filteredList.isEmpty) {
                  return buildEmptyListWidget();
                }

                return controller.isGridView.value
                    ? buildGridView(filteredList)
                    : buildListView(filteredList);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
