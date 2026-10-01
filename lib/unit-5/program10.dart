import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const FileStorageScreen(),
    );
  }
}

class FileStorageScreen extends StatefulWidget {
  const FileStorageScreen({super.key});

  @override
  State<FileStorageScreen> createState() => _FileStorageScreenState();
}

class _FileStorageScreenState extends State<FileStorageScreen> {
  final TextEditingController controller = TextEditingController();

  String savedText = '';

  Future<File> getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/myfile.txt');
  }

  Future<void> writeText() async {
    final file = await getLocalFile();

    await file.writeAsString(controller.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Text saved successfully!'),
      ),
    );
  }

  Future<void> readText() async {
    final file = await getLocalFile();

    if (await file.exists()) {
      final text = await file.readAsString();

      setState(() {
        savedText = text;
      });
    } else {
      setState(() {
        savedText = 'File not found';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Storage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: writeText,
              child: const Text('Write to File'),
            ),

            ElevatedButton(
              onPressed: readText,
              child: const Text('Read from File'),
            ),

            const SizedBox(height: 20),

            Text(
              'Saved Text:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              savedText,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}