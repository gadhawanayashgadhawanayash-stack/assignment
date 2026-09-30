import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class Todo {
  final String title;
  final bool completed;

  Todo({
    required this.title,
    this.completed = false,
  });

  Todo copyWith({
    String? title,
    bool? completed,
  }) {
    return Todo(
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }
}

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(String title) {
    state = [
      ...state,
      Todo(title: title),
    ];
  }

  void removeTodo(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  void toggleTodo(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          state[i].copyWith(
            completed: !state[i].completed,
          )
        else
          state[i],
    ];
  }
}

final todoProvider =
StateNotifierProvider<TodoNotifier, List<Todo>>(
      (ref) {
    return TodoNotifier();
  },
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends ConsumerWidget {
  TodoScreen({super.key});

  final TextEditingController controller =
  TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App - Riverpod"),
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Enter a task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      ref
                          .read(todoProvider.notifier)
                          .addTodo(controller.text);

                      controller.clear();
                    }
                  },
                  child: Text("Add"),
                ),
              ],
            ),
          ),

          Expanded(
            child: todos.isEmpty
                ? Center(
              child: Text(
                "No Tasks",
                style: TextStyle(fontSize: 22),
              ),
            )
                : ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return ListTile(
                  leading: Checkbox(
                    value: todo.completed,
                    onChanged: (value) {
                      ref
                          .read(todoProvider.notifier)
                          .toggleTodo(index);
                    },
                  ),

                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration: todo.completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),

                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      ref
                          .read(todoProvider.notifier)
                          .removeTodo(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}