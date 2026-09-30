import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> names = [
    "Yash",
    "Rahul",
    "Amit",
    "Rohit",
    "Jay",
    "Krish",
    "Dhruv",
    "Harsh",
    "Dev",
    "Raj",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Name List"),
        ),
        body: ListView.builder(
          itemCount: names.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(names[index]),
            );
          },
        ),
      ),
    );
  }
}