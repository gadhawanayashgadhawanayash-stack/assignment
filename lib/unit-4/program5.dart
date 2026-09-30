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
      home: DeleteFileScreen(),
    );
  }
}

class DeleteFileScreen extends StatefulWidget {
  @override
  State<DeleteFileScreen> createState() =>
      _DeleteFileScreenState();
}

class _DeleteFileScreenState extends State<DeleteFileScreen> {
  String message = "";

  Future<void> deleteFile() async {
    final directory =
    await getApplicationDocumentsDirectory();

    final file = File(
      '${directory.path}/hello.txt',
    );

    if (await file.exists()) {
      await file.delete();

      setState(() {
        message = "File deleted successfully!";
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
        title: Text("Delete File"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: deleteFile,
              child: Text("Delete File"),
            ),
            SizedBox(height: 30),
            Text(
              message,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}