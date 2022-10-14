import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ThemeData appTheme() {
//   return ThemeData(
//     scaffoldBackgroundColor: const Color.fromARGB(255, 237, 237, 237),
//     // primarySwatch: Colors.yellow,
//     unselectedWidgetColor: Colors.black,
//     brightness: Brightness.light,
//     // highlightColor: Colors.transparent,

//     // appBarTheme: appBarTheme(),
//     // tabBarTheme: tabTheme(),
//     visualDensity: VisualDensity.adaptivePlatformDensity,
//     // inputDecorationTheme: inputTheme(),
//     checkboxTheme: CheckboxThemeData(
//       checkColor: MaterialStateProperty.all(Colors.white),
//       fillColor: MaterialStateProperty.all(AppColors.black2),
//       side: const BorderSide(
//         color: Colors.black, //your desire colour here
//         width: 0,
//       ),
//     ),
//     cardColor: Colors.white,
//     textTheme: TextTheme(
//       button: TextStyle(
//         fontSize: 14.0.sp,
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     ),
//   );
// }

InputDecoration checkboxDecoration = const InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
  fillColor: Colors.transparent,
  filled: true,
  isDense: true,
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 0),
  ),
);

InputDecorationTheme inputTheme(bool isDarkTheme) {
  return InputDecorationTheme(
    contentPadding: EdgeInsets.all(12.0.sp), //
    fillColor: isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
    filled: true,
    isDense: false,
    labelStyle: TextStyle(color: isDarkTheme ? Colors.white : Colors.black54),
    floatingLabelStyle:
        TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0.sp),

    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12, width: .50),
    ),
  );
}

// AppBarTheme appBarTheme() {
//   return AppBarTheme(
//     elevation: .50,
//     color: AppColors.black2,
//     iconTheme: const IconThemeData(color: Colors.white),
//     titleTextStyle: TextStyle(
//       color: Colors.white,
//       fontSize: 16.sp,
//       fontWeight: FontWeight.w500,
//     ),
//   );
// }

// TabBarTheme tabTheme() {
//   return const TabBarTheme(
//     labelColor: Colors.black,

//     labelStyle: TextStyle(fontWeight: FontWeight.bold), // color for text
//     indicator: UnderlineTabIndicator(
//       borderSide: BorderSide(color: AppColors.secondaryColor),
//     ),
//   );
// }

//========NEW IMPLIMATION================//

// Theme
final appThemeStateNotifier = ChangeNotifierProvider((ref) => AppThemeState());

class AppThemeState extends ChangeNotifier {
  var isDarkModeEnabled = false;
  void setLightTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeEnabled = false;
    prefs.setBool('IS_DARK', isDarkModeEnabled);

    notifyListeners();
  }

  void setDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeEnabled = true;
    prefs.setBool('IS_DARK', isDarkModeEnabled);
    notifyListeners();
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('IS_DARK') ?? false;
  }
}

class AppStyles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: isDarkTheme ? Colors.blueGrey : Colors.blue,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor:
          isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      highlightColor:
          isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor:
          isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor:
          isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 1.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),
      inputDecorationTheme: inputTheme(isDarkTheme),
    );
  }
}
