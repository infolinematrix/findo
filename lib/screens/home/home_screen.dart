import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:finsoft2/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../services/settings_service.dart';
import '../../theme/styles.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';
import '../error_screen.dart';
import '../loading.dart';
import 'home_controller.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomeScreen> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  final List<dynamic> _services = [
    ['Payment', Iconsax.export_1, Colors.green],
    ['Receipt', Iconsax.import_1, Colors.white],
    ['Transfer', Iconsax.wallet_3, Colors.orange],
    ['Help', Iconsax.receive_square1, Colors.yellow],
  ];

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
            textColor: Colors.white,
            iconColor: Colors.white,
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
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
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
        backgroundColor: Colors.grey.shade100,
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
                    backgroundColor: AppColors.primaryColor,
                    leading: IconButton(
                      color: Colors.black,
                      onPressed: _handleMenuButtonPressed,
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: _advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              value.visible ? IcoFontIcons.close : Iconsax.menu,
                              color: Colors.white,
                              key: ValueKey<bool>(value.visible),
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Iconsax.notification,
                            color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Iconsax.more, color: Colors.white),
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
                              color: Colors.white,
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
                              color: Colors.white,
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
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            UIHelper.verticalSpaceSmall(),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 1, 139, 252),
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
                                              color: Colors.white54,
                                              fontSize: 10.sp),
                                        ),
                                        UIHelper.verticalSpaceExtraSmall(),
                                        Row(
                                          children: [
                                            Icon(
                                              currencySymbol(),
                                              size: 14.0.sp,
                                              color: Colors.white30,
                                            ),
                                            Text(
                                              data.thisDay['income'].toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: Colors.white,
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
                                      color: Colors.white,
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
                                              color: Colors.white54,
                                              fontSize: 10.sp),
                                        ),
                                        UIHelper.verticalSpaceExtraSmall(),
                                        Row(
                                          children: [
                                            Icon(
                                              currencySymbol(),
                                              size: 14.0.sp,
                                              color: Colors.white30,
                                            ),
                                            Text(
                                              data.thisDay['expenditure']
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: Colors.white,
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
                                color: Colors.white24,
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
                  MainMenuWidget(services: _services),
                  //----------------
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 8.0.sp, vertical: 8.0.sp),
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
                              Navigator.pushNamed(context, "/transactions",
                                  arguments: para);
                            },
                            child: SizedBox(
                              height: 90.h,
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.sp, vertical: 8.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data.thisWeek['title'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.blueAccent),
                                              ),
                                              UIHelper.horizontalSpaceSmall(),
                                              const Icon(
                                                  IcoFontIcons.thinRight),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              fit: FlexFit.tight,
                                              child: Wrap(
                                                direction: Axis.vertical,
                                                children: [
                                                  Text(
                                                    "Income",
                                                    style: const TextStyle()
                                                        .copyWith(
                                                            color: Colors
                                                                .grey.shade500),
                                                  ),
                                                  UIHelper
                                                      .verticalSpaceExtraSmall(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Icon(
                                                        currencySymbol(),
                                                        size: 18.0.sp,
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                      Text(
                                                        formatCurrency(data
                                                            .thisDay['income']),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                      UIHelper
                                                          .horizontalSpaceSmall(),
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
                                                    style: const TextStyle()
                                                        .copyWith(
                                                            color: Colors
                                                                .grey.shade500),
                                                  ),
                                                  UIHelper
                                                      .verticalSpaceExtraSmall(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        currencySymbol(),
                                                        size: 18.0.sp,
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                      Text(
                                                        formatCurrency(
                                                            data.thisDay[
                                                                'expenditure']),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                              Navigator.pushNamed(context, "/transactions",
                                  arguments: para);
                            },
                            child: SizedBox(
                              height: 90.h,
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.sp, vertical: 8.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data.thisMonth['title'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.blueAccent),
                                              ),
                                              UIHelper.horizontalSpaceSmall(),
                                              const Icon(
                                                  IcoFontIcons.thinRight),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              fit: FlexFit.tight,
                                              child: Wrap(
                                                direction: Axis.vertical,
                                                children: [
                                                  Text(
                                                    "Income",
                                                    style: const TextStyle()
                                                        .copyWith(
                                                            color: Colors
                                                                .grey.shade500),
                                                  ),
                                                  UIHelper
                                                      .verticalSpaceExtraSmall(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Icon(
                                                        currencySymbol(),
                                                        size: 18.0.sp,
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                      Text(
                                                        formatCurrency(
                                                            data.thisMonth[
                                                                'income']),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                      UIHelper
                                                          .horizontalSpaceSmall(),
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
                                                    style: const TextStyle()
                                                        .copyWith(
                                                            color: Colors
                                                                .grey.shade500),
                                                  ),
                                                  UIHelper
                                                      .verticalSpaceExtraSmall(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        currencySymbol(),
                                                        size: 18.0.sp,
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                      Text(
                                                        formatCurrency(
                                                            data.thisMonth[
                                                                'expenditure']),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                              Navigator.pushNamed(context, "/transactions",
                                  arguments: para);
                            },
                            child: SizedBox(
                              height: 90.h,
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.sp, vertical: 8.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data.thisYear['title'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.blueAccent),
                                              ),
                                              UIHelper.horizontalSpaceSmall(),
                                              const Icon(
                                                  IcoFontIcons.thinRight),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              fit: FlexFit.tight,
                                              child: Wrap(
                                                direction: Axis.vertical,
                                                children: [
                                                  Text(
                                                    "Income",
                                                    style: const TextStyle()
                                                        .copyWith(
                                                            color: Colors
                                                                .grey.shade500),
                                                  ),
                                                  UIHelper
                                                      .verticalSpaceExtraSmall(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Icon(
                                                        currencySymbol(),
                                                        size: 18.0.sp,
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                      Text(
                                                        formatCurrency(
                                                            data.thisYear[
                                                                'income']),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                      UIHelper
                                                          .horizontalSpaceSmall(),
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
                                                    style: const TextStyle()
                                                        .copyWith(
                                                            color: Colors
                                                                .grey.shade500),
                                                  ),
                                                  UIHelper
                                                      .verticalSpaceExtraSmall(),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        currencySymbol(),
                                                        size: 18.0.sp,
                                                        color: Colors
                                                            .grey.shade500,
                                                      ),
                                                      Text(
                                                        formatCurrency(
                                                            data.thisYear[
                                                                'expenditure']),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                  ),

                  //---------------
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: () => Navigator.pushNamed(
                                context, "/account_list",
                                arguments: {'parent': 0, 'name': "Root"}),
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
                          child: const Text("Receit"),
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

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({
    Key? key,
    required List services,
  })  : _services = services,
        super(key: key);

  final List _services;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          UIHelper.verticalSpaceMedium(),
          Container(
            padding: EdgeInsets.only(top: 20.sp),
            height: 115.sp,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _services.length,
              itemBuilder: (context, index) {
                return FadeInDown(
                  duration: Duration(milliseconds: (index + 1) * 100),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () async {
                        if (_services[index][0] == 'Payment') {
                          Navigator.pushNamed(context, '/payment');
                        }
                        if (_services[index][1] == 'Receipt') {
                          Navigator.pushNamed(context, '/receipt');
                        }
                        if (_services[index][2] == 'Transfer') {
                          Navigator.pushNamed(context, '/transfer');
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60.sp,
                            height: 60.sp,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Center(
                              child: Icon(
                                _services[index][1],
                                color: _services[index][2],
                                size: 25,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          Text(
                            _services[index][0],
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
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
    );
  }
}
