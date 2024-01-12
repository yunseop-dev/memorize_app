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

  List<Widget> get widgetOptions => [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            widget.item.text,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
        Container(
            padding: const EdgeInsets.fromLTRB(18, 28, 18, 28),
            child: RecordItemList(memoryCardId: widget.item.id))
      ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widgetOptions.length,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.item.title),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
            bottom: const TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: '본문 보기'),
                  Tab(
                    text: '녹음 목록',
                  )
                ]),
          ),
          body: TabBarView(
            children: widgetOptions,
          ),
          floatingActionButton: RecordButton(
            id: widget.item.id,
          )),
    );
  }
}
