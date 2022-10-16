import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

InputDecorationTheme inputTheme(bool isDarkTheme) {
  return InputDecorationTheme(
    // contentPadding: EdgeInsets.all(14.0.sp),
    fillColor: isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade100,
    filled: true,
    // isDense: false,
    labelStyle: TextStyle(color: isDarkTheme ? Colors.white : Colors.black54),
    floatingLabelStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 13.0.sp,
        color: isDarkTheme ? Colors.white : Colors.black54),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black12, width: .00),
    ),
    errorStyle:
        const TextStyle(color: Colors.transparent, fontSize: 0, height: 0),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: isDarkTheme ? Colors.blue : Colors.red),
    ),
  );
}

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
      canvasColor: isDarkTheme ? Colors.black : Colors.grey.shade50,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 1.0,
        color: isDarkTheme ? Colors.black : Colors.blue,
        foregroundColor: isDarkTheme ? Colors.white : Colors.white,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),
      inputDecorationTheme: inputTheme(isDarkTheme),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: isDarkTheme ? Colors.white : Colors.white)),
    );
  }
}
