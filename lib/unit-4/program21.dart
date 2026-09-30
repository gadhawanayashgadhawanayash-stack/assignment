import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Note {
  String title;
  String description;

  Note({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'],
      description: json['description'],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Notes App",
      home: NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> notes = [];

  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController descriptionController =
  TextEditingController();

  Future<File> getFile() async {
    final directory =
    await getApplicationDocumentsDirectory();

    return File('${directory.path}/notes.json');
  }

  // READ
  Future<void> loadNotes() async {
    final file = await getFile();

    if (await file.exists()) {
      final jsonString = await file.readAsString();

      final List<dynamic> jsonList = jsonDecode(jsonString);

      setState(() {
        notes = jsonList
            .map((json) => Note.fromJson(json))
            .toList();
      });
    }
  }

  // SAVE ALL NOTES
  Future<void> saveNotes() async {
    final file = await getFile();

    final List<Map<String, dynamic>> jsonList =
    notes.map((note) => note.toJson()).toList();

    final jsonString = jsonEncode(jsonList);

    await file.writeAsString(jsonString);
  }

  // CREATE
  Future<void> addNote() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      return;
    }

    final note = Note(
      title: titleController.text,
      description: descriptionController.text,
    );

    setState(() {
      notes.add(note);
    });

    await saveNotes();

    titleController.clear();
    descriptionController.clear();

    Navigator.pop(context);
  }

  // UPDATE
  Future<void> updateNote(int index) async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      return;
    }

    setState(() {
      notes[index].title = titleController.text;
      notes[index].description =
          descriptionController.text;
    });

    await saveNotes();

    titleController.clear();
    descriptionController.clear();

    Navigator.pop(context);
  }

  // DELETE
  Future<void> deleteNote(int index) async {
    setState(() {
      notes.removeAt(index);
    });

    await saveNotes();
  }

  void showNoteDialog({int? index}) {
    if (index != null) {
      titleController.text = notes[index].title;
      descriptionController.text =
          notes[index].description;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            index == null ? "Add Note" : "Update Note",
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 15),

              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                titleController.clear();
                descriptionController.clear();
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                if (index == null) {
                  addNote();
                } else {
                  updateNote(index);
                }
              },
              child: Text(
                index == null ? "Add" : "Update",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
      ),

      body: notes.isEmpty
          ? Center(
        child: Text(
          "No Notes Found",
          style: TextStyle(fontSize: 20),
        ),
      )
          : ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                note.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(note.description),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showNoteDialog(index: index);
                    },
                  ),

                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteNote(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNoteDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}