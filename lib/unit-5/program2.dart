
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  // Load saved theme setting
  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isDarkMode = prefs.getBool('darkMode') ?? false;
    });
  }

  // Save theme setting
  Future<void> saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('darkMode', value);

    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dark Mode Settings'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enable Dark Mode',
                style: TextStyle(fontSize: 22),
              ),
              Switch(
                value: isDarkMode,
                onChanged: saveTheme,
              ),
              Text(
                isDarkMode ? 'Dark Mode On' : 'Light Mode On',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}