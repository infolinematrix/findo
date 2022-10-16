import 'package:animate_do/animate_do.dart';
import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/account/account_controller.dart';
import 'package:finsoft2/theme/styles.dart';
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
<<<<<<< HEAD
=======
      // bottomSheet: false == false
      //     ? Row(
      //         children: [
      //           Expanded(
      //             child: Container(
      //               color: Colors.lightBlue.shade100,
      //               child: TextButton(
      //                   onPressed: () => Navigator.pushNamed(
      //                       context, "/payment",
      //                       arguments: account),
      //                   child: const Text(
      //                     "PAYMENT",
      //                     style: TextStyle(color: Colors.black),
      //                   )),
      //             ),
      //           ),
      //           Expanded(
      //             child: Container(
      //               color: Colors.lightGreen.shade100,
      //               child: TextButton(
      //                   onPressed: () => Navigator.pushNamed(
      //                       context, "/receipt",
      //                       arguments: account),
      //                   child: const Text(
      //                     "RECEIPT",
      //                     style: TextStyle(color: Colors.black),
      //                   )),
      //             ),
      //           ),
      //         ],
      //       )
      //     : const SizedBox.shrink(),
>>>>>>> 3e88900f7094f933b75ddadb8baf31f97d3dcf08
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

<<<<<<< HEAD
<<<<<<< HEAD
=======
                    final accountModelMap = account;

>>>>>>> d59cd6a26e9323ddcf9490579b44024ca1a0d4c3
=======
                    final accountModelMap = account;

>>>>>>> 3e88900f7094f933b75ddadb8baf31f97d3dcf08
                    return InkWell(
                      onTap: () {
                        switch (txnType) {
                          case "RECEIPT":
                            Navigator.pushNamed(
                                context, "/account_transactions", arguments: {
                              'txnType': 'RECEIPT',
<<<<<<< HEAD
                              'account': account
=======
                              'account': accountModelMap
>>>>>>> 3e88900f7094f933b75ddadb8baf31f97d3dcf08
                            });
                            break;
                          default:
                            Navigator.pushNamed(
                                context, "/account_transactions", arguments: {
                              'txnType': 'PAYMENT',
<<<<<<< HEAD
                              'account': account
=======
                              'account': accountModelMap
>>>>>>> 3e88900f7094f933b75ddadb8baf31f97d3dcf08
                            });
                        }
                      },
                      child: FadeInDown(
                        duration: Duration(milliseconds: (index + 1) * 100),
                        child: index % 2 != 0
                            ? AccountItem(
                                account: account, color: AppColors.listColor1)
                            : AccountItem(
                                account: account, color: AppColors.listColor2),
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
