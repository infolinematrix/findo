import 'package:finsoft2/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 237, 237, 237),
    // primarySwatch: Colors.blue,
    brightness: Brightness.light,
    highlightColor: Colors.transparent,
    appBarTheme: appBarTheme(),
    tabBarTheme: tabTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: inputTheme(),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    cardColor: Colors.white,
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 24.0.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline2: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline3: TextStyle(
        fontSize: 20.0.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline4: TextStyle(
        fontSize: 18.0.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline5: TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      headline6: TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 12.0.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      subtitle2: TextStyle(
        fontSize: 13.0.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        fontSize: 12.0.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 12.0.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      button: TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 12.0.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      overline: TextStyle(
        fontSize: 10.0.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    ),
  );
}

InputDecorationTheme inputTheme() {
  return InputDecorationTheme(
    contentPadding: EdgeInsets.all(12.0.sp), //
    focusColor: Colors.black,
    fillColor: Colors.grey.shade50,
    filled: true,
    isDense: false,
    labelStyle: const TextStyle(color: Colors.black54),
    floatingLabelStyle:
        TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0.sp),

    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black12,
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 2.0,
      ),
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    elevation: .50,
    color: AppColors.black2,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
    ),
  );
}

TabBarTheme tabTheme() {
  return const TabBarTheme(
    labelColor: Colors.black,

    labelStyle: TextStyle(fontWeight: FontWeight.bold), // color for text
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: AppColors.secondaryColor),
    ),
  );
}

//------------------------TABLET --------------------------//

ThemeData appThemeTablet() {
  return ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 237, 237, 237),
    // primarySwatch: Colors.black,
    brightness: Brightness.light,
    highlightColor: Colors.transparent,
    // appBarTheme: appBarTheme(),
    tabBarTheme: tabTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: inputTheme(),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),

    // textTheme: const TextTheme(
    //   headline1: TextStyle(
    //     // fontSize: 24.0.sp,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.black,
    //   ),
    //   headline2: TextStyle(
    //     // fontSize: 18.sp,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.black,
    //   ),
    //   headline3: TextStyle(
    //     // fontSize: 20.0.sp,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.black,
    //   ),
    //   headline4: TextStyle(
    //     // fontSize: 18.0.sp,
    //     fontWeight: FontWeight.bold,
    //     color: Colors.black,
    //   ),
    //   headline5: TextStyle(
    //     // fontSize: 16.0.sp,
    //     fontWeight: FontWeight.w400,
    //     color: Colors.black,
    //   ),
    //   headline6: TextStyle(
    //     // fontSize: 14.0.sp,
    //     fontWeight: FontWeight.w500,
    //     color: Colors.black,
    //   ),
    //   subtitle1: TextStyle(
    //     // fontSize: 12.0.sp,
    //     fontWeight: FontWeight.w400,
    //     color: Colors.black,
    //   ),
    //   subtitle2: TextStyle(
    //     // fontSize: 13.0.sp,
    //     fontWeight: FontWeight.w500,
    //     color: Colors.black,
    //   ),
    //   bodyText1: TextStyle(
    //     // fontSize: 13.0.sp,
    //     fontWeight: FontWeight.w600,
    //     color: Colors.black,
    //   ),
    //   bodyText2: TextStyle(
    //     // fontSize: 13.0.sp,
    //     fontWeight: FontWeight.w400,
    //     color: Colors.black,
    //   ),
    //   button: TextStyle(
    //     // fontSize: 16.0.sp,
    //     fontWeight: FontWeight.w500,
    //     color: Colors.black,
    //   ),

    //   labelMedium: TextStyle(
    //     // fontSize: 12.0.sp,
    //     fontWeight: FontWeight.normal,
    //     color: Colors.black,
    //   ),
    //   overline: TextStyle(
    //     // fontSize: 10.0.sp,
    //     fontWeight: FontWeight.normal,
    //     color: Colors.black,
    //   ),
    // ),
  );
}
