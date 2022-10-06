import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountTransactionScreen extends ConsumerWidget {
  const AccountTransactionScreen({Key? key, required this.account})
      : super(key: key);

  final AccountsModel account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(account.name),
      ),
      bottomSheet: Container(
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/payment",
                      arguments: account),
                  child: const Text(
                    "PAYMENT",
                  )),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () => null,
                  child: const Text(
                    "RECEIPT",
                  )),
            ),
          ],
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("dfds"),
        ),
      ),
    );
  }
}
