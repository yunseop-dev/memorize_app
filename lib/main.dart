import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:malo_aamgi/model/filtered_todo.dart';
import 'package:malo_aamgi/model/todo.dart';
import 'package:malo_aamgi/screen/oss_licenses_page.dart';
import 'package:malo_aamgi/widget/add_button.dart';
import 'package:malo_aamgi/widget/drawer/list_tile/backup_tile.dart';
import 'package:malo_aamgi/widget/drawer/list_tile/restore_tile.dart';
import 'package:malo_aamgi/widget/todo_list_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memorize App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends HookConsumerWidget {
  const TodoScreen({super.key});

  Future<void> _launchUrl(String uri) async {
    final Uri url = Uri.parse(uri);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Todo>> todo = ref.watch(filteredTodoProvider);
    final tapIndex = useState(0);
    final navIndex = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '말로암기',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: const [AddButton()],
        toolbarHeight: 72,
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        child: navIndex.value < 2
            ? Column(
                children: [
                  Visibility(
                    visible: navIndex.value == 1,
                    child: Row(children: <Widget>[
                      FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: tapIndex.value == 0
                                ? Colors.black
                                : Colors.white),
                        onPressed: () {
                          tapIndex.value = 0;
                          TodoListFilter type = TodoListFilter.values[0];
                          ref.read(todoListFilter.notifier).state = type;
                        },
                        child: Text(
                          '암기 중',
                          style: TextStyle(
                            color: tapIndex.value == 0
                                ? Colors.white
                                : Colors.black.withOpacity(0.3),
                            fontSize: 15,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: tapIndex.value == 1
                                ? Colors.black
                                : Colors.white),
                        onPressed: () {
                          tapIndex.value = 1;
                          TodoListFilter type = TodoListFilter.values[1];
                          ref.read(todoListFilter.notifier).state = type;
                        },
                        child: Text(
                          '암기 완료',
                          style: TextStyle(
                            color: tapIndex.value == 1
                                ? Colors.white
                                : Colors.black.withOpacity(0.3),
                            fontSize: 15,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 24),
                      child: switch (todo) {
                        AsyncError(:final error) => Text('Error: $error'),
                        AsyncData(:final value) => ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              Todo item = value[index];
                              return TodoListTile(item: item);
                            }),
                        _ => const Center(child: CircularProgressIndicator()),
                      },
                    ),
                  )
                ],
              )
            : ListView(
                padding: EdgeInsets.zero,
                children: [
                  const ListTile(
                    title: Text(
                      '데이터 백업 & 복원',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const BackupTile(),
                  const RestoreTile(),
                  const ListTile(
                    title: Text(
                      '서비스 정보',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: const Text('문의하기'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _launchUrl('mailto:c.o.d.e@kakao.com');
                    },
                  ),
                  ListTile(
                    title: const Text('사용 가이드'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _launchUrl(
                          'https://www.notion.so/yunseop/57ca5b3034f540a5b624b06459444880?pvs=4');
                    },
                  ),
                  ListTile(
                    title: const Text('개인정보처리방침'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      _launchUrl(
                          'https://yunseop.notion.site/98746330a18e47f18133f2fa8fa7a4f7?pvs=4');
                    },
                  ),
                  ListTile(
                    title: const Text('오픈소스 라이선스'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const OssLicensesPage()));
                    },
                  ),
                ],
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: '전체보기'),
          BottomNavigationBarItem(icon: Icon(Icons.done_all), label: '암기 목록'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: '더보기'),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        currentIndex: navIndex.value,
        onTap: (value) {
          navIndex.value = value;
          if (value == 0) {
            tapIndex.value = 2;
            TodoListFilter type = TodoListFilter.values[2];
            ref.read(todoListFilter.notifier).state = type;
          }
          if (value == 1) {
            tapIndex.value = 0;
            TodoListFilter type = TodoListFilter.values[0];
            ref.read(todoListFilter.notifier).state = type;
          }
        },
      ),
    );
  }
}
