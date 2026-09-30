import 'dart:convert';

import 'package:flutter/material.dart';

class Marks {
  String subject;
  int marks;

  Marks({
    required this.subject,
    required this.marks,
  });

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'marks': marks,
    };
  }

  factory Marks.fromJson(Map<String, dynamic> json) {
    return Marks(
      subject: json['subject'],
      marks: json['marks'],
    );
  }
}

class Student {
  String name;
  int rollNo;
  List<Marks> marks;

  Student({
    required this.name,
    required this.rollNo,
    required this.marks,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rollNo': rollNo,
      'marks': marks.map((mark) => mark.toJson()).toList(),
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      rollNo: json['rollNo'],
      marks: (json['marks'] as List)
          .map(
            (mark) => Marks.fromJson(
          Map<String, dynamic>.from(mark),
        ),
      )
          .toList(),
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
      title: 'Nested JSON',
      home: StudentScreen(),
    );
  }
}

class StudentScreen extends StatefulWidget {
  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  Student? student;

  String jsonData = '';

  void createStudent() {
    final newStudent = Student(
      name: 'Yash',
      rollNo: 101,
      marks: [
        Marks(
          subject: 'Flutter',
          marks: 85,
        ),
        Marks(
          subject: 'Java',
          marks: 78,
        ),
        Marks(
          subject: 'Dart',
          marks: 90,
        ),
      ],
    );

    final Map<String, dynamic> studentMap =
    newStudent.toJson();

    final String encodedJson = jsonEncode(studentMap);

    final Map<String, dynamic> decodedJson =
    jsonDecode(encodedJson);

    final Student loadedStudent =
    Student.fromJson(decodedJson);

    setState(() {
      student = loadedStudent;
      jsonData = encodedJson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested JSON Model'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: student == null
            ? Center(
          child: ElevatedButton(
            onPressed: createStudent,
            child: const Text(
              'Create Student',
            ),
          ),
        )
            : Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              'Student Details',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              'Name: ${student!.name}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            Text(
              'Roll No: ${student!.rollNo}',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Marks:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: student!.marks.length,
                itemBuilder: (context, index) {
                  final mark =
                  student!.marks[index];

                  return Card(
                    child: ListTile(
                      title: Text(mark.subject),
                      trailing: Text(
                        '${mark.marks}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Text(
              'JSON Data:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              jsonData,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}