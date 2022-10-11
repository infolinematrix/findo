import 'package:finsoft2/screens/account/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/constants.dart';

class AccountListScreen extends ConsumerWidget {
  const AccountListScreen({Key? key, this.parent}) : super(key: key);
  final int? parent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Parent Name"),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, "/account_create",
                arguments: parent),
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
                    )
                  : const Text("No Account created yet!");
            },
          ),
        ),
      ),
    );
  }
}
