import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void navigateToNextScreen() {
   // Get.to(() => ListStudentWidget());
   Get.toNamed('/list_student');
  }

  void showUserProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('User Profile'),
          content: SizedBox(
            height: 150,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: const Text('User1'),
                  subtitle: const Text('Admin User'),
                  leading: Image.network(
                      'https://www.shutterstock.com/image-vector/young-smiling-man-avatar-brown-600nw-2261401207.jpg'),
                  trailing: IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                       Get.back(); 
                      confirmExit(context);
                    },
                  ),
                ),
                const Divider(color: Colors.black),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void confirmExit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Exit"),
          content: const Text("Are you sure you want to exit?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                 Get.back();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                if (Platform.isAndroid || Platform.isIOS) {
                  exit(0); 
                }
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

