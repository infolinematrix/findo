import 'package:icofont_flutter/icofont_flutter.dart';

final txnType = ['RECEIPT', 'PAYMENT'];
final txnMode = ['Cash', 'Online', 'Cheque', 'Bank Transfer'];
final List<Map<String, dynamic>> currencies = [
  {'code': 'rupee', 'name': 'Rupees', 'icon': IcoFontIcons.rupee},
  {'code': 'baht', 'name': 'Baht', 'icon': IcoFontIcons.baht},
];

final dateFormat = ['DD-MM-YYYY', 'MM-DD-YYYY', 'YYYY-MM-DD'];

final yesNo = [
  {'key': true, 'value': 'Yes'},
  {'key': false, 'value': 'No'}
];
