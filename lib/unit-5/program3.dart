
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
      home: ProductDatabaseScreen(),
    );
  }
}

class ProductDatabaseScreen extends StatefulWidget {
  const ProductDatabaseScreen({super.key});

  @override
  State<ProductDatabaseScreen> createState() =>
      _ProductDatabaseScreenState();
}

class _ProductDatabaseScreenState
    extends State<ProductDatabaseScreen> {
  Database? database;
  String message = 'Creating database...';

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  // Create SQLite database and products table
  Future<void> createDatabase() async {
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, 'shop.db');

      database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE products (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              price REAL NOT NULL
            )
          ''');
        },
      );

      setState(() {
        message = 'Database and products table created successfully!';
      });
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
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
        title: const Text('SQLite Products Database'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.storage,
                size: 70,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}