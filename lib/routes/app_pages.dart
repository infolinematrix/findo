import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/screens/account/account_create_screen.dart';
import 'package:findo/screens/account/account_list_screen.dart';
import 'package:findo/screens/account/account_statement.dart';
import 'package:findo/screens/account/account_update_screen.dart';
import 'package:findo/screens/account/groups_create_screen.dart';
import 'package:findo/screens/account/groups_screen.dart';
import 'package:findo/screens/home/home_screen.dart';
import 'package:findo/screens/settings/bank_account_create_screen.dart';
import 'package:findo/screens/transactions/account_select_screen.dart';
// import 'package:findo/screens/ledger/ledger_create_screen.dart';
// import 'package:findo/screens/ledger/ledger_list_screen.dart';

import 'package:findo/screens/transactions/account_transactions_screen.dart';
import 'package:findo/screens/transactions/payment_screen.dart';
import 'package:findo/screens/transactions/receive_screen.dart';
import 'package:findo/screens/transactions/transfer_screen.dart';
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

          case Routes.initialBankAccountCreate:
            return const BankAccountCreateScreen();

          case Routes.groupCreate:
            return const AccountGroupCreateScreen();

          case Routes.groupList:
            return const AccountGroupsScreen();

          //--ACCOUNT

          case Routes.accountCreate:
            return AccountCreateScreen(
                parent: settings.arguments as AccountsModel);

          case Routes.accountUpdate:
            return AccountUpdateScreen(
                account: settings.arguments as AccountsModel);

          case Routes.accountList:
            return AccountListScreen(
                parent: settings.arguments as AccountsModel);

          case Routes.accountStatement:
            return AccountStatementScreen(
                account: settings.arguments as Map<String, dynamic>);

          //--Transactions
          case Routes.accountSelect:
            return AccountSelectScreen(txnType: settings.arguments as String);

          case Routes.accountTransaction:
            return AccountTransactionScreen(
                account: settings.arguments as AccountsModel);

          case Routes.payment:
            return PaymentScreen(account: settings.arguments as AccountsModel);

          case Routes.receive:
            return ReceiptScreen(account: settings.arguments as AccountsModel);

          case Routes.transfer:
            return const TransferScreen();

          default:
            return const OnBoardScreen();
        }
      },
    );
  }
}
