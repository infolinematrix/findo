import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/transactions/transation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/index.dart';

class AccountTransactionScreen extends ConsumerWidget {
  const AccountTransactionScreen({Key? key, required this.account})
      : super(key: key);

  final AccountsModel account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider(account.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(account.name),
      ),
      bottomSheet: false == false
          ? Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.lightBlue.shade100,
                    child: TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, "/payment",
                            arguments: account),
                        child: const Text(
                          "PAYMENT",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.lightGreen.shade100,
                    child: TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, "/receipt",
                            arguments: account),
                        child: const Text(
                          "RECEIPT",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
      body: SafeArea(
          child: transactions.when(
        error: (error, stackTrace) => Text(error.toString()),
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        data: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const InfoBox(text: Text("List of Transactions")),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
                  itemBuilder: (BuildContext context, int index) {
                    return index % 2 != 0
                        ? TransactionWidget(
                            txn: data[index],
                            color: Colors.grey.shade100,
                          )
                        : TransactionWidget(txn: data[index]);
                  },
                ),
              ),
              CustomDividerView(
                dividerHeight: 30.0.h,
                color: Colors.transparent,
              ),
            ],
          );
        },
      )),
    );
  }
}
