import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Profile"),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.photo), text: "Photos"),
                Tab(icon: Icon(Icons.list), text: "Activity"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Image.network(
                    "https://picsum.photos/seed/photo$index/300/300",
                    fit: BoxFit.cover,
                  );
                },
              ),

              ListView(
                padding: EdgeInsets.all(10),
                children: [
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text("Liked a photo"),
                    subtitle: Text("2 hours ago"),
                  ),
                  ListTile(
                    leading: Icon(Icons.comment),
                    title: Text("Commented on a post"),
                    subtitle: Text("5 hours ago"),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text("Followed a new user"),
                    subtitle: Text("Yesterday"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
