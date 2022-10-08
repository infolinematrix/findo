part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const initialRoute = '/onboard';
  static const onboard = '/onboard';
  static const home = '/home';

  //--Ledgers
  static const ledgerCreate = '/ledger_create';
  static const ledgerList = '/ledger_list';

  //--Accounts
  static const accountCreate = '/account_create';
  static const accountList = '/account_list';

  //--Transations
  static const accountTransaction = '/account_transactions';

  static const payment = '/payment';
  static const receive = '/receipt';
  static const transfer = '/transfer';
}
