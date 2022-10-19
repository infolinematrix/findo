import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormButtonRounded extends StatelessWidget {
  final Widget text;
  final Color? color;
  final Function onTap;
  const FormButtonRounded(
      {Key? key, required this.text, this.color, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ElevatedButton(
        onPressed: () => onTap(),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(1.0),
          textStyle: MaterialStateProperty.resolveWith((states) {
            return TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            );
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
                side: const BorderSide(color: Colors.transparent)),
          ),
        ),
        child: text,
      ),
    );
  }
}
