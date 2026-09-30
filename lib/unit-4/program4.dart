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
      home: FileCheckScreen(),
    );
  }
}

class FileCheckScreen extends StatefulWidget {
  @override
  State<FileCheckScreen> createState() =>
      _FileCheckScreenState();
}

class _FileCheckScreenState extends State<FileCheckScreen> {
  String message = "";

  Future<void> checkFile() async {
    final directory =
    await getApplicationDocumentsDirectory();

    final file = File(
      '${directory.path}/hello.txt',
    );

    if (await file.exists()) {
      final content = await file.readAsString();

      setState(() {
        message = "File exists.\n\nContent:\n$content";
      });
    } else {
      setState(() {
        message = "File does not exist.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check File Exists"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: checkFile,
                child: Text("Check File"),
              ),
              SizedBox(height: 30),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}