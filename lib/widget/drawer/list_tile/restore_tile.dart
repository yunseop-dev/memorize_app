import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_todo/model/todo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:file_picker/file_picker.dart';

class RestoreTile extends HookConsumerWidget {
  const RestoreTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () async {
        String databasesPath = await getDatabasesPath();
        String dbPath = join(databasesPath, 'memorize.db');

        FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          File source = File(result.files.single.path!);
          await source.copy(dbPath);
          ref.refresh(todoListProvider.future);
        } else {
          // User canceled the picker
        }
      },
      title: const Text('데이터 불러오기'),
    );
  }
}
