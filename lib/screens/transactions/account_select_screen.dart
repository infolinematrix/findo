import 'package:animate_do/animate_do.dart';
import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/account/account_controller.dart';
import 'package:finsoft2/utils/index.dart';
import 'package:finsoft2/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColorLight,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(Iconsax.search_normal),
                      UIHelper.horizontalSpaceSmall(),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Search by name',
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      UIHelper.horizontalSpaceSmall(),
                      const Icon(Iconsax.activity)
                    ],
                  ),
                ),
              )),
        ),
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
                                color: Theme.of(context).primaryColor,
                              )
                            : AccountItem(
                                account: account,
                                color: Theme.of(context).primaryColor,
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
