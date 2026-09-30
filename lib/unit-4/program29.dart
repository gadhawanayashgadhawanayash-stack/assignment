import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Program29 extends StatefulWidget {
  const Program29({super.key});

  @override
  State<Program29> createState() => _Program29State();
}

class _Program29State extends State<Program29> {
  final String apiUrl =
      'https://jsonplaceholder.typicode.com/posts';

  List<dynamic> posts = [];
  String message = 'No data loaded';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<File> getCacheFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/cached_data.json');
  }

  Future<void> loadData() async {
    setState(() {
      message = 'Downloading data...';
    });

    try {
      // Try to download data from API
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Convert JSON string to Dart object
        final data = jsonDecode(response.body);

        // Save downloaded JSON locally
        final file = await getCacheFile();
        await file.writeAsString(response.body);

        setState(() {
          posts = data;
          message = 'Data loaded from API and cached locally';
        });
      } else {
        throw Exception('Server error');
      }
    } catch (e) {
      // Network failed, so try local cache
      await loadFromCache();
    }
  }

  Future<void> loadFromCache() async {
    try {
      final file = await getCacheFile();

      if (await file.exists()) {
        final jsonString = await file.readAsString();

        final data = jsonDecode(jsonString);

        setState(() {
          posts = data;
          message = 'Network failed. Data loaded from local cache';
        });
      } else {
        setState(() {
          message = 'No internet and no cached data available';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Cache error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Program 29 - JSON Cache'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ElevatedButton(
            onPressed: loadData,
            child: const Text('Load Data'),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: posts.isEmpty
                ? const Center(
              child: Text('No data available'),
            )
                : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${post['id']}'),
                    ),
                    title: Text(
                      post['title'],
                    ),
                    subtitle: Text(
                      post['body'],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Program29(),
    ),
  );
}