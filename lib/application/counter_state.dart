import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notifierにデータの型を指定する
class Counter extends Notifier<int> {
  @override
  // 初期値を指定する
  build() {
    return 0;
  }

  // 値を増やすメソッド
  void increment() {
    // stateとは、Notifierの状態を表す変数
    // stateはNotifierの状態を表す。++で値を増やす
    state++;
  }
  // 値をゼロにするメソッド
  void reset() {
    // 状態が0になる変数
    state = 0;
  }
}
// このProviderを使うと、Counterクラスのインスタンスを作成できる
final counterProvider = NotifierProvider<Counter, int>(Counter.new);