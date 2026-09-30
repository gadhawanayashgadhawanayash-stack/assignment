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
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  State<CounterScreen> createState() =>
      _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    loadCounter();
  }

  Future<void> loadCounter() async {
    final prefs = await SharedPreferences.getInstance();

    final savedCounter = prefs.getInt("counter") ?? 0;

    setState(() {
      counter = savedCounter;
    });
  }

  Future<void> incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();

    counter++;

    await prefs.setInt("counter", counter);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Persistent Counter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Counter",
              style: TextStyle(
                fontSize: 24,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "$counter",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: incrementCounter,
              child: Text("Increment"),
            ),
          ],
        ),
      ),
    );
  }
}