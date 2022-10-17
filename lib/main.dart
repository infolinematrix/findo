import 'dart:async';
import 'dart:io';

import 'package:finsoft2/data/source/objectstore.dart';
import 'package:finsoft2/screens/error_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objectbox/objectbox.dart';
import 'package:workmanager/workmanager.dart';

import 'app.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "fetchBackground":
        // Code to run in background
        // print(inputData);
        break;
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  await initialDependencies();

  runZonedGuarded(() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      if (kReleaseMode) exit(1);
    };

    runApp(
      const ProviderScope(
        child: App(),
      ),
    );
    // Transparent status bar
    // if (Platform.isAndroid) {
    //   SystemUiOverlayStyle systemUiOverlayStyle =
    //       const SystemUiOverlayStyle(statusBarColor: Colors.blue);
    //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    //   // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // }
  }, (Object error, StackTrace stack) {
    ErrorScreen(msg: error.toString());
  });
}

Future<void> initialDependencies() async {
  //--OBJECTBOX

  objBox = await ObjectStore.create();

  if (kDebugMode) {
    if (Admin.isAvailable()) {
      // Keep a reference until no longer needed or manually closed.
      admin = Admin(objBox!.store);
    }
  }

  //--ENV
  await dotenv.load(fileName: ".env");
}
