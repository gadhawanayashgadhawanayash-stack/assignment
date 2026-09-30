import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CacheApiScreen(),
    );
  }
}

class CacheApiScreen extends StatefulWidget {
  @override
  State<CacheApiScreen> createState() =>
      _CacheApiScreenState();
}

class _CacheApiScreenState extends State<CacheApiScreen> {
  // Memory cache
  final Map<String, dynamic> cache = {};

  String result = "";
  bool loading = false;

  Future<void> loadData() async {
    const String url =
        "https://jsonplaceholder.typicode.com/posts/1";

    // Check memory cache first
    if (cache.containsKey(url)) {
      setState(() {
        result = "From Cache:\n\n${cache[url]}";
      });
      return;
    }

    // If not in cache, call API
    setState(() {
      loading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Store API response in cache
        cache[url] = data;

        setState(() {
          result = "From API:\n\n$data";
          loading = false;
        });
      } else {
        setState(() {
          result = "API Error";
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        result = "Error: $e";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cache First API"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: loading ? null : loadData,
                child: Text("Load Data"),
              ),

              SizedBox(height: 30),

              if (loading)
                CircularProgressIndicator(),

              SizedBox(height: 20),

              Text(
                result,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}