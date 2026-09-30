import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MyApp: build() called");

    return MaterialApp(home: LifecycleDemo());
  }
}

class LifecycleDemo extends StatefulWidget {
  @override
  State<LifecycleDemo> createState() {
    print("LifecycleDemo: createState() called");
    return _LifecycleDemoState();
  }
}

class _LifecycleDemoState extends State<LifecycleDemo> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    print("LifecycleDemo: initState() called");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("LifecycleDemo: didChangeDependencies() called");
  }

  @override
  Widget build(BuildContext context) {
    print("LifecycleDemo: build() called");

    return Scaffold(
      appBar: AppBar(title: Text("Lifecycle Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter: $counter", style: TextStyle(fontSize: 25)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });

                print("setState() called");
              },
              child: Text("Increment"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant LifecycleDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("LifecycleDemo: didUpdateWidget() called");
  }

  @override
  void deactivate() {
    print("LifecycleDemo: deactivate() called");
    super.deactivate();
  }

  @override
  void dispose() {
    print("LifecycleDemo: dispose() called");
    super.dispose();
  }
}
