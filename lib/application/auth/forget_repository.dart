import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgetRepositoryProvider = Provider((ref) => ForgetRepository());

class ForgetRepository {
  final auth = FirebaseAuth.instance;
  // パスワードをリセットするメソッドです。
  Future<void> resetPassword(String email) async {
    try {
      final result = await auth.sendPasswordResetEmail(
        email: email);
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleError(e.code);
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }

  String _handleError(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'メールアドレスが無効。';
      case 'user-disabled':
        return 'このアカウントは無効になっています。';
      case 'user-not-found':
        return 'アカウントが見つかりません。';
      default:
        return 'エラーが発生しました。';
    }
  }
}