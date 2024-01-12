import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class BackupTile extends StatelessWidget {
  const BackupTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('데이터 백업하기'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        final dbFolder = await getDatabasesPath();
        File dbFile = File(join(dbFolder, 'memorize.db'));
        final isExists = await dbFile.exists();

        if (isExists) {
          try {
            final Email email = Email(
              body: '문장 암기 앱 백업 파일을 전송합니다.',
              subject: '문장 암기 앱 백업 파일',
              attachmentPaths: [dbFile.path],
              isHTML: false,
            );

            await FlutterEmailSender.send(email);
          } catch (e) {
            print(e);
          }
        }
      },
    );
  }
}
