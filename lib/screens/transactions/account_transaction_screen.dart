import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/account/account_controller.dart';
import 'package:finsoft2/theme/constants.dart';
import 'package:finsoft2/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountTransactionScreen extends ConsumerWidget {
  const AccountTransactionScreen({Key? key, required this.txnType})
      : super(key: key);

  final String txnType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(operationalAccounsProvider(txnType));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Account"),
      ),
      //   bottomSheet: false == false
      //       ? Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                 color: Colors.lightBlue.shade100,
      //                 child: TextButton(
      //                     onPressed: () => Navigator.pushNamed(
      //                         context, "/payment",
      //                         arguments: account),
      //                     child: const Text(
      //                       "PAYMENT",
      //                       style: TextStyle(color: Colors.black),
      //                     )),
      //               ),
      //             ),
      //             Expanded(
      //               child: Container(
      //                 color: Colors.lightGreen.shade100,
      //                 child: TextButton(
      //                     onPressed: () => Navigator.pushNamed(
      //                         context, "/receipt",
      //                         arguments: account),
      //                     child: const Text(
      //                       "RECEIPT",
      //                       style: TextStyle(color: Colors.black),
      //                     )),
      //               ),
      //             ),
      //           ],
      //         )
      //       : const SizedBox.shrink(),
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

                    return ListTile(
                      dense: true,
                      title: Text(
                        account.name,
                        style: listTileStyle,
                      ),
                      onTap: () {
                        switch (txnType) {
                          case "RECEIPT":
                            Navigator.pushNamed(context, "/receipt",
                                arguments: account);
                            break;
                          default:
                            Navigator.pushNamed(context, "/payment",
                                arguments: account);
                        }
                      },
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
