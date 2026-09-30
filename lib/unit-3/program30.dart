import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

// User Model
class User {
  final String username;
  final String password;

  User({
    required this.username,
    required this.password,
  });
}

// User Provider
class UserProvider extends ChangeNotifier {
  final List<User> users = [
    User(
      username: "yash",
      password: "123456",
    ),
    User(
      username: "rahul",
      password: "123456",
    ),
    User(
      username: "admin",
      password: "admin123",
    ),
  ];

  bool validateUser(
      String username,
      String password,
      ) {
    return users.any(
          (user) =>
      user.username == username &&
          user.password == password,
    );
  }
}

// App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String errorMessage = "";

  void login() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final username = usernameController.text;
    final password = passwordController.text;

    final userProvider =
    context.read<UserProvider>();

    bool isValid = userProvider.validateUser(
      username,
      password,
    );

    if (isValid) {
      setState(() {
        errorMessage = "";
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            username: username,
          ),
        ),
      );
    } else {
      setState(() {
        errorMessage = "Invalid username or password";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multi User Login"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Form(
          key: formKey,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              TextFormField(
                controller: usernameController,

                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter username";
                  }

                  return null;
                },
              ),

              SizedBox(height: 15),

              TextFormField(
                controller: passwordController,
                obscureText: true,

                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter password";
                  }

                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }

                  return null;
                },
              ),

              SizedBox(height: 15),

              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: login,
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  final String username;

  HomeScreen({
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),

      body: Center(
        child: Text(
          "Welcome, $username!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}