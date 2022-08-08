import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinity_list/infinity_page.dart';
import 'package:infinity_list/main.dart';
import 'package:infinity_list/todo_page.dart';
import 'package:infinity_list/form_page.dart';
import 'package:infinity_list/river_counter_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hello = ref.watch(helloWorldProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(hello),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () => Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: ((context) =>
                        const InfinityPage(title: "RandomWordGenerator")),
                  )),
              child: const Text('to Infinity list view'),
            ),
            TextButton(
              onPressed: () => Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => TodoPage()),
                  )),
              child: const Text('to Todo list view'),
            ),
            TextButton(
              onPressed: () => Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: ((context) => const FormPage()),
                ),
              ),
              child: const Text('to Form page'),
            ),
            TextButton(
                onPressed: () => Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const RiverCounterPage()))),
                child: const Text('to River Counter Page'))
          ],
        ),
      ),
    );
  }
}
