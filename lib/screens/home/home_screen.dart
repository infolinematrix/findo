import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:finsoft2/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:workmanager/workmanager.dart';

import '../../services/settings_service.dart';
import '../../theme/styles.dart';
import '../../utils/functions.dart';
import '../../widgets/index.dart';
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
    ['Receipt', Iconsax.import_1, Colors.blue],
    ['Statement', Iconsax.wallet_3, Colors.orange],
    ['Help', Iconsax.receive_square1, Colors.pink],
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
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    "Rajdhani Garments",
                    style: TextStyle(
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
        body: CustomScrollView(
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
                  icon: const Icon(Iconsax.notification, color: Colors.white),
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
                      'Rajdhani Garments',
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
                    child: Consumer(builder: (context, ref, child) {
                      final todayData = ref.watch(homeDataProvider);

                      return todayData.when(
                        error: (error, stackTrace) => const SizedBox.shrink(),
                        loading: () => const LinearProgressIndicator(),
                        data: (today) {
                          final data = today[0]['today'];

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              UIHelper.verticalSpaceSmall(),
                              Text(
                                data['title'].toString(),
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
                                          Text(
                                            data['income'].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(color: Colors.white),
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
                                          Text(
                                            data['expenditure'].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4!
                                                .copyWith(color: Colors.white),
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
                          );
                        },
                      );
                    })),
              ),
            ),
            SliverList(
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
                                  Navigator.pushNamed(context, '/accounts');
                                } else {
                                  String rndStr = generateRandomString(6);
                                  await Workmanager().registerOneOffTask(
                                    rndStr,
                                    'fetchBackground',
                                    // frequency:
                                    //     const Duration(microseconds: 900001),
                                    initialDelay: const Duration(minutes: 1),
                                    // constraints: Constraints(
                                    //   networkType: NetworkType.connected,
                                    // ),
                                    inputData: <String, dynamic>{
                                      'int': 1,
                                      'bool': true,
                                      'double': 1.0,
                                      'string': rndStr,
                                      'array': [1, 2, 3],
                                    },
                                  );
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: 60.sp,
                                    height: 60.sp,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(20.sp),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        _services[index][1],
                                        color: Colors.white,
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
            ),
            SliverToBoxAdapter(
              child: Consumer(
                builder: (context, ref, child) {
                  final homeData = ref.watch(homeDataProvider);
                  return homeData.when(
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    loading: () => const LinearProgressIndicator(),
                    data: (overall) {
                      final data = overall[1]['overall'];

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0.sp),
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return SlideInRight(
                              duration:
                                  Duration(milliseconds: (index + 1) * 100),
                              child: InkWell(
                                onTap: () {
                                  if (data[index]['key'] == 'THIS_WEEK') {
                                    Map<String, dynamic> para = {
                                      'title': 'This Week',
                                      'startDate': firstDayOfWeek(),
                                      'endDate': lastDayOfWeek()
                                    };
                                    Navigator.pushNamed(
                                        context, "/transactions",
                                        arguments: para);
                                  } else if (data[index]['key'] ==
                                      'THIS_MONTH') {
                                    Map<String, dynamic> para = {
                                      'title': 'This Month',
                                      'startDate': firstDayOfMonth(),
                                      'endDate': lastDayOfMonth()
                                    };
                                    Navigator.pushNamed(
                                        context, "/transactions",
                                        arguments: para);
                                  } else if (data[index]['key'] ==
                                      'THIS_YEAR') {
                                    Map<String, dynamic> para = {
                                      'title': 'This Year',
                                      'startDate': firstDayOfYear(),
                                      'endDate': lastDayOfYear()
                                    };
                                    Navigator.pushNamed(
                                        context, "/transactions",
                                        arguments: para);
                                  }
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
                                                    data[index]['title'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .blueAccent),
                                                  ),
                                                  UIHelper
                                                      .horizontalSpaceSmall(),
                                                  const Icon(
                                                      IcoFontIcons.thinRight)
                                                ],
                                              ),
                                              Text(
                                                "View All",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1!
                                                    .copyWith(
                                                        color: Colors.black),
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
                                                                    .grey
                                                                    .shade500),
                                                      ),
                                                      UIHelper
                                                          .verticalSpaceExtraSmall(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            formatCurrency(
                                                                data[index]
                                                                    ['income']),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5!
                                                                .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          UIHelper
                                                              .horizontalSpaceSmall(),
                                                          const Icon(
                                                            IcoFontIcons
                                                                .bubbleDown,
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
                                                                    .grey
                                                                    .shade500),
                                                      ),
                                                      UIHelper
                                                          .verticalSpaceExtraSmall(),
                                                      Text(
                                                        formatCurrency(data[
                                                                index]
                                                            ['expenditure']),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
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
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0.sp),
                    height: 500.sp,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return SlideInRight(
                          duration: Duration(milliseconds: (index + 1) * 100),
                          child: InkWell(
                            onTap: () {},
                            child: SizedBox(
                              height: 100.h,
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.sp, vertical: 8.sp),
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
                                                "ORDERS",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Colors.blueAccent),
                                              ),
                                              UIHelper.horizontalSpaceSmall(),
                                              const Icon(IcoFontIcons.thinRight)
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0.w,
                                                vertical: 8.0.w),
                                            child: Text(
                                              "View All",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
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
                                                    "Today",
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
                                                      Text(
                                                        "12,650",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5!
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
                                                    "Overall",
                                                    style: const TextStyle()
                                                        .copyWith(
                                                            color: Colors
                                                                .grey.shade500),
                                                  ),
                                                  UIHelper
                                                      .verticalSpaceExtraSmall(),
                                                  Text(
                                                    "12,45,645",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
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
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            SliverFillRemaining(
              child: Container(
                padding: EdgeInsets.only(left: 16.sp, right: 16.sp, top: 30.sp),
                child: Column(
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('1,840.00',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                          ]),
                    ),
                    UIHelper.verticalSpaceMedium(),
                    // SizedBox(
                    //   height: 110.h,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.stretch,
                    //     children: [
                    //       Expanded(
                    //         child: ListView.builder(
                    //           itemCount: 2,
                    //           scrollDirection: Axis.horizontal,
                    //           shrinkWrap: true,
                    //           reverse: true,
                    //           itemBuilder: (BuildContext context, int index) {
                    //             return SlideInRight(
                    //               duration:
                    //                   Duration(milliseconds: (index + 1) * 100),
                    //               child: InkWell(
                    //                 onTap: () => null,
                    //                 child: SizedBox(
                    //                   width: ScreenUtil().screenWidth * .85,
                    //                   child: Card(
                    //                     child: Padding(
                    //                       padding: EdgeInsets.all(16.0.sp),
                    //                       child: Column(
                    //                         children: [
                    //                           Container(
                    //                             padding: EdgeInsets.symmetric(
                    //                                 horizontal: 8.0.w,
                    //                                 vertical: 2.0.w),
                    //                             decoration: BoxDecoration(
                    //                               color: AppColors
                    //                                   .primaryColorAccent,
                    //                               border: Border.all(
                    //                                 color: Colors.grey.shade200,
                    //                               ),
                    //                               borderRadius:
                    //                                   const BorderRadius.all(
                    //                                 Radius.circular(20),
                    //                               ),
                    //                             ),
                    //                             child: Text(
                    //                               "ORDERS",
                    //                               style: Theme.of(context)
                    //                                   .textTheme
                    //                                   .headline6!
                    //                                   .copyWith(
                    //                                       fontWeight:
                    //                                           FontWeight.bold,
                    //                                       color: Colors.black),
                    //                             ),
                    //                           ),
                    //                           UIHelper.verticalSpaceMedium(),
                    //                           IntrinsicHeight(
                    //                             child: Row(
                    //                               mainAxisSize:
                    //                                   MainAxisSize.min,
                    //                               mainAxisAlignment:
                    //                                   MainAxisAlignment.start,
                    //                               children: [
                    //                                 Flexible(
                    //                                   fit: FlexFit.tight,
                    //                                   child: Wrap(
                    //                                     direction:
                    //                                         Axis.vertical,
                    //                                     children: [
                    //                                       Text(
                    //                                         "Today",
                    //                                         style: const TextStyle()
                    //                                             .copyWith(
                    //                                                 color: Colors
                    //                                                     .grey
                    //                                                     .shade500),
                    //                                       ),
                    //                                       UIHelper
                    //                                           .verticalSpaceExtraSmall(),
                    //                                       Text(
                    //                                         "12,650",
                    //                                         style: Theme.of(
                    //                                                 context)
                    //                                             .textTheme
                    //                                             .headline3,
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                 ),
                    //                                 Flexible(
                    //                                   fit: FlexFit.tight,
                    //                                   child: VerticalDivider(
                    //                                     thickness: 0.8,
                    //                                     color: Colors
                    //                                         .grey.shade300,
                    //                                   ),
                    //                                 ),
                    //                                 Flexible(
                    //                                   fit: FlexFit.tight,
                    //                                   child: Wrap(
                    //                                     direction:
                    //                                         Axis.vertical,
                    //                                     children: [
                    //                                       Text(
                    //                                         "Overall",
                    //                                         style: const TextStyle()
                    //                                             .copyWith(
                    //                                                 color: Colors
                    //                                                     .grey
                    //                                                     .shade500),
                    //                                       ),
                    //                                       UIHelper
                    //                                           .verticalSpaceExtraSmall(),
                    //                                       Text(
                    //                                         "12,45,645",
                    //                                         style: Theme.of(
                    //                                                 context)
                    //                                             .textTheme
                    //                                             .headline3,
                    //                                       ),
                    //                                     ],
                    //                                   ),
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // Expanded(
                    //   child: ListView.builder(
                    //     padding: const EdgeInsets.only(top: 20),
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     itemCount: 5,
                    //     itemBuilder: (context, index) {
                    //       return FadeInDown(
                    //         // duration: const Duration(milliseconds: 500),
                    //         duration: Duration(milliseconds: (index + 1) * 100),
                    //         child: const TransactionItem(
                    //             amount: 123.23, txnData: ''),
                    //       );
                    //     },
                    //   ),
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
