import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: MyApp(),
    ),
  );
}

// Theme Model
class ThemeModel extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

// App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light(),

      darkTheme: ThemeData.dark(),

      themeMode: themeModel.isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      home: HomeScreen(),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeModel = context.watch<ThemeModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Switcher"),

        actions: [
          Switch(
            value: themeModel.isDarkMode,

            onChanged: (value) {
              context.read<ThemeModel>().toggleTheme();
            },
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              themeModel.isDarkMode
                  ? Icons.dark_mode
                  : Icons.light_mode,
              size: 80,
            ),

            SizedBox(height: 20),

            Text(
              themeModel.isDarkMode
                  ? "Dark Mode"
                  : "Light Mode",

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                context.read<ThemeModel>().toggleTheme();
              },
              child: Text(
                "Change Theme",
              ),
            ),
          ],
        ),
      ),
    );
  }
}