import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../services/settings_service.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';
import '../error_screen.dart';
import '../loading.dart';
import 'components/main_menu.dart';
import 'components/periodic_summary.dart';
import 'home_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomeScreen> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);

    super.initState();
  }

  void _listenToScrollChange() {
    if (_scrollController.offset >= 100.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final homeData = ref.watch(homeDataProvider);
    return AdvancedDrawer(
      backdropColor: Colors.grey.shade900,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade900,
            blurRadius: 20.0,
            spreadRadius: 5.0,
            offset: const Offset(-20.0, 0.0),
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      drawer: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          child: ListTileTheme(
            // textColor: Colors.white,
            // iconColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80.0.sp,
                  height: 80.0.sp,
                  margin: EdgeInsets.only(
                    left: 20.sp,
                    top: 24.0.sp,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    // color: Colors.grey.shade800,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    IcoFontIcons.flora,
                    color: Colors.yellow.shade600,
                    size: 45,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    getSetting(key: 'name').value.toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                Divider(
                  color: Colors.grey.shade800,
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Iconsax.home),
                  title: const Text('Dashboard'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Iconsax.chart_2),
                  title: const Text('Analytics'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Iconsax.profile_2user),
                  title: const Text('Contacts'),
                ),
                const SizedBox(
                  height: 50,
                ),
                Divider(color: Colors.grey.shade800),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Iconsax.setting_2),
                  title: const Text('Settings'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Iconsax.support),
                  title: const Text('Support'),
                ),
                ListTile(
                  onTap: () async {
                    await ref.watch(resetBoxProvider.future).then((value) {
                      if (value == true) {
                        showToast(msg: "Reset Datababase");
                        exit(0);
                      }
                    });
                  },
                  leading: const Icon(Iconsax.support),
                  title: const Text('Reset Database'),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        body: homeData.when(
          error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
          loading: () => const Center(
            child: Loading(),
          ),
          data: (data) {
            return SafeArea(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 240.0.sp,
                    elevation: 0,
                    pinned: true,
                    stretch: true,
                    toolbarHeight: 80.sp,
                    leading: IconButton(
                      // color: Colors.black,
                      onPressed: _handleMenuButtonPressed,
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: _advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              value.visible ? IcoFontIcons.close : Iconsax.menu,
                              // color: Colors.white,
                              key: ValueKey<bool>(value.visible),
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(
                          Iconsax.notification,
                          // color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Iconsax.more,
                          // color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    centerTitle: true,
                    title: AnimatedOpacity(
                      opacity: _isScrolled ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Column(
                        children: [
                          Text(
                            getSetting(key: 'name').value.toString(),
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: 18.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20.0.sp,
                          ),
                          Container(
                            width: 30.0.sp,
                            height: 4.0.sp,
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      titlePadding: const EdgeInsets.only(left: 20, right: 20),
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: _isScrolled ? 0.0 : 1.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            UIHelper.verticalSpaceSmall(),
                            Text(
                              data.thisDay['title'],
                              style: TextStyle(
                                  // color: Colors.white,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0.sp, horizontal: 16.0.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      children: [
                                        Text(
                                          "Income",
                                          style: const TextStyle().copyWith(
                                              // color: Colors.white54,
                                              fontSize: 10.sp),
                                        ),
                                        UIHelper.verticalSpaceExtraSmall(),
                                        Row(
                                          children: [
                                            Icon(
                                              currencySymbol(),
                                              size: 14.0.sp,
                                              // color: Colors.white30,
                                            ),
                                            Text(
                                              data.thisDay['income'].toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      // color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: VerticalDivider(
                                      thickness: 1.8.sp,
                                      // color: Colors.white,
                                      // width: 10,
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
                                              // color: Colors.white54,
                                              fontSize: 10.sp),
                                        ),
                                        UIHelper.verticalSpaceExtraSmall(),
                                        Row(
                                          children: [
                                            Icon(
                                              currencySymbol(),
                                              size: 14.0.sp,
                                              // color: Colors.white30,
                                            ),
                                            Text(
                                              data.thisDay['expenditure']
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      // color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            Container(
                              width: 30.0.sp,
                              height: 3.0.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            UIHelper.verticalSpaceSmall()
                          ],
                        ),
                      ),
                    ),
                  ),

                  //---------------
                  const MainMenuWidget(),

                  //----------------
                  PeriodicSummary(data: data),

                  //---------------
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, "/group_list"),
                            child: const Text("Accounts")),
                      ],
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pushNamed(
                              context, "/account_select",
                              arguments: "RECEIPT"),
                          child: const Text("Receipt"),
                        ),
                        OutlinedButton(
                          onPressed: () => Navigator.pushNamed(
                              context, "/account_select",
                              arguments: "PAYMENT"),
                          child: const Text("Payment"),
                        ),
                        OutlinedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "/transfer"),
                          child: const Text("Transfer"),
                        ),
                      ],
                    ),
                  ),

                  // SliverToBoxAdapter(
                  //   child: Container(
                  //     margin: EdgeInsets.symmetric(
                  //         horizontal: 8.0.sp, vertical: 8.0.sp),
                  //     width: double.infinity,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Todays' Transactions",
                  //           style: Theme.of(context).textTheme.subtitle2,
                  //         ),
                  //         ListView.builder(
                  //           itemCount: data.thisTransactions.length,
                  //           shrinkWrap: true,
                  //           physics: const NeverScrollableScrollPhysics(),
                  //           itemBuilder: (BuildContext context, int index) {
                  //             TransactionsModel txn =
                  //                 data.thisTransactions[index];
                  //             return TransactionWidget(
                  //               txn: txn,
                  //             );
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
