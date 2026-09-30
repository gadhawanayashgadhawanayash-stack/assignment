import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: MyApp(),
    ),
  );
}

class CounterModel extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // context.watch() listens for changes
    final counter = context.watch<CounterModel>().counter;

    return Scaffold(
      appBar: AppBar(
        title: Text("read() vs watch()"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Counter: $counter",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 30),

            // context.read() - does not listen for changes
            ElevatedButton(
              onPressed: () {
                context.read<CounterModel>().increment();
              },
              child: Text("Increment using read()"),
            ),

            SizedBox(height: 15),

            // context.watch() - listens for changes
            ElevatedButton(
              onPressed: () {
                context.watch<CounterModel>().increment();
              },
              child: Text("Increment using watch()"),
            ),
          ],
        ),
      ),
    );
  }
}