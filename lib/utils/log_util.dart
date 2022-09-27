import 'package:flutter/foundation.dart';

void e(String tag) {
  _printLog(tag);
}

void _printLog(String tag) {
  if (kDebugMode) {
    debugPrint(tag);
  }
}
