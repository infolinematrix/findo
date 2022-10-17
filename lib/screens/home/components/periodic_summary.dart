import 'package:finsoft2/screens/home/home_controller.dart';
import 'package:finsoft2/services/settings_service.dart';
import 'package:finsoft2/utils/functions.dart';
import 'package:finsoft2/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

class PeriodicSummary extends StatelessWidget {
  const PeriodicSummary({Key? key, required this.data}) : super(key: key);

  final InitDataModel data;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0.sp, vertical: 8.0.sp),
        width: double.infinity,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Map<String, dynamic> para = {
                  'title': data.thisWeek['title'],
                  'startDate': firstDayOfWeek(),
                  'endDate': lastDayOfWeek()
                };
                Navigator.pushNamed(context, "/transactions", arguments: para);
              },
              child: SizedBox(
                height: 90.h,
                child: Card(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data.thisWeek['title'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                ),
                                UIHelper.horizontalSpaceSmall(),
                                const Icon(IcoFontIcons.thinRight),
                              ],
                            ),
                            Text(
                              "View All",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall(),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      "Income",
                                      style: const TextStyle().copyWith(
                                          color: Colors.grey.shade500),
                                    ),
                                    UIHelper.verticalSpaceExtraSmall(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          currencySymbol(),
                                          size: 18.0.sp,
                                          color: Colors.grey.shade500,
                                        ),
                                        Text(
                                          formatCurrency(
                                              data.thisDay['income']),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        UIHelper.horizontalSpaceSmall(),
                                        const Icon(
                                          IcoFontIcons.bubbleDown,
                                          color: Colors.red,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: VerticalDivider(
                                  thickness: 0.8,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      "Expenditure",
                                      style: const TextStyle().copyWith(
                                          color: Colors.grey.shade500),
                                    ),
                                    UIHelper.verticalSpaceExtraSmall(),
                                    Row(
                                      children: [
                                        Icon(
                                          currencySymbol(),
                                          size: 18.0.sp,
                                          color: Colors.grey.shade500,
                                        ),
                                        Text(
                                          formatCurrency(
                                              data.thisDay['expenditure']),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Map<String, dynamic> para = {
                  'title': data.thisMonth['title'],
                  'startDate': firstDayOfMonth(),
                  'endDate': lastDayOfMonth()
                };
                Navigator.pushNamed(context, "/transactions", arguments: para);
              },
              child: SizedBox(
                height: 90.h,
                child: Card(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data.thisMonth['title'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                ),
                                UIHelper.horizontalSpaceSmall(),
                                const Icon(IcoFontIcons.thinRight),
                              ],
                            ),
                            Text(
                              "View All",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall(),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      "Income",
                                      style: const TextStyle().copyWith(
                                          color: Colors.grey.shade500),
                                    ),
                                    UIHelper.verticalSpaceExtraSmall(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          currencySymbol(),
                                          size: 18.0.sp,
                                          color: Colors.grey.shade500,
                                        ),
                                        Text(
                                          formatCurrency(
                                              data.thisMonth['income']),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        UIHelper.horizontalSpaceSmall(),
                                        const Icon(
                                          IcoFontIcons.bubbleDown,
                                          color: Colors.red,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: VerticalDivider(
                                  thickness: 0.8,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      "Expenditure",
                                      style: const TextStyle().copyWith(
                                          color: Colors.grey.shade500),
                                    ),
                                    UIHelper.verticalSpaceExtraSmall(),
                                    Row(
                                      children: [
                                        Icon(
                                          currencySymbol(),
                                          size: 18.0.sp,
                                          color: Colors.grey.shade500,
                                        ),
                                        Text(
                                          formatCurrency(
                                              data.thisMonth['expenditure']),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Map<String, dynamic> para = {
                  'title': data.thisYear['title'],
                  'startDate': firstDayOfMonth(),
                  'endDate': lastDayOfMonth()
                };
                Navigator.pushNamed(context, "/transactions", arguments: para);
              },
              child: SizedBox(
                height: 90.h,
                child: Card(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  data.thisYear['title'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                ),
                                UIHelper.horizontalSpaceSmall(),
                                const Icon(IcoFontIcons.thinRight),
                              ],
                            ),
                            Text(
                              "View All",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceSmall(),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      "Income",
                                      style: const TextStyle().copyWith(
                                          color: Colors.grey.shade500),
                                    ),
                                    UIHelper.verticalSpaceExtraSmall(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          currencySymbol(),
                                          size: 18.0.sp,
                                          color: Colors.grey.shade500,
                                        ),
                                        Text(
                                          formatCurrency(
                                              data.thisYear['income']),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        UIHelper.horizontalSpaceSmall(),
                                        const Icon(
                                          IcoFontIcons.bubbleDown,
                                          color: Colors.red,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: VerticalDivider(
                                  thickness: 0.8,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    Text(
                                      "Expenditure",
                                      style: const TextStyle().copyWith(
                                          color: Colors.grey.shade500),
                                    ),
                                    UIHelper.verticalSpaceExtraSmall(),
                                    Row(
                                      children: [
                                        Icon(
                                          currencySymbol(),
                                          size: 18.0.sp,
                                          color: Colors.grey.shade500,
                                        ),
                                        Text(
                                          formatCurrency(
                                              data.thisYear['expenditure']),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
