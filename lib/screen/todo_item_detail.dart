import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TodoItemDetail extends StatefulWidget {
  final Todo item;

  const TodoItemDetail({Key? key, required this.item}) : super(key: key);

  @override
  TodoItemDetailState createState() => TodoItemDetailState();
}

class TodoItemDetailState extends State<TodoItemDetail> {
  late stt.SpeechToText _speech;
  bool isListening = false;
  String recognizedText = '';
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  List<Widget> get widgetOptions => [
        Text(recognizedText),
        ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('녹음 $index'),
              subtitle: const Text('yyyy-mm-dd'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.play_arrow_rounded),
                    onPressed: () {
                      print('play');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.stop_rounded),
                    onPressed: () {
                      print('stop');
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ];

  void onListen() async {
    if (!isListening) {
      bool isAvailable = await _speech.initialize(
        onStatus: (val) => print('onStatus $val'),
        onError: (val) => print('onError $val'),
      );

      if (isAvailable) {
        setState(() {
          isListening = true;
        });

        _speech.listen(
          onResult: (val) => {
            setState(() {
              recognizedText = val.recognizedWords;
            })
          },
          localeId: 'ko-KR',
        );
      }
    } else {
      _speech.stop();
      setState(() {
        isListening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.text)),
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
        onPressed: onListen,
        child: Icon(!isListening ? Icons.mic : Icons.stop),
      ),
    );
  }
}
