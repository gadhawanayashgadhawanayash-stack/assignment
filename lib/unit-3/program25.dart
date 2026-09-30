import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isGridView = false;

  final List<String> items = [
    "Laptop",
    "Mobile",
    "Headphones",
    "Camera",
    "Smart Watch",
    "Speaker",
    "Keyboard",
    "Mouse",
  ];

  void toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("List / Grid Toggle"),
          actions: [
            IconButton(
              onPressed: toggleView,
              icon: Icon(
                isGridView ? Icons.list : Icons.grid_view,
              ),
            ),
          ],
        ),

        body: isGridView
            ? GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              child: Center(
                child: Text(
                  items[index],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        )
            : ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text(items[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}