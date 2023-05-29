import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// このプロバイダーは、FirebaseAuthのインスタンスを提供します。
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

// このプロバイダーは、FirebaseAuthのインスタンスを提供します。
final authStateProvider = StreamProvider<User?>((ref) {
  // このプロバイダーは、FirebaseAuthのインスタンスを提供します。
  final auth = ref.watch(firebaseAuthProvider);
  // FirebaseAuthのauthStateChangesメソッドを使用して、ユーザーの状態を監視します。
  return auth.authStateChanges();
});