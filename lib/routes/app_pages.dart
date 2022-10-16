import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/account/account_create_screen.dart';
import 'package:finsoft2/screens/account/account_list_screen.dart';
import 'package:finsoft2/screens/account/account_statement.dart';
import 'package:finsoft2/screens/home/home_screen.dart';
<<<<<<< HEAD
=======
import 'package:finsoft2/screens/settings/bank_account_create_screen.dart';
>>>>>>> 3e88900f7094f933b75ddadb8baf31f97d3dcf08
import 'package:finsoft2/screens/transactions/account_select_screen.dart';
// import 'package:finsoft2/screens/ledger/ledger_create_screen.dart';
// import 'package:finsoft2/screens/ledger/ledger_list_screen.dart';

import 'package:finsoft2/screens/transactions/account_transactions_screen.dart';
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

<<<<<<< HEAD
          // case Routes.ledgerCreate:
          //   return const LedgerCreateScreen();

=======
          case Routes.initialBankAccountCreate:
            return const BankAccountCreateScreen();

          // case Routes.ledgerCreate:
          //   return const LedgerCreateScreen();

>>>>>>> 3e88900f7094f933b75ddadb8baf31f97d3dcf08
          // case Routes.ledgerList:
          //   return const LedgerListScreen();

          case Routes.accountCreate:
            return AccountCreateScreen(
                account: settings.arguments as Map<String, dynamic>);

          case Routes.accountList:
            return AccountListScreen(
                account: settings.arguments as Map<String, dynamic>);

          case Routes.accountStatement:
            return AccountStatementScreen(
                account: settings.arguments as Map<String, dynamic>);

          //--Transactions
          case Routes.accountSelect:
            return AccountSelectScreen(txnType: settings.arguments as String);

          case Routes.accountTransaction:
            return AccountTransactionScreen(
                param: settings.arguments as Map<String, dynamic>);

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
