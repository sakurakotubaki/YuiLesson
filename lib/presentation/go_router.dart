import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yui_example/presentation/pages/post_get.dart';
import 'package:yui_example/presentation/pages/second_page.dart';
import 'package:yui_example/presentation/pages/start_page.dart';

// go_routerパッケージのGoRouterを使うためのProvider
final goRouterProvider = Provider((ref) {
  // GoRouterのインスタンスを作成する
  return GoRouter(routes: <RouteBase>[
    // GoRouteを使って、ルートを定義する
    GoRoute(
        path: '/', //　トップレベルのパスには、 / を指定する
        name: StartPage.routeName, // ルートの名前を指定する
        builder: (context, state) => const StartPage(),
        // ネストしたルートを定義する
        routes: [
          GoRoute(
            path: 'second', // ネストしたルートのパスを指定する。 / は不要。トップレベルのパスとの重複は不可。新しいバージョンでは、つけたらエラーの原因になる
            name: SecondPage.routeName,
            builder: (context, state) => const SecondPage(),
          ),
          // 上と同じようにネストしたルートを定義する
          GoRoute(
              path: 'get',
              name: PostGet.routeName,
              builder: (context, state) => const PostGet()),
        ]),
  ]);
});
