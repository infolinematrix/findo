import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'transation_controller.dart';

class AccountTransactionScreen extends ConsumerWidget {
  const AccountTransactionScreen({Key? key, required this.param})
      : super(key: key);

  final Map<String, dynamic> param;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AccountsModel account = param['account'];
    final transactions = ref.watch(transactionProvider(account.id));
    return Scaffold(
      appBar: AppBar(title: Text(account.name)),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            left: 16.0.w, right: 16.0.w, bottom: 8.0.h, top: 8.0.h),
        child: param['txnType'] == 'PAYMENT'
            ? FormButtonRounded(
                text: const Text("MAKE PAYMENT"),
                onTap: () {
                  Navigator.pushNamed(context, "/payment", arguments: account);
                })
            : FormButtonRounded(
                text: const Text("RECEIPT"),
                onTap: () {
                  Navigator.pushNamed(context, "/receipt", arguments: account);
                }),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const InfoBox(text: Text("Recent transactions")),
            transactions.when(
              error: (error, stackTrace) => Text(error.toString()),
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              data: (data) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TransactionWidget(txn: data[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
