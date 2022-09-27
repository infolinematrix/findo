import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

NumberFormat currencyFormatDecimal = NumberFormat.currency(
    name: '', customPattern: '##,##,##0.00', decimalDigits: 2);

String formatCurrency(var n) {
  String rType = n.runtimeType.toString();
  String formattedString = "0.00";
  if (rType == 'double') {
    formattedString = n.toStringAsFixed(2);
  } else if (rType == 'integer') {
    double t = double.parse(n.toString()).toDouble();
    formattedString = t.toStringAsFixed(2);
  } else if (rType == 'String') {
    double t = double.parse(n.toString()).toDouble();
    formattedString = t.toStringAsFixed(2);
  }

  return currencyFormatDecimal
      .format(double.parse(formattedString.toString()).toDouble()); // 1.51
}

Future<String> getIp() async {
  String strIp = '';
  List interfaces = await NetworkInterface.list();

  strIp = interfaces[0].addresses[0].address;

  return strIp.toString().trim();
}
