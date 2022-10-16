import 'package:animate_do/animate_do.dart';
import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/account/account_controller.dart';
import 'package:finsoft2/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/account_item_widget.dart';

class AccountListScreen extends ConsumerWidget {
  const AccountListScreen({Key? key, this.account}) : super(key: key);
  final Map<String, dynamic>? account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountProvider(account!['parent']));

    return Scaffold(
      appBar: AppBar(
        title: Text(account == null ? "Parent Name" : account!['name']),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, "/account_create",
                arguments: account),
            child: const Text("CREATE"),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: accounts.when(
            error: (error, stackTrace) => Text(error.toString()),
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            data: (data) {
              return data.isNotEmpty
                  ? ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1.0.h,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        AccountsModel account = data[index];
                        return FadeInDown(
                          duration: Duration(milliseconds: (index + 1) * 100),
                          child: index % 2 != 0
                              ? AccountListItemWidget(
                                  account: account, color: AppColors.listColor1)
                              : AccountListItemWidget(
                                  account: account,
                                  color: AppColors.listColor2),
                        );
                      },
                    )
                  : const Text("No Account created yet!");
            },
          ),
        ),
      ),
    );
  }
}
