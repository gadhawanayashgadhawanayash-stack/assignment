import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class LifecycleLogger extends StatefulWidget {
  final Widget child;
  final String name;

  LifecycleLogger({required this.child, required this.name});

  @override
  State<LifecycleLogger> createState() => _LifecycleLoggerState();
}

class _LifecycleLoggerState extends State<LifecycleLogger> {
  void log(String message) {
    print(
      "${DateTime.now().toIso8601String()} - "
      "${widget.name}: $message",
    );
  }

  @override
  void initState() {
    super.initState();
    log("initState()");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log("didChangeDependencies()");
  }

  @override
  void didUpdateWidget(covariant LifecycleLogger oldWidget) {
    super.didUpdateWidget(oldWidget);
    log("didUpdateWidget()");
  }

  @override
  void deactivate() {
    log("deactivate()");
    super.deactivate();
  }

  @override
  void dispose() {
    log("dispose()");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("build()");

    return widget.child;
  }
}

class Counter extends StatefulWidget {
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Counter: $count", style: TextStyle(fontSize: 25)),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: Text("Increment"),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Lifecycle Logger")),
        body: Center(
          child: LifecycleLogger(name: "CounterWrapper", child: Counter()),
        ),
      ),
    );
  }
}
