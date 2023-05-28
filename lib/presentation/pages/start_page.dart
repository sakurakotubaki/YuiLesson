import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yui_example/presentation/pages/post_get.dart';
import 'package:yui_example/presentation/pages/second_page.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});
  // フルパスでルートを指定する。これがないと名前付きルートは使えない
  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // 画面遷移するときは、名前つきルートで書くとパスをあらかじめ指定してるので、してるので、書かなくてよい。
                // ただし、パスを指定したい場合は、GoRouter.of(context).go('/second'); と書く
                // context.go('/second');と短く書くこともできる
                context.goNamed(SecondPage.routeName);
              },
              child: const Text('Second Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.goNamed(PostGet.routeName);
              },
              child: const Text('Post Get'),
            ),
          ],
        ),
      ),
    );
  }
}
