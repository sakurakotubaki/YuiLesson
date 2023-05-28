import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yui_example/application/counter_state.dart';

class SecondPage extends ConsumerWidget {
  const SecondPage({super.key});
  // フルパスでルートを指定する。これがないと名前付きルートは使えない
  static const routeName = '/second';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('count: $count', style: const TextStyle(fontSize: 40)),
            ElevatedButton(
              onPressed: () {
                // ref.readでcounterProviderを読み込み、Notifierのincrementメソッドを呼び出す
                ref.read(counterProvider.notifier).increment();
              },
              child: const Text('カウンターを増やす'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ref.readでcounterProviderを読み込み、Notifierのresetメソッドを呼び出す
                ref.read(counterProvider.notifier).reset();
              },
              child: const Text('カウンターをリセット'),
            ),
          ],
        ),
      ),
    );
  }
}
