import 'package:findo/data/models/transactions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/index.dart';

class TransactionWidget extends ConsumerWidget {
  const TransactionWidget({Key? key, required this.txn, this.color})
      : super(key: key);
  final TransactionsModel txn;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String day = txn.txnDate!.day.toString();
    String month = strToShortMonth(txn.txnDate!.month);
    String year = txn.txnDate!.year.toString();
    String weekday = strToWeekDay(txn.txnDate!);

    return Container(
      height: 50.0.sp,
      margin: EdgeInsets.only(bottom: 8.0.sp),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8.sp),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 10.sp),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(4.0.sp),
                    decoration: BoxDecoration(
                      color: txn.txnType == 'DR'
                          ? Colors.lightBlue.shade100
                          : Colors.lightGreen.shade100,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.sp),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        day,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
                UIHelper.horizontalSpaceSmall(),
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$month, $year",
                          style: Theme.of(context).textTheme.bodyText1),
                      Text(weekday,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
          UIHelper.horizontalSpaceSmall(),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(txn.narration.toString().trim(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith()),
                ),
                Flexible(
                  child: Text(txn.description ?? 'No description',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    "${txn.txnType == 'DR' ? '-' : '+'} ${formatCurrency(txn.amount)}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text(txn.txnType, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
