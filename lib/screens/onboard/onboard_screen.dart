import 'package:finsoft2/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardScreen extends ConsumerWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "WELCOME",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              UIHelper.verticalSpaceMedium(),
              SizedBox(
                width: 150.0.sp,
                height: 2.0.sp,
                child: const LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
