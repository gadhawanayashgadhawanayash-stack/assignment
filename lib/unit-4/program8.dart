import 'package:flutter/material.dart';

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
  // In-memory cache
  final Map<String, String> cache = {};

  String result = "";

  Future<String> getData(String key) async {
    // Check if data is already in cache
    if (cache.containsKey(key)) {
      return "From Cache: ${cache[key]}";
    }

    // Simulate API response
    String apiResponse = "API Data for $key";

    // Store response in cache
    cache[key] = apiResponse;

    return "From API: $apiResponse";
  }

  Future<void> loadData() async {
    String data = await getData("users");

    setState(() {
      result = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("In-Memory Cache"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: loadData,
              child: Text("Load API Data"),
            ),

            SizedBox(height: 30),

            Text(
              result,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Cache Size: ${cache.length}",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}