import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SharedPreferencesScreen(),
    );
  }
}

class SharedPreferencesScreen extends StatefulWidget {
  @override
  State<SharedPreferencesScreen> createState() =>
      _SharedPreferencesScreenState();
}

class _SharedPreferencesScreenState
    extends State<SharedPreferencesScreen> {
  final TextEditingController nameController =
  TextEditingController();

  String savedName = "";

  Future<void> saveName() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "name",
      nameController.text,
    );

    setState(() {
      savedName = nameController.text;
    });
  }

  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString("name") ?? "";

    setState(() {
      savedName = name;
    });
  }

  @override
  void initState() {
    super.initState();
    loadName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SharedPreferences"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Enter Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveName,
              child: Text("Save Name"),
            ),

            SizedBox(height: 20),

            Text(
              "Saved Name: $savedName",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}