import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Settings")),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Table(
            border: TableBorder.all(color: Colors.grey),
            columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Setting",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Value",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(12), child: Text("Username")),
                  Padding(padding: EdgeInsets.all(12), child: Text("Yash")),
                ],
              ),
              TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(12), child: Text("Language")),
                  Padding(padding: EdgeInsets.all(12), child: Text("English")),
                ],
              ),
              TableRow(
                children: [
                  Padding(padding: EdgeInsets.all(12), child: Text("Theme")),
                  Padding(padding: EdgeInsets.all(12), child: Text("Light")),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("Notifications"),
                  ),
                  Padding(padding: EdgeInsets.all(12), child: Text("Enabled")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
