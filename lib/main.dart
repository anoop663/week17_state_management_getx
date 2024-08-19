import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fourth/controllers/routes.dart';
import 'package:project_fourth/db/functions/db_functions.dart';

Future<void> main() async {
  await initializeDataBase();
  runApp(const FourthApp());
}

class FourthApp extends StatelessWidget {
  const FourthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home:  const ScreenHome(),
      initialRoute: Routes.addStudent,
      getPages: Routes.pages,
    );
  }
}
