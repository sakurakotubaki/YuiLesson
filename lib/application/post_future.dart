import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yui_example/application/post_get.dart';
import 'package:yui_example/domain/post_model.dart';
// PostClientを読み込むProvider
final postFutureProvider = FutureProvider.autoDispose<List<Post>>((ref) async {
  // ref.watchでPostClientを読み込み、getPostsメソッドを呼び出す
  final posts = await ref.watch(postClientProvider).getPosts();
  return posts;
});