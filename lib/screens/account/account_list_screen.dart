import 'package:finsoft2/data/models/ledger_model.dart';
import 'package:finsoft2/screens/account/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/constants.dart';

class AccountListScreen extends ConsumerWidget {
  const AccountListScreen({Key? key, required this.ledger}) : super(key: key);
  final LedgerModel ledger;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ledgers = ref.watch(accountsByLedgerProvider(ledger.id));

    return Scaffold(
      appBar: AppBar(title: Text(ledger.name)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: ledgers.when(
            error: (error, stackTrace) => Text(error.toString()),
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            data: (data) {
              return ListView.separated(
                itemCount: data.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1.0.h,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    dense: true,
                    title: Text(
                      data[index].name,
                      style: listTileStyle,
                    ),
                    onTap: () => Navigator.pushNamed(
                        context, "/account_transactions",
                        arguments: data[index]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
