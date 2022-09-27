import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/index.dart';

class TransactionItem extends StatelessWidget {
  final DateTime? txnDate;
  final double amount;
  final String? account;
  final String? description;

  final String? txnType;
  final String? txnDrCr;
  final String? txnMode;
  const TransactionItem({
    Key? key,
    required this.txnDate,
    required this.amount,
    this.account,
    this.description,
    this.txnType,
    this.txnDrCr,
    this.txnMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String day;
    final String month;
    final String year;
    final String weekday;

    day = strToDay(txnDate.toString());
    month = strToShortMonth(txnDate.toString());
    year = strToYear(txnDate.toString());
    weekday = strToWeekDay(txnDate.toString());

    return Container(
      height: 50.0.sp,
      margin: EdgeInsets.only(bottom: 8.0.sp),
      decoration: BoxDecoration(
        color: Colors.white,
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
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.sp),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        day,
                        style: Theme.of(context).textTheme.headline4,
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
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(account.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                Flexible(
                  child: Text(description ?? 'No description',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("${txnDrCr == 'DR' ? '-' : '+'} ${formatCurrency(amount)}",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text("$txnMode $txnType",
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
