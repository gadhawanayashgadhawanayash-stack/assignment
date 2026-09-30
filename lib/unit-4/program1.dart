import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PathScreen(),
    );
  }
}

class PathScreen extends StatelessWidget {
  Future<void> printPath() async {
    final directory =
    await getApplicationDocumentsDirectory();

    print(directory.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application Documents Path"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: printPath,
          child: Text("Print Path"),
        ),
      ),
    );
  }
}