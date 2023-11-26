import 'package:flutter/material.dart';
import 'package:pretty_diff_text/pretty_diff_text.dart';

class RecordItemDetail extends StatefulWidget {
  const RecordItemDetail({Key? key}) : super(key: key);

  @override
  RecordItemDetailState createState() => RecordItemDetailState();
}

class RecordItemDetailState extends State<RecordItemDetail> {
  String text = '내 녹음본';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('녹음 0')),
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
                  _buildTextSection(
                      'Script', '이스라엘아 들으라 우리 하나님 여호와는 오직 유일한 여호와이시니',
                      backgroundColor: Colors.cyan.shade100),
                  _buildTextSection(
                      'Recorded', '들으라 이스라엘아 우리 하나님 여호와는 오직 유일한 여호와이시니',
                      backgroundColor: Colors.green.shade200),
                  _buildOutputSection(),
                ],
              ),
            ),
          ),
        ));
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

  Widget _buildOutputSection() {
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
          child: const PrettyDiffText(
            oldText: '들으라 이스라엘아 우리 하나님 여호와는 오직 유일한 여호와이시니',
            newText: '이스라엘아 들으라 우리 하나님 여호와는 오직 유일한 여호와이시니',
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
