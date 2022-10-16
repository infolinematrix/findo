import 'package:finsoft2/screens/error_screen.dart';
import 'package:finsoft2/screens/home/home_screen.dart';
import 'package:finsoft2/screens/onboard/onboard_screen.dart';
import 'package:finsoft2/screens/settings/settings_screen.dart';
import 'package:finsoft2/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'routes/app_pages.dart';
import 'theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingExist = ref.watch(hasSettings);
    final appThemeState = ref.watch(appThemeStateNotifier);
    return ScreenUtilInit(
        designSize: const Size(375, 812 - 44 - 34),
        minTextAdapt: false,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: const [
              FormBuilderLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,

            theme:
                AppStyles.themeData(appThemeState.isDarkModeEnabled, context),

            onGenerateRoute: AppPages.onGenerateRoute,
            builder: EasyLoading.init(),
            home: settingExist.when(
              loading: () => const OnBoardScreen(),
              error: (err, stack) => ErrorScreen(msg: err.toString()),
              data: (data) {
                if (data == true) {
                  return const HomeScreen();
                  // return const OnBoardScreen();
                }
                return const SettingsScreen();
              },
            ),
            // home: const HomeScreen(),
          );
        });
  }
}
