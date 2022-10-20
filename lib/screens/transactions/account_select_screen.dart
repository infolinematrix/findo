import 'package:animate_do/animate_do.dart';
import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/screens/account/account_controller.dart';
import 'package:findo/theme/constants.dart';
import 'package:findo/utils/index.dart';
import 'package:findo/widgets/index.dart';
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

                    return FadeInDown(
                      duration: Duration(milliseconds: (index + 1) * 100),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        leading: Container(
                          width: 30.0.w,
                          margin: EdgeInsets.symmetric(vertical: 4.0.sp),
                          padding: EdgeInsets.all(4.0.sp),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.sp),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              account.name[0],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Theme.of(context).primaryColorDark),
                            ),
                          ),
                        ),
                        title: Text(
                          account.name,
                          style: listTileStyle.copyWith(),
                        ),
                        subtitle: const Text("Budget: 5000.0"),
                        onTap: () {
                          // switch (txnType) {
                          //   case "RECEIPT":

                          //     break;
                          //   default:
                          //     Navigator.pushNamed(
                          //         context, "/account_transactions",
                          //         arguments: account);
                          Navigator.pushNamed(context, "/account_transactions",
                              arguments: {
                                'txnType': txnType.toUpperCase().trim(),
                                'account': account
                              });
                        },
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
