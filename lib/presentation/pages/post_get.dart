import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yui_example/application/auth/auth_repository.dart';
import 'package:yui_example/application/post_future.dart';

class PostGet extends ConsumerWidget {
  const PostGet({super.key});

  static const routeName = '/get';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watchでpostFutureProviderを読み込む
    // FutureProviderを使用すると変数の型はAsyncValueになる
    // AsyncValueはデータの状態を表すクラスで、データが取得中か、取得成功したか、取得失敗したかを表す
    final postFuture = ref.watch(postFutureProvider);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await ref.read(authRepositoryProvider).signOut();
              },
              icon: const Icon(Icons.logout),
            )
          ],
          title: const Text('Post Get'),
        ),
        // postFuture.whenでデータの状態によって処理を分ける
        body: postFuture.when(
            // データが取得中の場合
            loading: () => const CircularProgressIndicator(),
            // データが取得失敗した場合
            error: (err, stack) => Text('Error: $err'),
            // データが取得成功した場合
            data: (config) {
              // ListView.builderでリストを作成する
              return ListView.builder(
                itemCount: config.length, // リストの長さを指定する
                itemBuilder: (context, index) {
                  final post = config[index]; // リストの要素を取得する
                  return ListTile(
                    title: Text(post.title), // リストのタイトルを表示する
                    subtitle: Text(post.body), // リストのサブタイトルを表示する
                  );
                },
              );
            }));
  }
}
