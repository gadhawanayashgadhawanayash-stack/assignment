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
      home: CacheScreen(),
    );
  }
}

class CacheScreen extends StatefulWidget {
  @override
  State<CacheScreen> createState() => _CacheScreenState();
}

class _CacheScreenState extends State<CacheScreen> {
  final Map<String, dynamic> cache = {};

  String result = "";
  bool loading = false;

  Future<void> loadData() async {
    const String url =
        "https://jsonplaceholder.typicode.com/posts/1";

    // Check cache first
    if (cache.containsKey(url)) {
      setState(() {
        result = "From Cache:\n\n${cache[url]}";
      });
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Store response in cache
        cache[url] = data;

        setState(() {
          result = "Fresh Data From API:\n\n$data";
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

  void clearCache() {
    setState(() {
      cache.clear();
      result = "Cache cleared!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clear Cache"),
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

              SizedBox(height: 15),

              ElevatedButton(
                onPressed: clearCache,
                child: Text("Clear Cache"),
              ),

              SizedBox(height: 30),

              if (loading)
                CircularProgressIndicator(),

              SizedBox(height: 20),

              Text(
                result,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Cache Items: ${cache.length}",
                style: TextStyle(
                  fontSize: 18,
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