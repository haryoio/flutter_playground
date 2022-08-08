import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinity_list/providers/form.dart';
import 'package:infinity_list/providers/todo.dart';

class TodoPage extends ConsumerWidget {
  TodoPage({Key? key}) : super(key: key);

  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todolist = ref.watch(filterdTodos);
    final todosNotifier = ref.read(todoListProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('TodoList')),
      body: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TodoForm(),
              const SizedBox(
                height: 10,
              ),
              const Toolbar(),
              ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: todolist.length * 2,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (index.isOdd) return const Divider();

                  final i = index ~/ 2;

                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    key: Key(todolist[i].id),
                    onDismissed: (DismissDirection direction) {
                      todosNotifier.remove(todolist[i].id);
                      todolist.removeAt(index);
                    },
                    background: Container(
                      color: Colors.red,
                    ),
                    child: CheckboxListTile(
                      value: todolist[i].done,
                      onChanged: (e) => {
                        todosNotifier.toggle(todolist[i].id),
                      },
                      title: Text(todolist[i].description),
                    ),
                  );
                },
              )
            ],
          )),
    );
  }
}

@immutable
class TodoForm extends ConsumerWidget {
  TodoForm({Key? key}) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListNotifier = ref.read(todoListProvider.notifier);

    double screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: screenWidth * 0.6,
            child: TextField(
              autofocus: true,
              controller: _controller,
              textInputAction: TextInputAction.send,
              enabled: true,
              obscureText: false,
              maxLines: 1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Todo',
              ),
              onSubmitted: (value) {
                todoListNotifier.add(Todo(
                  id: Random().nextDouble().toString(),
                  description: value,
                  done: false,
                ));
                _controller.clear();
              },
            ),
          ),
          SizedBox(
            width: screenWidth * 0.2,
            height: 50,
            child: ElevatedButton(
              child: const Text('追加'),
              onPressed: () => {
                if (_controller.text.isNotEmpty)
                  {
                    todoListNotifier.add(Todo(
                        id: '${Random().nextDouble()}_${DateTime.now().toString()}',
                        description: _controller.text,
                        done: false)),
                  }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Toolbar extends HookConsumerWidget {
  const Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilter);

    Color? textColorFor(TodoListFilter value) {
      return filter == value ? Colors.blue : Colors.black;
    }

    return Material(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
          child: Text(
        '${ref.watch(uncompletedTodosCount).toString()} items left',
        overflow: TextOverflow.ellipsis,
      )),
      Tooltip(
          key: allFilterKey,
          message: 'All todos',
          child: TextButton(
            onPressed: () =>
                ref.read(todoListFilter.notifier).state = TodoListFilter.all,
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              foregroundColor:
                  MaterialStateProperty.all(textColorFor(TodoListFilter.all)),
            ),
            child: const Text('All'),
          )),
      Tooltip(
          key: activeFilterKey,
          message: 'Active todos',
          child: TextButton(
            onPressed: () =>
                ref.read(todoListFilter.notifier).state = TodoListFilter.active,
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.active)),
            ),
            child: const Text('Active'),
          )),
      Tooltip(
          key: completedFilterKey,
          message: 'Completed todos',
          child: TextButton(
            onPressed: () => ref.read(todoListFilter.notifier).state =
                TodoListFilter.completed,
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.completed)),
            ),
            child: const Text('Completed'),
          )),
    ]));
  }
}
