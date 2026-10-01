import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UpdateStudentScreen(),
    );
  }
}

class UpdateStudentScreen extends StatefulWidget {
  const UpdateStudentScreen({super.key});

  @override
  State<UpdateStudentScreen> createState() =>
      _UpdateStudentScreenState();
}

class _UpdateStudentScreenState
    extends State<UpdateStudentScreen> {
  Database? database;

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  String message = '';

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  // Create database and table
  Future<void> initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'students.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            age INTEGER NOT NULL
          )
        ''');
      },
    );

    setState(() {
      message = 'Database ready';
    });
  }

  // Update student record
  Future<void> updateStudent() async {
    if (database == null) return;

    final id = int.tryParse(idController.text.trim());
    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text.trim());

    if (id == null || name.isEmpty || age == null || age <= 0) {
      setState(() {
        message = 'Please enter valid details';
      });
      return;
    }

    final count = await database!.update(
      'students',
      {
        'name': name,
        'age': age,
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    setState(() {
      if (count > 0) {
        message = 'Student updated successfully!';
      } else {
        message = 'Student with ID $id not found';
      }
    });

    idController.clear();
    nameController.clear();
    ageController.clear();
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    ageController.dispose();
    database?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Student ID',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'New Student Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'New Age',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: updateStudent,
              child: const Text('Update Student'),
            ),

            const SizedBox(height: 20),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}