import 'package:flutter/material.dart';
import 'package:malo_aamgi/model/record_item.dart';
import 'package:malo_aamgi/model/todo.dart';
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
          appBar: AppBar(
            title: Text('${value.title} / 녹음 $index'),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
          body: Container(
            color: Colors.green[100],
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(16.0),
                constraints: const BoxConstraints(maxWidth: 400.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextSection('내용', value.text,
                        backgroundColor: Colors.cyan.shade100),
                    _buildTextSection('녹음한 내용', item.text,
                        backgroundColor: Colors.blueGrey.shade50),
                    _buildOutputSection(value.text,
                        backgroundColor: value.text == item.text
                            ? Colors.green.shade200
                            : Colors.red.shade50),
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
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: Text(
              title,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputSection(String newText,
      {Color backgroundColor = Colors.transparent}) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(0.1),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: const Text(
              '정답 확인',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          PrettyDiffText(
            oldText: item.text,
            newText: newText,
            defaultTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
