import 'dart:io';
import 'package:get/get.dart';

class StudentController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);

  void setImage(File? image) {
    selectedImage.value = image;
  }
}