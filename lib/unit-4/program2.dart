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
      home: FileWriteScreen(),
    );
  }
}

class FileWriteScreen extends StatefulWidget {
  @override
  State<FileWriteScreen> createState() =>
      _FileWriteScreenState();
}

class _FileWriteScreenState extends State<FileWriteScreen> {
  String message = "";

  Future<void> writeFile() async {
    final directory =
    await getApplicationDocumentsDirectory();

    final file = File(
      '${directory.path}/hello.txt',
    );

    await file.writeAsString("Hello Flutter");

    setState(() {
      message = "File created and data written successfully!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write File"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: writeFile,
              child: Text("Create File"),
            ),
            SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}