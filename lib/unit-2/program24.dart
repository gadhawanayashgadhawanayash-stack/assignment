import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoParent());
  }
}

class TodoParent extends StatefulWidget {
  @override
  State<TodoParent> createState() => _TodoParentState();
}

class _TodoParentState extends State<TodoParent> {
  List<String> tasks = ["Study Flutter", "Practice Dart"];

  @override
  Widget build(BuildContext context) {
    return TodoList(tasks: tasks);
  }
}

class TodoList extends StatefulWidget {
  final List<String> tasks;

  TodoList({required this.tasks});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late List<String> localTasks;
  List<bool> completed = [];

  @override
  void initState() {
    super.initState();

    localTasks = List.from(widget.tasks);
    completed = List.generate(localTasks.length, (index) => false);

    print("initState() called");
  }

  @override
  void didUpdateWidget(covariant TodoList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.tasks != widget.tasks) {
      localTasks = List.from(widget.tasks);

      completed = List.generate(localTasks.length, (index) => false);

      print("didUpdateWidget() called");
    }
  }

  void addTask() {
    setState(() {
      localTasks.add("New Task ${localTasks.length + 1}");
      completed.add(false);
    });
  }

  void removeTask(int index) {
    setState(() {
      localTasks.removeAt(index);
      completed.removeAt(index);
    });
  }

  void toggleTask(int index) {
    setState(() {
      completed[index] = !completed[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: ListView.builder(
        itemCount: localTasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: completed[index],
              onChanged: (value) {
                toggleTask(index);
              },
            ),
            title: Text(
              localTasks[index],
              style: TextStyle(
                decoration: completed[index]
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                removeTask(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    print("dispose() called");
    super.dispose();
  }
}
