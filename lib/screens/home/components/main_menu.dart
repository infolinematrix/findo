import 'package:animate_do/animate_do.dart';
import 'package:finsoft2/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class MainMenuWidget extends StatelessWidget {
  const MainMenuWidget({
    Key? key,
  }) : super(key: key);

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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 200),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(context, "/account_select",
                            arguments: "RECEIPT");
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60.sp,
                            height: 60.sp,
                            decoration: BoxDecoration(
                              color: Theme.of(context).hoverColor,
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Center(
                              child: Icon(
                                Iconsax.import_1,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          Text(
                            "Receipt",
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FadeInDown(
                  duration: const Duration(milliseconds: 200),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(context, "/account_select",
                            arguments: "PAYMENT");
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60.sp,
                            height: 60.sp,
                            decoration: BoxDecoration(
                              color: Theme.of(context).hoverColor,
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Center(
                              child: Icon(
                                Iconsax.export_1,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          Text(
                            "Payment",
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FadeInDown(
                  duration: const Duration(milliseconds: 200),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.pushNamed(context, "/transfer");
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 60.sp,
                            height: 60.sp,
                            decoration: BoxDecoration(
                              color: Theme.of(context).hoverColor,
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Center(
                              child: Icon(
                                Iconsax.empty_wallet_change,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          Text(
                            "Transfer",
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                FadeInDown(
                  duration: const Duration(milliseconds: 200),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: GestureDetector(
                      onTap: () async {},
                      child: Column(
                        children: [
                          Container(
                            width: 60.sp,
                            height: 60.sp,
                            decoration: BoxDecoration(
                              color: Theme.of(context).hoverColor,
                              borderRadius: BorderRadius.circular(20.sp),
                            ),
                            child: Center(
                              child: Icon(
                                Iconsax.message_question,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          Text(
                            "Help",
                            style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
