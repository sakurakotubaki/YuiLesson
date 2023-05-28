// JsonPlaceFolderで使用するモデルクラス
// 使ったコンストラクタはfactoryコンストラクタ。
// factoryコンストラクタとは、インスタンスを生成するメソッドのこと。
// インスタンスを生成する目的は、クラスのプロパティに値をセットすること。
class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}