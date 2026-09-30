import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FileReadScreen(),
    );
  }
}

class FileReadScreen extends StatefulWidget {
  @override
  State<FileReadScreen> createState() =>
      _FileReadScreenState();
}

class _FileReadScreenState extends State<FileReadScreen> {
  String fileContent = "";

  Future<void> readFile() async {
    final directory =
    await getApplicationDocumentsDirectory();

    final file = File(
      '${directory.path}/hello.txt',
    );

    final content = await file.readAsString();

    setState(() {
      fileContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read File"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: readFile,
              child: Text("Read File"),
            ),
            SizedBox(height: 30),
            Text(
              fileContent,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}