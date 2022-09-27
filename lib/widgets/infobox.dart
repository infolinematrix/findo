import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/styles.dart';

class InfoBox extends StatelessWidget {
  final Widget text;
  final Color? color;
  const InfoBox({Key? key, required this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? AppColors.lightGrey,
      padding: EdgeInsets.all(16.0.sp),
      child: text,
    );
  }
}
