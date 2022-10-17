import 'package:animate_do/animate_do.dart';
import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/account/account_controller.dart';
import 'package:finsoft2/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/account_create",
                arguments: account),
            icon: const Icon(Icons.add),
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

                        return account.isSystem == false
                            ? Slidable(
                                key: const ValueKey(0),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                      onPressed: (context) async {
                                        ref
                                            .read(accountProvider(account.id)
                                                .notifier)
                                            .delete()
                                            .then((value) {
                                          if (value == true) {
                                            showToast(msg: "Account deleted");
                                            Navigator.pop(context);
                                          } else {
                                            showToast(
                                                msg:
                                                    "Sorry! Account can't be delete");
                                          }
                                        });
                                      },
                                    ),
                                    SlidableAction(
                                      backgroundColor: const Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit,
                                      label: 'Update',
                                      onPressed: (context) {
                                        Navigator.pushNamed(
                                            context, "/account_update",
                                            arguments: account);
                                      },
                                    ),
                                  ],
                                ),
                                child: FadeInDown(
                                  duration:
                                      Duration(milliseconds: (index + 1) * 100),
                                  child: index % 2 != 0
                                      ? AccountListItemWidget(
                                          account: account, color: Colors.green)
                                      : AccountListItemWidget(
                                          account: account,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                ),
                              )
                            : FadeInDown(
                                duration:
                                    Duration(milliseconds: (index + 1) * 100),
                                child: index % 2 != 0
                                    ? AccountListItemWidget(
                                        account: account,
                                        color: Colors.greenAccent,
                                      )
                                    : AccountListItemWidget(
                                        account: account,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                              );
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.all(16.0.sp),
                      child: const Text("No Account created yet!"),
                    );
            },
          ),
        ),
      ),
    );
  }
}
