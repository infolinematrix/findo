import 'package:findo/screens/error_screen.dart';
import 'package:findo/widgets/index.dart';
import 'package:findo/widgets/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'account_transaction_controller.dart';

class AccountStatementScreen extends ConsumerWidget {
  const AccountStatementScreen({Key? key, required this.account})
      : super(key: key);

  final Map<String, dynamic> account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(accountTractionsProvider(account['id']));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statement"),
      ),
      body: SafeArea(
          child: transactions.when(
        error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          return data.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0.sp),
                      child: const Text("Filter"),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return TransactionWidget(txn: data[index]);
                      },
                    )
                  ],
                )
              : const NoDataScreen(
                  msg: "No Transaction found",
                );
        },
      )),
    );
  }
}
