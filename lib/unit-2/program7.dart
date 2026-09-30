import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Drawer Example")),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  "My Menu",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),

              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(Icons.info),
                title: Text("About"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),

        body: Center(
          child: Text("Welcome to Home Page", style: TextStyle(fontSize: 22)),
        ),
      ),
    );
  }
}
