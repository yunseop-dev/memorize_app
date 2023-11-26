import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:flutter_todo/widget/record_button.dart';
import 'package:flutter_todo/widget/record_item_list.dart';

class TodoItemDetail extends StatefulWidget {
  final Todo item;

  const TodoItemDetail({Key? key, required this.item}) : super(key: key);

  @override
  TodoItemDetailState createState() => TodoItemDetailState();
}

class TodoItemDetailState extends State<TodoItemDetail> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> get widgetOptions =>
      [Text(widget.item.text), RecordItemList(memoryCardId: widget.item.id)];

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
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '본문보기'),
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: '녹음 목록')
        ],
      ),
      floatingActionButton: currentIndex == 0
          ? null
          : RecordButton(
              id: widget.item.id,
            ),
    );
  }
}
