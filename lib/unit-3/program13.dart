import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Student {
  String name;
  int rollNo;
  double marks;

  Student({
    required this.name,
    required this.rollNo,
    required this.marks,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Student student = Student(
    name: "Yash",
    rollNo: 101,
    marks: 85.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  student: student,
                ),
              ),
            );
          },
          child: Text("View Student Details"),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Student student;

  DetailScreen({
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Name: ${student.name}",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 10),
            Text(
              "Roll No: ${student.rollNo}",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 10),
            Text(
              "Marks: ${student.marks}",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}