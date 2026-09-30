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
      home: NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController noteController =
  TextEditingController();

  String savedNote = "";

  Future<File> getNoteFile() async {
    final directory =
    await getApplicationDocumentsDirectory();

    return File('${directory.path}/note.txt');
  }

  Future<void> saveNote() async {
    final file = await getNoteFile();

    await file.writeAsString(noteController.text);

    setState(() {
      savedNote = noteController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Note saved successfully!"),
      ),
    );
  }

  Future<void> loadNote() async {
    final file = await getNoteFile();

    if (await file.exists()) {
      final content = await file.readAsString();

      setState(() {
        savedNote = content;
        noteController.text = content;
      });
    } else {
      setState(() {
        savedNote = "No saved note found.";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: noteController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Enter your note",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveNote,
              child: Text("Save Note"),
            ),

            SizedBox(height: 20),

            Text(
              "Saved Note:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              savedNote,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}