import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/models/ledger_model.dart';
import 'package:finsoft2/screens/account/account_create_screen.dart';
import 'package:finsoft2/screens/account/account_list_screen.dart';
import 'package:finsoft2/screens/home/home_screen.dart';
import 'package:finsoft2/screens/ledger/ledger_create_screen.dart';
import 'package:finsoft2/screens/ledger/ledger_list_screen.dart';
import 'package:finsoft2/screens/transactions/account_transaction_screen.dart';
import 'package:finsoft2/screens/transactions/payment_screen.dart';
import 'package:finsoft2/screens/transactions/receive_screen.dart';
import 'package:finsoft2/screens/transactions/transfer_screen.dart';
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

          case Routes.ledgerList:
            return const LedgerListScreen();

          case Routes.accountCreate:
            return AccountCreateScreen(
                ledger: settings.arguments as LedgerModel);

          case Routes.accountList:
            return AccountListScreen(ledger: settings.arguments as LedgerModel);

          //--Transactions

          case Routes.accountTransaction:
            return AccountTransactionScreen(
                account: settings.arguments as AccountsModel);

          case Routes.payment:
            return PaymentScreen(account: settings.arguments as AccountsModel);

          case Routes.receive:
            return const ReceiveScreen();

          case Routes.transfer:
            return const TransferScreen();

          default:
            return const OnBoardScreen();
        }
      },
    );
  }
}
