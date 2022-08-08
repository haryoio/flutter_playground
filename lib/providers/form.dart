import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final formNotifierProvider =
    StateNotifierProvider<FormNotifier, String>((ref) => FormNotifier());

class FormNotifier extends StateNotifier<String> {
  FormNotifier() : super('');

  void change(text) {
    state = text;
  }

  void clear() {
    state = '';
  }
}
