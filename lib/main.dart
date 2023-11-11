import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:flutter_todo/repository/todo_repository.dart';

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

class TodoScreenState extends State<TodoScreen> {
  late List<Todo> _todos;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    TodoRepository.getTodos().then((value) => {
          setState(() {
            _todos = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_todos[index].text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'edit',
                  onPressed: () {
                    _showEditTodoDialog(context, _todos[index]);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'delete',
                  onPressed: () {
                    _showDeleteTodoDialog(context, _todos[index]);
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

  void _addTodoItem(String newTodo) async {
    Todo todo = Todo(text: newTodo, done: false);
    await TodoRepository.add(todo);
    setState(() {
      _todos.add(Todo(text: newTodo, done: false));
    });
  }

  void _editTodoItem(Todo target, String newTodo) async {
    Todo todo = Todo(text: newTodo, done: false);
    await TodoRepository.edit(target, todo);
    setState(() {
      _todos = [..._todos.map((e) => e.id == target.id ? todo : e)];
    });
  }

  void _deleteTodoItem(Todo target) async {
    await TodoRepository.delete(target);
    setState(() {
      _todos = [..._todos.where((e) => e.id != target.id)];
    });
  }
}
