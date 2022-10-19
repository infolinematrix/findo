part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const initialRoute = '/onboard';

  static const initialBankAccountCreate = '/initial_bank_create';

  static const onboard = '/onboard';
  static const home = '/home';

  //--Group
  static const groupCreate = '/group_create';
  static const groupList = '/group_list';

  //--Accounts
  static const accountCreate = '/account_create';
  static const accountUpdate = '/account_update';
  static const accountList = '/account_list';
  static const accountStatement = '/account_statement';

  //--Transations
  static const accountSelect = '/account_select';
  static const accountTransaction = '/account_transactions';

  static const payment = '/payment';
  static const receive = '/receipt';
  static const transfer = '/transfer';
}
