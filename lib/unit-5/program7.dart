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
      home: DeleteStudentScreen(),
    );
  }
}

class DeleteStudentScreen extends StatefulWidget {
  const DeleteStudentScreen({super.key});

  @override
  State<DeleteStudentScreen> createState() =>
      _DeleteStudentScreenState();
}

class _DeleteStudentScreenState
    extends State<DeleteStudentScreen> {
  Database? database;

  final idController = TextEditingController();

  String message = '';

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  // Create database and students table
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

  // Delete student record
  Future<void> deleteStudent() async {
    if (database == null) return;

    final id = int.tryParse(idController.text.trim());

    if (id == null) {
      setState(() {
        message = 'Please enter a valid ID';
      });
      return;
    }

    final count = await database!.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );

    setState(() {
      if (count > 0) {
        message = 'Student deleted successfully!';
      } else {
        message = 'Student with ID $id not found';
      }
    });

    idController.clear();
  }

  @override
  void dispose() {
    idController.dispose();
    database?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Student'),
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

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: deleteStudent,
              child: const Text('Delete Student'),
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