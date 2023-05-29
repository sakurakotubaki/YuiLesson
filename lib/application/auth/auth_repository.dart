import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// このプロバイダーは、FirebaseAuthのインスタンスを提供します。
final authRepositoryProvider = Provider((ref) => AuthRepository());

// このクラスは、FirebaseAuthのインスタンスを提供します。
class AuthRepository {
  // FirebaseAuthのインスタンスを取得します。
  final auth = FirebaseAuth.instance;
  // ログインをするメソッドです。
  Future<UserCredential> signIn(String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleError(e.code);
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }
  // ユーザーのアカウントを作成するメソッドです。
  Future<UserCredential> signUp(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleError(e.code);
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }
  // ログアウトをするメソッドです。
  Future<void> signOut() async {
    await auth.signOut();
  }
  // エラーをハンドリングするメソッドです。
  String _handleError(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'メールアドレスが無効。';
      case 'user-disabled':
        return 'このアカウントは無効になっています。';
      case 'user-not-found':
        return 'アカウントが見つかりません。';
      case 'wrong-password':
        return 'パスワードが一致しません。';
      default:
        return 'エラーが発生しました。';
    }
  }
}