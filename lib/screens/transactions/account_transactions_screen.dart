import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountTransactionScreen extends ConsumerWidget {
  const AccountTransactionScreen({Key? key, required this.param})
      : super(key: key);

  final Map<String, dynamic> param;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("$param['account'].name")),
      body: const SafeArea(
        child: Text("dfsds"),
      ),
    );
  }
}
