import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:flutter_todo/screen/record_item_detail.dart';

class TodoItemDetail extends StatefulWidget {
  final Todo item;

  const TodoItemDetail({Key? key, required this.item}) : super(key: key);

  @override
  TodoItemDetailState createState() => TodoItemDetailState();
}

class TodoItemDetailState extends State<TodoItemDetail> {
  bool isListening = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> get widgetOptions => [
        Text(widget.item.text),
        ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('녹음 $index'),
              subtitle: const Text('yyyy-mm-dd'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RecordItemDetail()));
              },
            );
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.title)),
      body: Center(
        child: widgetOptions[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
          print(value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Script'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Record')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('onPressed');
        },
        child: Icon(!isListening ? Icons.mic : Icons.stop),
      ),
    );
  }
}
