import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('userBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserScreen(),
    );
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  final Box userBox = Hive.box('userBox');

  // Save name and age
  Future<void> saveUser() async {
    final name = nameController.text.trim();
    final age = int.tryParse(ageController.text.trim());

    if (name.isEmpty || age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid name and age'),
        ),
      );
      return;
    }

    await userBox.put('user', {
      'name': name,
      'age': age,
    });

    nameController.clear();
    ageController.clear();

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User saved successfully'),
      ),
    );
  }

  // Delete user
  Future<void> deleteUser() async {
    await userBox.delete('user');

    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = userBox.get('user');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive User Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Age',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveUser,
              child: const Text('Save User'),
            ),

            const SizedBox(height: 30),

            if (user != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    'Name: ${user['name']}',
                  ),
                  subtitle: Text(
                    'Age: ${user['age']}',
                  ),
                  trailing: IconButton(
                    onPressed: deleteUser,
                    icon: const Icon(Icons.delete),
                  ),
                ),
              )
            else
              const Text(
                'No user data found',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}