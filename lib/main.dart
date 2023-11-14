import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:flutter_todo/repository/todo_repository.dart';
import 'package:flutter_todo/widget/add_button.dart';
import 'package:flutter_todo/widget/delete_button.dart';
import 'package:flutter_todo/widget/edit_button.dart';

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
  late Future<List<Todo>> _todos;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    setState(() {
      _todos = TodoRepository.getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: FutureBuilder<List<Todo>>(
        future: _todos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Todo> todos = snapshot.data!;
            if (todos.isEmpty) {
              return const Center(child: Text('No data'));
            }
            return ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todos[index].text),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        EditButton(
                          target: todos[index],
                        ),
                        DeleteButton(
                          target: todos[index],
                        ),
                      ],
                    ),
                  );
                });
          }
        },
      ),
      floatingActionButton: const AddButton(),
    );
  }
}
