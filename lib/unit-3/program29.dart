import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  Widget buildNavigator(
      int index,
      Widget screen,
      ) {
    return Navigator(
      key: navigatorKeys[index],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => screen,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        body: IndexedStack(
          index: currentIndex,

          children: [
            buildNavigator(
              0,
              HomeScreen(),
            ),

            buildNavigator(
              1,
              SearchScreen(),
            ),

            buildNavigator(
              2,
              ProfileScreen(),
            ),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,

          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

// Home Tab
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeDetailsScreen(),
              ),
            );
          },
          child: Text("Open Home Details"),
        ),
      ),
    );
  }
}

class HomeDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Details"),
      ),

      body: Center(
        child: Text(
          "Home Details Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// Search Tab
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchDetailsScreen(),
              ),
            );
          },
          child: Text("Open Search Details"),
        ),
      ),
    );
  }
}

class SearchDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Details"),
      ),

      body: Center(
        child: Text(
          "Search Details Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// Profile Tab
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileDetailsScreen(),
              ),
            );
          },
          child: Text("Open Profile Details"),
        ),
      ),
    );
  }
}

class ProfileDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Details"),
      ),

      body: Center(
        child: Text(
          "Profile Details Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}