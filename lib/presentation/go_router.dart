import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yui_example/infrastructure/auth_provider.dart';
import 'package:yui_example/presentation/pages/auth/forget_password.dart';
import 'package:yui_example/presentation/pages/auth/sign_in.dart';
import 'package:yui_example/presentation/pages/auth/sign_up.dart';
import 'package:yui_example/presentation/pages/post_get.dart';

// go_routerパッケージのGoRouterを使うためのProvider
final goRouterProvider = Provider((ref) {
  // authStateProviderを使って、ユーザーの状態を監視する
  final authState = ref.watch(authStateProvider);
  // GoRouterのインスタンスを作成する
  return GoRouter(
      // redirectを使用して、ログイン状態によってリダイレクトする
      redirect: (BuildContext context, GoRouterState state) {
        // ログインしていない場合は、ログインページにリダイレクトする
        if (authState.isLoading || authState.hasError) return null;

        // ログインしていなければ、ログインページにリダイレクトする
        final isStart = state.location == '/';

        // ログインしているかどうかを判定する
        // valueOrNullは、値がnullの場合はnullを返す
        final isAuth = authState.valueOrNull != null;

        // ログインしていない場合は、リダイレクトせずボタンを押すと次のページは画面遷移する
        // こんぶさんは素通りさせると表現していた
        if (isStart && !isAuth) {
          return null;
        }

        // ユーザーがログインしていれば、ログイン後のページへリダイレクトする
        if (isAuth) {
          return '/';
        }

      },
      initialLocation: '/sign_in', // 初期のルートを指定する
      routes: <RouteBase>[
        // GoRouteを使って、ルートを定義する
        GoRoute(
            path: '/',
            name: PostGet.routeName,
            builder: (context, state) => const PostGet()),
        GoRoute(
            path: '/sign_in', //　トップレベルのパスには、 / を指定する
            name: SignInPage.routeName, // ルートの名前を指定する
            builder: (context, state) => const SignInPage(),
            // ネストしたルートを定義する
            routes: [
              GoRoute(
                path:
                    'sign_up', // ネストしたルートのパスを指定する。 / は不要。トップレベルのパスとの重複は不可。新しいバージョンでは、つけたらエラーの原因になる
                name: SignUpPage.routeName,
                builder: (context, state) => const SignUpPage(),
              ),
              GoRoute(
                path: 'forget',
                name: ForgetPassword.routeName,
                builder: (context, state) => const ForgetPassword(),
              ),
            ]),
      ]);
});
