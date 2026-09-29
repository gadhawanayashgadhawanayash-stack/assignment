import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Colored Boxes")),
        body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: colors.map((color) {
            return Container(
              color: color,
              child: Center(
                child: Text(
                  "Box",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
