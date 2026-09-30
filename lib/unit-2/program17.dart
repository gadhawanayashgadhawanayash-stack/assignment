import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Media Tabs"),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.photo), text: "Photos"),
                Tab(icon: Icon(Icons.video_library), text: "Videos"),
                Tab(icon: Icon(Icons.insert_drive_file), text: "Files"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Text("Photos Content", style: TextStyle(fontSize: 24)),
              ),
              Center(
                child: Text("Videos Content", style: TextStyle(fontSize: 24)),
              ),
              Center(
                child: Text("Files Content", style: TextStyle(fontSize: 24)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
