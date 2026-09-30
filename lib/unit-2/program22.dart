import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Custom Button
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}

// Custom Card
class CustomCard extends StatelessWidget {
  final String title;
  final String description;

  CustomCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}

// Custom AppBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(title: "Custom Widget Demo"),
        body: Column(
          children: [
            CustomCard(
              title: "Flutter",
              description: "Build beautiful cross-platform apps.",
            ),

            CustomCard(
              title: "Dart",
              description: "Programming language used by Flutter.",
            ),

            CustomButton(
              text: "Click Me",
              onPressed: () {
                print("Custom Button Pressed");
              },
            ),
          ],
        ),
      ),
    );
  }
}
