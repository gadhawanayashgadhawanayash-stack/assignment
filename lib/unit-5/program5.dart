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
      home: StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  Database? database;

  List<Map<String, dynamic>> students = [];

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

    await loadStudents();
  }

  // Read all student records
  Future<void> loadStudents() async {
    if (database == null) return;

    final data = await database!.query('students');

    setState(() {
      students = data;
    });
  }

  @override
  void dispose() {
    database?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
            onPressed: loadStudents,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: students.isEmpty
          ? const Center(
        child: Text(
          'No students found',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${student['id']}'),
              ),
              title: Text(
                student['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Age: ${student['age']}',
              ),
            ),
          );
        },
      ),
    );
  }
}