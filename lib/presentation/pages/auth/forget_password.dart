import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yui_example/application/auth/forget_repository.dart';
import 'package:yui_example/presentation/pages/auth/auth_controller.dart';

class ForgetPassword extends ConsumerWidget {
  const ForgetPassword({super.key});

  static const routeName = 'forgetPassword';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_reset, size: 100.0, color: Colors.grey),
            const SizedBox(height: 20),
            Container(
              width: 300,
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 20),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey)),
                    labelText: "メールアドレスを入力"),
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
                          .read(forgetRepositoryProvider)
                          .resetPassword(email.text);
                      email.clear();
                    } catch (e) {
                      _showErrorSnackbar(context, e.toString());
                    }
                  },
                  child: const Text(
                    'パスワードをリセット',
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
