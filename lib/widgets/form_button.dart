import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormButton extends StatelessWidget {
  final Widget text;
  final Color? color;
  final Function onTap;
  const FormButton(
      {Key? key, required this.text, this.color, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: ElevatedButton(
        onPressed: () => onTap(),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0.0),
          textStyle: MaterialStateProperty.resolveWith((states) {
            return TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            );
          }),
        ),
        child: text,
      ),
    );
  }
}
