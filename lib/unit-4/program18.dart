import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Student {
  String name;
  int age;
  String city;

  Student({
    required this.name,
    required this.age,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'city': city,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      age: json['age'],
      city: json['city'],
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
      home: StudentScreen(),
    );
  }
}

class StudentScreen extends StatefulWidget {
  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  List<Student> students = [
    Student(name: "Yash", age: 21, city: "Rajkot"),
    Student(name: "Rahul", age: 22, city: "Ahmedabad"),
  ];

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/students.json');
  }

  Future<void> saveStudents() async {
    final file = await getFile();

    List<Map<String, dynamic>> studentJson =
    students.map((student) => student.toJson()).toList();

    String jsonString = jsonEncode(studentJson);

    await file.writeAsString(jsonString);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Students saved successfully"),
      ),
    );
  }

  Future<void> loadStudents() async {
    final file = await getFile();

    if (await file.exists()) {
      String jsonString = await file.readAsString();

      List<dynamic> jsonList = jsonDecode(jsonString);

      setState(() {
        students = jsonList
            .map((json) => Student.fromJson(json))
            .toList();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Students loaded successfully"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("File does not exist"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student JSON File"),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: saveStudents,
                child: Text("Save"),
              ),
              ElevatedButton(
                onPressed: loadStudents,
                child: Text("Load"),
              ),
            ],
          ),

          SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];

                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(student.name),
                    subtitle: Text(
                      "Age: ${student.age} | City: ${student.city}",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}