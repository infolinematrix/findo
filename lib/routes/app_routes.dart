part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const initialRoute = '/onboard';
  static const onboard = '/onboard';
  static const home = '/home';
  static const ledgerCreate = '/ledger_create';
  static const accountCreate = '/account_create';

  //--Transations
  static const payment = '/payment';
  static const receive = '/receive';
  static const transfer = '/transfer';
}
