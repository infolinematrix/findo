import 'package:finsoft2/utils/index.dart';
import 'package:finsoft2/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataScreen extends StatelessWidget {
  const NoDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 100.0.sp,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Image.asset("assets/images/no_data.png"),
              ),
            ),
            UIHelper.verticalSpaceSmall(),
            Text(
              "No Data Found",
              style: Theme.of(context).textTheme.headline6,
            ),
            UIHelper.verticalSpaceMedium(),
            SizedBox(
              width: 100.0.w,
              height: 34.sp,
              child: FormButton(
                  text: const Text("Back"),
                  onTap: () => Navigator.pop(context)),
            )
          ],
        ),
      ),
    );
  }
}
