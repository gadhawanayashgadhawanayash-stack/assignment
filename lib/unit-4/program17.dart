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
      home: AppendFileScreen(),
    );
  }
}

class AppendFileScreen extends StatefulWidget {
  @override
  State<AppendFileScreen> createState() =>
      _AppendFileScreenState();
}

class _AppendFileScreenState
    extends State<AppendFileScreen> {
  final TextEditingController textController =
  TextEditingController();

  String fileContent = "";

  Future<File> getFile() async {
    final directory =
    await getApplicationDocumentsDirectory();

    return File('${directory.path}/append.txt');
  }

  Future<void> appendText() async {
    final file = await getFile();

    await file.writeAsString(
      "${textController.text}\n",
      mode: FileMode.append,
    );

    textController.clear();

    await readFile();
  }

  Future<void> readFile() async {
    final file = await getFile();

    if (await file.exists()) {
      final content = await file.readAsString();

      setState(() {
        fileContent = content;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    readFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Append Text to File"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: "Enter text",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: appendText,
              child: Text("Append Text"),
            ),

            SizedBox(height: 30),

            Text(
              "File Content:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              fileContent,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}