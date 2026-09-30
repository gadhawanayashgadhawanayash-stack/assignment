import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  List<String> filteredNames = [];

  @override
  void initState() {
    super.initState();
    filteredNames = names;
  }

  void searchNames(String query) {
    setState(() {
      filteredNames = names
          .where(
            (name) =>
            name.toLowerCase().contains(query.toLowerCase()),
      )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Search List"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: searchNames,
                decoration: InputDecoration(
                  hintText: "Search name",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredNames.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(filteredNames[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}