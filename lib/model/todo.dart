import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  String text;
  bool done = false;

  Todo({
    String? id,
    required this.text,
    required this.done,
  }) : id = id ?? const Uuid().v4();

  setText(String value) {
    text = value;
  }

  setDone(bool value) {
    done = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'done': done ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      text: map['text'],
      done: map['done'] == 1,
    );
  }
}
