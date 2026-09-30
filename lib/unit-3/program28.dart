import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController numberController =
  TextEditingController();

  String pattern = "";

  void generatePattern() {
    int n = int.tryParse(numberController.text) ?? 0;

    String result = "";

    for (int i = 1; i <= n; i++) {
      for (int j = 1; j <= i; j++) {
        result += "$j ";
      }

      result += "\n";
    }

    setState(() {
      pattern = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: Text("Number Pyramid"),
        ),

        body: Padding(
          padding: EdgeInsets.all(20),

          child: Column(
            children: [
              TextField(
                controller: numberController,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: "Enter N",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: generatePattern,
                child: Text("Generate Pattern"),
              ),

              SizedBox(height: 30),

              Text(
                pattern,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}