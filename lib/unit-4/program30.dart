import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Program30 extends StatefulWidget {
  const Program30({super.key});

  @override
  State<Program30> createState() => _Program30State();
}

class _Program30State extends State<Program30> {
  final String apiUrl =
      'https://jsonplaceholder.typicode.com/posts/1';

  Map<String, dynamic>? post;
  String message = 'Loading...';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Get local file path
  Future<File> getDataFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/offline_data.json');
  }

  // Fetch data from API
  Future<void> fetchFromApi() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Serialize JSON and save it
        final file = await getDataFile();
        await file.writeAsString(response.body);

        // Deserialize JSON
        final data = jsonDecode(response.body);

        setState(() {
          post = Map<String, dynamic>.from(data);
          message = 'Data fetched from API and saved locally';
        });
      } else {
        throw Exception('API error');
      }
    } catch (e) {
      await loadFromLocalFile();
    }
  }

  // Load previously saved data
  Future<void> loadFromLocalFile() async {
    try {
      final file = await getDataFile();

      if (await file.exists()) {
        final jsonString = await file.readAsString();

        // Deserialize JSON
        final data = jsonDecode(jsonString);

        setState(() {
          post = Map<String, dynamic>.from(data);
          message = 'Loaded data from local storage';
        });
      } else {
        setState(() {
          message = 'No local data found';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }

  // Edit local data
  Future<void> editTitle() async {
    if (post == null) return;

    final controller = TextEditingController(
      text: post!['title'],
    );

    final newTitle = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Title'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  controller.text,
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (newTitle != null && newTitle.isNotEmpty) {
      post!['title'] = newTitle;

      // Serialize updated data
      final jsonString = jsonEncode(post);

      // Save edited data locally
      final file = await getDataFile();
      await file.writeAsString(jsonString);

      setState(() {
        message = 'Local changes saved';
      });
    }
  }

  // Re-sync changes with server
  Future<void> syncData() async {
    if (post == null) return;

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(post),
      );

      if (response.statusCode == 200) {
        setState(() {
          message = 'Local changes synced with server';
        });
      } else {
        setState(() {
          message = 'Sync failed';
        });
      }
    } catch (e) {
      setState(() {
        message = 'No internet. Changes remain stored locally';
      });
    }
  }

  Future<void> loadData() async {
    setState(() {
      message = 'Loading data...';
    });

    try {
      final file = await getDataFile();

      if (await file.exists()) {
        await loadFromLocalFile();
      } else {
        await fetchFromApi();
      }
    } catch (e) {
      await fetchFromApi();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Program 30 - Offline Pipeline'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: post == null
            ? Center(
          child: Text(message),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'ID: ${post!['id']}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              'Title:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              '${post!['title']}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              'Body:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              '${post!['body']}',
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: editTitle,
              child: const Text('Edit Local Data'),
            ),

            ElevatedButton(
              onPressed: syncData,
              child: const Text('Sync Changes'),
            ),

            ElevatedButton(
              onPressed: fetchFromApi,
              child: const Text('Fetch From API'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Program30(),
    ),
  );
}