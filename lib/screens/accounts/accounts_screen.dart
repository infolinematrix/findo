import 'package:animate_do/animate_do.dart';
import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/theme/colors.dart';
import 'package:finsoft2/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

import '../../routes/app_pages.dart';
import '../../widgets/index.dart';
import '../error_screen.dart';
import '../loading.dart';
import 'accounts_controller.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accounts = ref.watch(accountsProvider);
    return accounts.when(
        error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
        loading: () => const Center(
              child: Loading(),
            ),
        data: (data) {
          return Scaffold(
            appBar: AppBar(title: const Text("Accounts")),
            floatingActionButton: FloatingActionButton(
              elevation: 1.0,
              backgroundColor: const Color(0xFFE57373),
              onPressed: () {
                Navigator.pushNamed(context, '/account_create');
              },
              child: Icon(
                Icons.add,
                size: 28.0.sp,
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InfoBox(
                    text: Text(
                      "Select Account",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    color: Colors.transparent,
                  ),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: data.length,
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                        color: AppColors.lightGrey,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        AccountsModel account = data[index];
                        int i = index;
                        return BounceInDown(
                          duration: Duration(milliseconds: (index + 1) * 100),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.accountTransactions,
                                  arguments: account);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 12.0.sp,
                                  bottom: 12.0.sp,
                                  left: 8.0.sp,
                                  right: 16.0.sp),
                              margin: EdgeInsets.only(
                                  bottom: 8.0.sp,
                                  left: 16.0.sp,
                                  right: 16.0.sp),
                              decoration: BoxDecoration(
                                color: i % 2 == 0
                                    ? const Color(0xFFF7F7F9)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      IcoFontIcons.blockRight,
                                      color: AppColors.lightGrey,
                                      size: 32.sp,
                                    ),
                                  ),
                                  UIHelper.horizontalSpaceSmall(),
                                  Expanded(
                                    flex: 9,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          account.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          account.budget == 0
                                              ? "No Budget"
                                              : "Limit : ${account.budget}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
