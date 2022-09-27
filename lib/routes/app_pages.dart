import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/accounts/accounts_screen.dart';
import 'package:finsoft2/screens/home/home_screen.dart';
import 'package:finsoft2/screens/transactions/account_transactions_screen.dart';
import 'package:finsoft2/screens/transactions/payment_screen.dart';
import 'package:finsoft2/screens/transactions/transactions_screen.dart';
import 'package:flutter/cupertino.dart';
import '../screens/accounts/account_create_screen.dart';
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

          case Routes.accounts:
            return const AccountsScreen();

          case Routes.accountCreate:
            return const AccountCreateScreen();

          case Routes.accountTransactions:
            return AccountTransactions(
              account: settings.arguments as AccountsModel,
            );

          case Routes.paymentAction:
            return PaymentScreen(
              account: settings.arguments as AccountsModel,
            );

          case Routes.transactions:
            return TransactionsScreen(
              parameters: settings.arguments as Map<String, dynamic>,
            );

          default:
            return const OnBoardScreen();
        }
      },
    );
  }
}
