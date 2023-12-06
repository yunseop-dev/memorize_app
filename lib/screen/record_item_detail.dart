import 'package:flutter/material.dart';
import 'package:flutter_todo/model/record_item.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_diff_text/pretty_diff_text.dart';

class RecordItemDetail extends HookConsumerWidget {
  final RecordItem item;
  final int index;

  const RecordItemDetail({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(memoryCardDetailProvider.call(item.memoryCardId));

    return switch (card) {
      AsyncError(:final error) => Text('Error: $error'),
      AsyncData(:final value) => Scaffold(
          appBar: AppBar(title: Text('${value.title} / 녹음 $index')),
          body: Container(
            color: Colors.green[100],
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                constraints: const BoxConstraints(maxWidth: 400.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextSection('Script', value.text,
                        backgroundColor: Colors.cyan.shade100),
                    _buildTextSection('Recorded', item.text,
                        backgroundColor: Colors.green.shade200),
                    _buildOutputSection(value.text),
                  ],
                ),
              ),
            ),
          )),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Widget _buildTextSection(String title, String text,
      {Color backgroundColor = Colors.transparent}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildOutputSection(String newText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Diffs',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 5.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.red.shade200,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: PrettyDiffText(
            oldText: item.text,
            newText: newText,
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
