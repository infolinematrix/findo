import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/index.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          height: 60.0.sp,
          width: 150.0.sp,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: SizedBox(
                height: 50.0.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Loading.."),
                    UIHelper.verticalSpaceSmall(),
                    const LinearProgressIndicator(
                        // color: AppColors.primaryColor,
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
