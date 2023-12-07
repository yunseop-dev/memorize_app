import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_todo/model/record_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RecordButton extends HookConsumerWidget {
  final String id;
  final stt.SpeechToText _speech;

  RecordButton({super.key, required this.id}) : _speech = stt.SpeechToText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isListening = useState(false);
    final recognizedText = useState('');
    return FloatingActionButton(
      onPressed: () async {
        if (!isListening.value) {
          bool isAvailable = await _speech.initialize(
            onStatus: (val) => print('onStatus $val'),
            onError: (val) => print('onError $val'),
          );

          if (isAvailable) {
            isListening.value = true;

            _speech.listen(
              onResult: (val) {
                print(val.recognizedWords);
                recognizedText.value = val.recognizedWords;
              },
              localeId: 'ko-KR',
            );
          }
        } else {
          print('recognizedText fin: $recognizedText');
          RecordItem item =
              RecordItem(memoryCardId: id, text: recognizedText.value);
          ref.watch(RecordItemListProvider(id).notifier).add(item);

          _speech.stop();

          isListening.value = false;
          recognizedText.value = '';
        }
      },
      tooltip: '녹음하기',
      child: Icon(!isListening.value ? Icons.mic : Icons.stop),
    );
  }
}
