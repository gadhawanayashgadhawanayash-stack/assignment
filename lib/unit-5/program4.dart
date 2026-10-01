
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
      home: StudentInsertScreen(),
    );
  }
}

class StudentInsertScreen extends StatefulWidget {
  const StudentInsertScreen({super.key});

  @override
  State<StudentInsertScreen> createState() =>
      _StudentInsertScreenState();
}

class _StudentInsertScreenState
    extends State<StudentInsertScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  Database? database;
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

  // Insert student record
  Future<void> insertStudent() async {
    if (database == null) return;

    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text.trim());

    if (name.isEmpty || age == null || age <= 0) {
      setState(() {
        message = 'Please enter a valid name and age';
      });
      return;
    }

    await database!.insert(
      'students',
      {
        'name': name,
        'age': age,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    setState(() {
      message = 'Student inserted successfully!';
    });

    nameController.clear();
    ageController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    database?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Student Age',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: insertStudent,
              child: const Text('Insert Student'),
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