import 'package:flutter/material.dart';
import 'package:project_fourth/db/models/data_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
late Database _db;

Future<void> initializeDataBase() async {
  WidgetsFlutterBinding.ensureInitialized();
  _db = await openDatabase(
    'student_db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT, age TEXT, phone TEXT, roll TEXT)');
    },
  );
  getAllStudents();
}

Future<void> addStudent(StudentModel value) async {
  await _db.rawInsert(
    'INSERT INTO student (id, name, age, phone, roll) VALUES (?, ?, ?, ?, ?)',
    [value.id, value.name, value.age, value.phone, value.roll],
  );
  getAllStudents();
}

Future<List<StudentModel>> getAllStudents() async {
  // ignore: no_leading_underscores_for_local_identifiers
  final _values = await _db.rawQuery('SELECT * FROM student');
  final List<StudentModel> students = [];
  for (var map in _values) {
    final student = StudentModel.fromMap(map);
    students.add(student);
  }
  return students;
}

Future<void> deleteStudents(int id) async {
  try {
    final rowsAffected =
        await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
    // ignore: avoid_print
    print('Rows affected: $rowsAffected');
    getAllStudents();
  } catch (e) {
    // ignore: avoid_print
    print('Error deleting student: $e');
  }
}



