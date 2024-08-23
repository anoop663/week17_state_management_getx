import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database _db;

  Future<void> initializeDataBase2() async {
    WidgetsFlutterBinding.ensureInitialized();
    _db = await openDatabase(
      'student_db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, phone TEXT, roll TEXT, imagePath TEXT)',
        );
      },
    );
  }

  Future<Map<String, dynamic>?> retrieveData(int idvalue) async {
    try {
      final List<Map<String, dynamic>> maps = await _db.query(
        'student',
        where: 'id = ?',
        whereArgs: [idvalue],
      );
      if (maps.isNotEmpty) {
        return maps[0];
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error retrieving data: $e');
    }
    return null;
  }

  Future<void> updateUserData(int idvalue, String name, String age, String phone, String roll, String imagePath) async {
    try {
      await _db.update(
        'student',
        {
          'name': name,
          'age': age,
          'phone': phone,
          'roll': roll,
          'imagePath': imagePath,
        },
        where: 'id = ?',
        whereArgs: [idvalue],
      );
    } catch (e) {
      // ignore: avoid_print
      print('Error updating data: $e');
    }
  }
}
