import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  TodoScreenState createState() => TodoScreenState();
}

class Todo {
  final String id;
  String text;
  bool done = false;

  Todo({
    String? id,
    required this.text,
  }) : id = id ?? const Uuid().v4();

  setText(String value) {
    text = value;
  }

  setDone(bool value) {
    done = value;
  }
}

class TodoScreenState extends State<TodoScreen> {
  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'edit',
                  onPressed: () {
                    _showEditTodoDialog(context, todos[index]);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'delete',
                  onPressed: () {
                    _showDeleteTodoDialog(context, todos[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String inputString = '';
        return AlertDialog(
          title: const Text('Add Todo'),
          content: TextField(
            autofocus: true,
            onChanged: (v) {
              inputString = v;
            },
            onSubmitted: (newTodo) {
              _addTodoItem(newTodo);
              inputString = '';
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  _addTodoItem(inputString);
                  Navigator.of(context).pop();
                },
                child: const Text('Input')),
          ],
        );
      },
    );
  }

  void _showEditTodoDialog(BuildContext context, Todo target) {
    TextEditingController controller = TextEditingController(text: target.text);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        String inputString = '';
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            autofocus: true,
            controller: controller,
            onChanged: (v) {
              inputString = v;
            },
            onSubmitted: (newTodo) {
              _editTodoItem(target, newTodo);
              inputString = '';
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  if (inputString != '') {
                    _editTodoItem(target, inputString);
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Edit')),
          ],
        );
      },
    );
  }

  void _showDeleteTodoDialog(BuildContext context, Todo target) {
    // set up the button
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Item"),
      content: const Text("Item will be deleted."),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Delete"),
          onPressed: () {
            _deleteTodoItem(target);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _addTodoItem(String newTodo) {
    setState(() {
      todos.add(Todo(text: newTodo));
    });
  }

  void _editTodoItem(Todo target, String newTodo) {
    setState(() {
      todos = [
        ...todos.map((e) => e.id == target.id ? Todo(text: newTodo) : e)
      ];
    });
  }

  void _deleteTodoItem(Todo target) {
    setState(() {
      todos = [...todos.where((e) => e.id != target.id)];
    });
  }
}
