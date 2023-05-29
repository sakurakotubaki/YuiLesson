import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// プロバイダーを使用して、テキストフィールドの状態を管理する
// emailの入力で使用する
final emailProvider =
    StateProvider.autoDispose((ref) => TextEditingController());
// passwordの入力で使用する
final passwordProvider =
    StateProvider.autoDispose((ref) => TextEditingController());
