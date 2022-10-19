import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountTransactionScreen extends ConsumerWidget {
  const AccountTransactionScreen({Key? key, required this.account})
      : super(key: key);

  final AccountsModel account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(account.name)),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, bottom: 8.0.h),
        child: FormButtonRounded(
            text: const Text("Make Payment"),
            onTap: () {
              Navigator.pushNamed(context, "/payment", arguments: account);
            }),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            InfoBox(text: Text("Recent transactions")),
          ],
        ),
      ),
    );
  }
}
