import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoBox extends StatelessWidget {
  final Widget text;
  final Color? color;
  const InfoBox({Key? key, required this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: color ?? Colors.white,
      padding: EdgeInsets.all(16.0.sp),
      child: text,
    );
  }
}
