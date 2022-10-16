import 'package:icofont_flutter/icofont_flutter.dart';

final txnType = ['RECEIPT', 'PAYMENT'];
final txnMode = ['Cash', 'Online', 'Cheque', 'Bank Transfer'];

final List<Map<String, dynamic>> currencies = [
  {'code': 'rupee', 'name': 'Rupees', 'icon': IcoFontIcons.rupee},
  {'code': 'baht', 'name': 'Baht', 'icon': IcoFontIcons.baht},
];

final dateFormat = ['dd-MM-yyyy', 'MM-dd-yyyy', 'yyyy-MM-dd'];

final yesNo = [
  {'key': true, 'value': 'Yes'},
  {'key': false, 'value': 'No'}
];

final List<Map<String, dynamic>> ledgerType = [
  {'code': 'INCOME', 'name': 'Income'},
  {'code': 'EXPENDITURE', 'name': 'Expenditure'},
  {'code': 'BANK', 'name': 'Bank Account'},
  {'code': 'DEBTORS', 'name': 'Sundry Debtors'},
  {'code': 'CREDITORS', 'name': 'Sundry Creditors'},
];

final List<Map<String, dynamic>> transferMode = [
  {'code': 1, 'name': 'Cash Deposit to Bank'},
  {'code': 2, 'name': 'Cash Withdrawl from Bank'},
];

//--11/10/2022
final List<Map<String, dynamic>> accountType = [
  {'code': 'REVENUE', 'name': 'Revinue'},
  {'code': 'EXPENSES', 'name': 'Expenses'},
  {'code': 'ASSETS', 'name': 'Assets'},
  {'code': 'BANK', 'name': 'Bank'},
  {'code': 'LIABILITIES', 'name': 'Liabilities'},
  {'code': 'EQUITY', 'name': 'Equity'},
];
