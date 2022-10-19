import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

InputDecoration checkBoxDecoration() {
  return const InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 0),
    filled: false,
    // fillColor: Colors.transparent,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
  );
}

InputDecorationTheme inputTheme(bool isDarkTheme) {
  return InputDecorationTheme(
    // contentPadding: EdgeInsets.all(14.0.sp),
    fillColor: isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade200,
    filled: true,
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

      secondaryHeaderColor:
          isDarkTheme ? Colors.black : const Color.fromARGB(255, 0, 98, 255),
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor:
          isDarkTheme ? const Color(0xff280C0B) : const Color(0xff3A3A3B),
      highlightColor: isDarkTheme
          ? const Color.fromARGB(255, 56, 54, 47)
          : const Color.fromARGB(255, 0, 98, 255),
      hoverColor:
          isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor:
          isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: isDarkTheme ? const Color(0xFF151515) : Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey.shade100,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,

      //------------
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      //----------------
      appBarTheme: AppBarTheme(
          elevation: 1.0,
          color: isDarkTheme
              ? Colors.black
              : const Color.fromARGB(255, 1, 134, 243),
          foregroundColor: isDarkTheme ? Colors.white : Colors.white,
          titleTextStyle: TextStyle(
              fontSize: 16.0.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: .50)),

      //--------------
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),

      //--TextInput
      inputDecorationTheme: inputTheme(isDarkTheme),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            foregroundColor: isDarkTheme ? Colors.white : Colors.black),
      ),
    );
  }
}
