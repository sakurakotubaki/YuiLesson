import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yui_example/application/auth/auth_repository.dart';
import 'package:yui_example/presentation/pages/auth/auth_controller.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  static const routeName = 'signUpPage';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_person_rounded,
                size: 100.0, color: Colors.grey),
            const SizedBox(height: 20),
            Container(
              width: 300,
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey)),
                    labelText: "メールアドレスを入力"),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              child: TextFormField(
                obscureText: true,
                controller: password,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey)),
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
                      await ref
                          .read(authRepositoryProvider)
                          .signUp(email.text, password.text);
                          email.clear();
                          password.clear();
                    } catch (e) {
                      _showErrorSnackbar(context, e.toString());
                    }
                  },
                  child: const Text(
                    'ユーザー新規登録',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // スナックバーを表示するメソッド
  void _showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
