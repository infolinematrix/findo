import 'package:animate_do/animate_do.dart';
import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/screens/account/account_controller.dart';
import 'package:findo/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AccountListScreen extends ConsumerWidget {
  const AccountListScreen({Key? key, required this.parent}) : super(key: key);
  final AccountsModel parent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountProvider(parent.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(parent.name),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/account_create",
                arguments: parent),
            icon: const Icon(Icons.add),
          ),
        ],
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
                                    backgroundColor:
                                        Theme.of(context).primaryColorLight,
                                    foregroundColor:
                                        Theme.of(context).primaryColorDark,
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
                                    backgroundColor:
                                        Theme.of(context).primaryColorLight,
                                    foregroundColor:
                                        Theme.of(context).primaryColorDark,
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
                                    ? AccountItem(
                                        account: account,
                                        color: Theme.of(context).primaryColor)
                                    : AccountItem(
                                        account: account,
                                        color: Theme.of(context).primaryColor,
                                      ),
                              ),
                            )
                          : FadeInDown(
                              duration:
                                  Duration(milliseconds: (index + 1) * 100),
                              child: index % 2 != 0
                                  ? AccountItem(
                                      account: account,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : AccountItem(
                                      account: account,
                                      color: Theme.of(context).primaryColor,
                                    ),
                            );
                    },
                  )
                : InfoBox(
                    text: const Text(
                        "No Account created yet! Please create an account by tapping on Plus buttion."),
                    color: Theme.of(context).focusColor,
                  );
          },
        ),
      ),
    );
  }
}
