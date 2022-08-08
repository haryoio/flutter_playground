import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinity_list/providers/counter.dart';

class RiverCounterPage extends ConsumerWidget {
  const RiverCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countStateController = ref.read(countNotifierProvider.notifier);
    final count = ref.watch(countNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Counter state managed by Riverpod')),
      body: Center(
        child: Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          countStateController.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
