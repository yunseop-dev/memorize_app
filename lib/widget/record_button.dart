import 'package:flutter/material.dart';
import 'package:flutter_todo/model/record_item.dart';
import 'package:flutter_todo/repository/record_item_repository.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RecordButton extends StatefulWidget {
  final String id;

  const RecordButton({Key? key, required this.id}) : super(key: key);

  @override
  RecordButtonState createState() => RecordButtonState();
}

class RecordButtonState extends State<RecordButton> {
  late stt.SpeechToText _speech;
  bool isListening = false;
  String recognizedText = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

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
          onResult: (val) {
            print(val.recognizedWords);
            setState(() {
              recognizedText = val.recognizedWords;
            });
          },
          localeId: 'ko-KR',
        );
      }
    } else {
      print('recognizedText fin: $recognizedText');
      RecordItem item =
          RecordItem(memoryCardId: widget.id, text: recognizedText);
      RecordItemRepository.add(item);
      _speech.stop();
      setState(() {
        isListening = false;
        recognizedText = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onListen,
      tooltip: '녹음하기',
      child: Icon(!isListening ? Icons.mic : Icons.stop),
    );
  }
}
