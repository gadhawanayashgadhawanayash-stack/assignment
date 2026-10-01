import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('todoBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController controller = TextEditingController();

  final Box todoBox = Hive.box('todoBox');

  // Save To-Do note
  Future<void> saveTodo() async {
    final todo = controller.text.trim();

    if (todo.isEmpty) {
      return;
    }

    await todoBox.add(todo);

    controller.clear();

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('To-Do saved successfully'),
      ),
    );
  }

  // Delete To-Do
  Future<void> deleteTodo(int index) async {
    await todoBox.deleteAt(index);

    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive To-Do App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Enter To-Do',
                hintText: 'Example: Complete Flutter assignment',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: saveTodo,
              child: const Text('Save To-Do'),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: todoBox.isEmpty
                  ? const Center(
                child: Text(
                  'No To-Do notes found',
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: todoBox.length,
                itemBuilder: (context, index) {
                  final todo = todoBox.getAt(index);

                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.check_circle_outline,
                      ),
                      title: Text('$todo'),
                      trailing: IconButton(
                        onPressed: () {
                          deleteTodo(index);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}