import 'package:finsoft2/screens/ledger/ledger_controller.dart';
import 'package:finsoft2/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LedgerListScreen extends ConsumerWidget {
  const LedgerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ledgers = ref.watch(ledgerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Group"),
        actions: [
          OutlinedButton(
            onPressed: () => null,
            child: const Text("CREATE"),
          ),
        ],
      ),
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
                    onTap: () => Navigator.pushNamed(context, "/account_list",
                        arguments: data[index]),
                    dense: true,
                    title: Text(
                      data[index].name,
                      style: listTileStyle,
                    ),
                    subtitle: Text("#ID ${data[index].id.toString()}"),
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
