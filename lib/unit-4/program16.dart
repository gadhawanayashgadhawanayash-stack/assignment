import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTheme =
        prefs.getBool("isDarkMode") ?? false;

    setState(() {
      isDarkMode = savedTheme;
      isLoading = false;
    });
  }

  Future<void> saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isDarkMode", value);

    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light(),

      darkTheme: ThemeData.dark(),

      themeMode:
      isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: SettingsScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: saveTheme,
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  SettingsScreen({
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),

      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Dark Mode"),
            subtitle: Text(
              isDarkMode
                  ? "Dark theme is enabled"
                  : "Light theme is enabled",
            ),
            value: isDarkMode,
            onChanged: onThemeChanged,
          ),
        ],
      ),
    );
  }
}