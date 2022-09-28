import 'dart:io';

import 'package:animate_do/animate_do.dart';
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
                Row(
                  children: [
                    Container(
                      width: 40.0.sp,
                      height: 40.0.sp,
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
                        size: 25,
                      ),
                    ),
                    UIHelper.horizontalSpaceMedium(),
                    const Text(
                      "Rajdhani Garments",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceSmall(),
                Divider(
                  color: Colors.grey.shade800,
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, "/ledger_create");
                  },
                  leading: const Icon(Iconsax.home),
                  title: const Text('General Ledger'),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Iconsax.chart_2),
                  title: const Text('Accounts'),
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
      ),
    );
  }

  void handleMenuButtonPressed() {
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
                      onTap: () {},
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
    );
  }
}
