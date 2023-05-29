import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yui_example/application/auth/auth_repository.dart';
import 'package:yui_example/presentation/pages/auth/auth_controller.dart';
import 'package:yui_example/presentation/pages/auth/forget_password.dart';
import 'package:yui_example/presentation/pages/auth/sign_up.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  static const routeName = '/signInPage';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              const Icon(Icons.lock_rounded, size: 100.0, color: Colors.grey),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey)),
                      labelText: "メールアドレスを入力"),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextFormField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 20),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey)),
                      labelText: "パスワードを入力"),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 40,
                child: OutlinedButton(
                    onPressed: () async {
                      try {
                        // awaitをつけないと、処理を待たずに次の処理に進んでしまう。
                        // そのため、awaitをつけて処理を待つようにする。
                        await ref
                            .read(authRepositoryProvider)
                            .signIn(email.text, password.text);
                            // ログインに成功したら、emailとpasswordの値をクリアする。
                            email.clear();
                            password.clear();
                      } catch (e) {
                        _showErrorSnackbar(context, e.toString());
                      }
                    },
                    child: const Text(
                      'ログイン',
                      style: TextStyle(color: Colors.black),
                    )),
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    context.goNamed(SignUpPage.routeName);
                  },
                  child: const Text('新規登録')),
              const SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    context.goNamed(ForgetPassword.routeName);
                  },
                  child: const Text('パスワードを忘れた')),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // エラーが出たら、スナックバーを表示するメソッド
  void _showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
