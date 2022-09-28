import 'package:finsoft2/screens/home/home_screen.dart';
import 'package:finsoft2/screens/ledger/ledger_create_screen.dart';
import 'package:flutter/cupertino.dart';

import '../screens/onboard/onboard_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initialRoute = 'onboard';
  static const home = 'home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return CupertinoPageRoute(
      settings: settings,
      builder: (_) {
        switch (settings.name) {
          case Routes.onboard:
            return const OnBoardScreen();

          case Routes.home:
            return const HomeScreen();

          case Routes.ledgerCreate:
            return const LedgerCreateScreen();

          default:
            return const OnBoardScreen();
        }
      },
    );
  }
}
