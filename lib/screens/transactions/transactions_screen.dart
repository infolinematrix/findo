import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../utils/index.dart';
import '../../widgets/index.dart';
import '../error_screen.dart';
import '../loading.dart';
import 'transaction_controller.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({Key? key, required this.parameters})
      : super(key: key);

  final Map<String, dynamic> parameters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsFutureProvider(parameters));

    return Scaffold(
      appBar: AppBar(title: Text(parameters['title'])),
      body: SafeArea(
        child: transactions.when(
          error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
          loading: () => const Center(
            child: Loading(),
          ),
          data: (data) {
            if (data.isEmpty) {
              return const Text("No transtions found...");
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InfoBox(
                    text: Text(
                      "Transactions",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    color: Colors.transparent,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final txn = data[index];

                          return Container(
                            margin:
                                EdgeInsets.only(left: 8.0.sp, right: 8.0.sp),
                            child: BounceInDown(
                              duration:
                                  Duration(milliseconds: (index + 1) * 100),
                              child: Slidable(
                                key: ValueKey(index),
                                endActionPane: ActionPane(
                                  extentRatio: .20.sp,
                                  dragDismissible: true,
                                  motion: const ScrollMotion(),
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        UIHelper.horizontalSpaceMedium(),
                                        Container(
                                          height: 50.0.sp,
                                          margin:
                                              EdgeInsets.only(bottom: 8.0.sp),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8.sp),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.sp, vertical: 8.sp),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () async {
                                              AlertAction? action =
                                                  await confirmDialog(context,
                                                      "Are you sure? \nOnce delete the it can't be recover.");

                                              if (action == AlertAction.ok) {}
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                
                                child: TransactionItemWidget(transaction: txn),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
