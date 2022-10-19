import 'package:findo/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({Key? key, this.msg}) : super(key: key);
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 70.0.sp,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Image.asset("assets/images/no_data.png"),
              ),
            ),
            UIHelper.verticalSpaceSmall(),
            Text(
              msg ?? "No Data Found",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            UIHelper.verticalSpaceMedium(),
            SizedBox(
              width: 100.0.w,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Back"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
