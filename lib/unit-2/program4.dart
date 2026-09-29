import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> fruits = [
    "Apple",
    "Banana",
    "Mango",
    "Orange",
    "Grapes",
    "Watermelon",
    "Pineapple",
    "Papaya",
    "Guava",
    "Strawberry",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Fruit List")),
        body: ListView.builder(
          itemCount: fruits.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.apple),
              title: Text(fruits[index]),
            );
          },
        ),
      ),
    );
  }
}
