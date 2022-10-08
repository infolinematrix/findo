String formatDate(String dt) {
  if (dt == "null") return "Date Error";

  DateTime parseDt = DateTime.parse(dt);

  String dateSlug =
      "${parseDt.day.toString().padLeft(2, '0')}-${parseDt.month.toString().padLeft(2, '0')}-${parseDt.year.toString()}";

  return dateSlug;
}

String strToDate(String dt) {
  DateTime tempDate = DateTime.now();

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  var suffix = "th";
  var digit = tempDate.day % 10;
  if ((digit > 0 && digit < 4) && (tempDate.day < 11 || tempDate.day > 13)) {
    suffix = ["st", "nd", "rd"][digit - 1];
  }

  String d =
      "${tempDate.day}$suffix ${months[tempDate.month - 1]}, ${tempDate.year}";

  return d;
}

String strToMonth(String dt) {
  DateTime tempDate = DateTime.now();

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  String d = "${months[tempDate.month - 1]}, ${tempDate.year}";

  return d;
}

String strToShortDate(String dt) {
  DateTime tempDate = DateTime.now();

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];
  var suffix = "th";
  var digit = tempDate.day % 10;
  if ((digit > 0 && digit < 4) && (tempDate.day < 11 || tempDate.day > 13)) {
    suffix = ["st", "nd", "rd"][digit - 1];
  }
  String d =
      "${tempDate.day}$suffix-${months[tempDate.month - 1]}-${tempDate.year}";

  return d;
}

String strToShortMonth(String dt) {
  DateTime tempDate = DateTime.now();

  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  String d = months[tempDate.month - 1];

  return d;
}

String strToDay(String dt) {
  DateTime tempDate = DateTime.now();

  String d = "${tempDate.day}";

  return d;
}

String strToYear(String dt) {
  DateTime tempDate = DateTime.now();

  String d = "${tempDate.year}";

  return d;
}

String strToWeekDay(DateTime dt) {
  // DateTime tempDate = DateTime.now();

  List<String> dayOfWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesdday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  String d = dayOfWeek[dt.weekday];

  return d;
}
