import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinity_list/providers/todo.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});
  @override
  State<StatefulWidget> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late TextEditingController _controller;

  String _text = '';

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('form'),
        ),
        body: Container(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
              Text(
                _text,
                style: const TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextField(
                enabled: true,
                maxLength: 10,
                style: const TextStyle(color: Colors.red),
                obscureText: false,
                maxLines: 1,
                onChanged: _handleText,
              ),
            ],
          ),
        ));
  }
}
