import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> gotoUrl({required String url}) async {
  final Uri uriUrl = Uri.parse(url.toString());

  if (!await launchUrl(uriUrl)) {
    throw 'Could not launch $uriUrl';
  }
}

convertDateToLocal(String strDate) {
  var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(strDate, true);
  var dateLocal = dateTime.toLocal();

  return dateLocal;
}

DateTime dateTodayStart() {
  final now = DateTime.now().toUtc();
  final lastMidnight = now.subtract(Duration(
    hours: now.hour,
    minutes: now.minute,
    seconds: now.second,
    milliseconds: now.millisecond,
    microseconds: now.microsecond,
  ));

  return lastMidnight;
}

// DateTime dateTodayEnd() {
//   final now = DateTime.now().toUtc();
//   final lastMidnight = now.subtract(Duration(
//     hours: now.hour,
//     minutes: now.minute,
//     seconds: now.second,
//     milliseconds: now.millisecond,
//     microseconds: now.microsecond,
//   ));

//   return lastMidnight;
// }

DateTime firstDayOfWeek() {
  DateTime now = DateTime.now();
  int currentDay = now.weekday;
  DateTime firstDayOfWeek = now.subtract(Duration(days: currentDay));
  return firstDayOfWeek;
}

DateTime lastDayOfWeek() {
  DateTime now = DateTime.now();
  DateTime firstDayOfWeek =
      now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
  return firstDayOfWeek;
}

DateTime firstDayOfMonth() {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, 1);
}

DateTime lastDayOfMonth() {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month + 1, 0);
}

DateTime firstDayOfYear() {
  DateTime now = DateTime.now();
  return DateTime(now.year, 1, 1);
}

DateTime lastDayOfYear() {
  DateTime now = DateTime.now();
  return DateTime(now.year, 12, 31);
}
