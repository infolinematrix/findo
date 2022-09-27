import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String msg;
  const ErrorScreen({required this.msg, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Text(msg),
        ),
      ),
    );
  }
}
