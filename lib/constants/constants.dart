import 'package:icofont_flutter/icofont_flutter.dart';

final txnType = ['RECEIPT', 'PAYMENT'];
final txnMode = ['Cash', 'Online', 'Cheque', 'Bank Transfer'];
final List<Map<String, dynamic>> currencies = [
  {'code': 'rupee', 'name': 'Rupees', 'icon': IcoFontIcons.rupee},
  {'code': 'baht', 'name': 'Baht', 'icon': IcoFontIcons.baht},
  {'code': 'doller', 'name': 'US Doller', 'icon': IcoFontIcons.dollar},
  {'code': 'euro', 'name': 'Euro', 'icon': IcoFontIcons.euro},
  {'code': 'frank', 'name': 'Frank', 'icon': IcoFontIcons.frank},
  {'code': 'lira', 'name': 'Lira', 'icon': IcoFontIcons.lira},
  {'code': 'peso', 'name': 'Peso', 'icon': IcoFontIcons.peso},
  {'code': 'peso', 'name': 'Peso', 'icon': IcoFontIcons.peso},
  {'code': 'pound', 'name': 'Pound', 'icon': IcoFontIcons.pound},
  {'code': 'taka', 'name': 'Taka', 'icon': IcoFontIcons.taka},
  {'code': 'yen', 'name': 'Yen', 'icon': IcoFontIcons.yen},
  {'code': 'won', 'name': 'Won', 'icon': IcoFontIcons.won},
  {'code': 'riyal', 'name': 'Riyal', 'icon': IcoFontIcons.riyal},
  {'code': 'dong', 'name': 'Dong', 'icon': IcoFontIcons.dong},
];

final dateFormat = ['DD-MM-YYYY', 'MM-DD-YYYY', 'YYYY-MM-DD'];

final yesNo = [
  {'key': true, 'value': 'Yes'},
  {'key': false, 'value': 'No'}
];
