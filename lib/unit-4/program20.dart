import 'dart:convert';

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
      home: OfflineQueueScreen(),
    );
  }
}

class OfflineQueueScreen extends StatefulWidget {
  @override
  State<OfflineQueueScreen> createState() => _OfflineQueueScreenState();
}

class _OfflineQueueScreenState extends State<OfflineQueueScreen> {
  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  List<Map<String, dynamic>> queue = [];

  @override
  void initState() {
    super.initState();
    loadQueue();
  }

  Future<void> loadQueue() async {
    final prefs = await SharedPreferences.getInstance();

    final String? savedData = prefs.getString('offline_queue');

    if (savedData != null) {
      final List<dynamic> decodedData = jsonDecode(savedData);

      setState(() {
        queue = decodedData
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      });
    }
  }

  Future<void> saveFormData() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty) {
      return;
    }

    final formData = {
      'name': nameController.text,
      'email': emailController.text,
    };

    queue.add(formData);

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'offline_queue',
      jsonEncode(queue),
    );

    nameController.clear();
    emailController.clear();

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Form data saved to offline queue"),
      ),
    );
  }

  Future<void> clearQueue() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('offline_queue');

    setState(() {
      queue.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Offline queue cleared"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline Form Queue"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            ElevatedButton(
              onPressed: saveFormData,
              child: Text("Save Form Data"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: clearQueue,
              child: Text("Clear Queue"),
            ),

            SizedBox(height: 20),

            Text(
              "Saved Queue",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: queue.length,
                itemBuilder: (context, index) {
                  final item = queue[index];

                  return Card(
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text(item['email']),
                    ),
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