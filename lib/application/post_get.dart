import 'dart:convert';// JSONのデコードに必要

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;// httpパッケージをhttpとしてインポート
import 'package:yui_example/domain/post_model.dart';// Postモデルをインポート

final postClientProvider = Provider((ref) => PostClient());// PostClientを読み込むProvider

// httpパッケージを使用してJSONPlaceholderからデータを取得するクラス
class PostClient {
  // JSONPlaceholderのURL
  final _baseUrl = 'https://jsonplaceholder.typicode.com';
  // httpパッケージのClientクラス
  final _client = http.Client();
  // JSONPlaceholderからデータを取得するメソッド
  Future<List<Post>> getPosts() async {
    final url = '$_baseUrl/posts';
    final response = await _client.get(Uri.parse(url));
    final List<dynamic> json = jsonDecode(response.body);
    return json.map((e) => Post.fromJson(e)).toList();
  }
}