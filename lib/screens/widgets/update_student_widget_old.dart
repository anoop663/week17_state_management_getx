import 'package:flutter/material.dart';
import 'package:project_fourth/db/functions/db_functions.dart';
import 'package:sqflite/sqflite.dart';

class EditUserDataPageOld extends StatefulWidget {
  final int idvalue;
  final VoidCallback refreshCallback;

  const EditUserDataPageOld({
    super.key,
    required this.idvalue,
    required this.refreshCallback,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditUserDataPageOld createState() => _EditUserDataPageOld();
}

class _EditUserDataPageOld extends State<EditUserDataPageOld> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _phoneController;
  late TextEditingController _rollController;

  late Database _db;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _phoneController = TextEditingController();
    _rollController = TextEditingController();
    initializeDataBase2();
  }

  Future<void> initializeDataBase2() async {
    WidgetsFlutterBinding.ensureInitialized();
    _db = await openDatabase(
      'student_db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, phone TEXT, roll TEXT)',
        );
      },
    );
    retrieveData();
  }

  Future<void> retrieveData() async {
    try {
      final List<Map<String, dynamic>> maps = await _db.query(
        'student',
        where: 'id = ?',
        whereArgs: [widget.idvalue],
      );
      if (maps.isNotEmpty) {
        setState(() {
          _nameController.text = maps[0]['name'];
          _ageController.text = maps[0]['age'];
          _phoneController.text = maps[0]['phone'];
          _rollController.text = maps[0]['roll'];
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error retrieving data: $e');
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _rollController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Roll Number'),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                _updateUserData();
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUserData() async {
    try {
      _db.update(
        'student',
        {
          'name': _nameController.text,
          'age': _ageController.text,
          'phone': _phoneController.text,
          'roll': _rollController.text,
        },
        where: 'id = ?',
        whereArgs: [widget.idvalue],
      );
      getAllStudents();

      Navigator.pop(context, true); 
    } catch (e) {
      // ignore: avoid_print
      print('Error updating data: $e');

      Navigator.pop(context, false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _rollController.dispose();
    super.dispose();
  }
}
