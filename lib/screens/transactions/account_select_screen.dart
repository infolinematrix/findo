import 'package:animate_do/animate_do.dart';
import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/account/account_controller.dart';
import 'package:finsoft2/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountSelectScreen extends ConsumerWidget {
  const AccountSelectScreen({Key? key, required this.txnType})
      : super(key: key);

  final String txnType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(operationalAccounsProvider(txnType));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Account"),
      ),
      body: SafeArea(
          child: accounts.when(
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
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
                  itemBuilder: (BuildContext context, int index) {
                    AccountsModel account = data[index];

                    final accountModelMap = account;

                    return InkWell(
                      onTap: () {
                        switch (txnType) {
                          case "RECEIPT":
                            Navigator.pushNamed(
                                context, "/account_transactions", arguments: {
                              'txnType': 'RECEIPT',
                              'account': accountModelMap
                            });
                            break;
                          default:
                            Navigator.pushNamed(
                                context, "/account_transactions", arguments: {
                              'txnType': 'PAYMENT',
                              'account': accountModelMap
                            });
                        }
                      },
                      child: FadeInDown(
                        duration: Duration(milliseconds: (index + 1) * 100),
                        child: index % 2 != 0
                            ? AccountItem(
                                account: account,
                                color: Theme.of(context).primaryColorLight,
                              )
                            : AccountItem(
                                account: account,
                                // color: Theme.of(context).primaryColorLight,
                              ),
                      ),
                    );
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
