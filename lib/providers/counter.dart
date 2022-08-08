import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///  Provider: 外部から変更することはできない。
final helloWorldProvider = Provider((_) => 'Hello World');

/// StateNotifierProvider: 外部から値を変更できる。
final countNotifierProvider =
    StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

/// StateNotifier: 外部から値を変更するときはこれを呼ぶ必要がある。
/// example
/// ```dart
/// Widget build(BuildContext context, WidgetRef ref) {
///   final countStateController = ref.read(countNotifierProvider.notifier);
///   final count = ref.watch(countNotifierProvider);
///
///   return Scaffold(
///     body: Center(
///       child: Text(count.toString()),
///     ),
///     floatingActionButton: FloatingActionButton(
///       onPressed: () {
///         counterStateController.increment();
///       },
///       child: const Icon(Icons.add),
///     )
///   )
/// }
/// ```
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}
