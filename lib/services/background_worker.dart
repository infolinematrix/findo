import 'package:workmanager/workmanager.dart';

class BackgroundWorker {
  static const simpleTaskKey = "simpleTask";
  static const rescheduledTaskKey = "rescheduledTask";
  static const failedTaskKey = "failedTask";
  static const simpleDelayedTask = "simpleDelayedTask";
  static const simplePeriodicTask = "simplePeriodicTask";
  static const simplePeriodic1HourTask = "simplePeriodic1HourTask";

  Future initialize() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
  }

  static callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      switch (task) {
        case simpleTaskKey:
          print("$simpleTaskKey was executed. inputData = $inputData");
          break;
        case rescheduledTaskKey:
          final key = inputData!['key']!;
          print('has been running before, task is successful unique-$key');
          break;

        case Workmanager.iOSBackgroundTask:
          print("The iOS background fetch was triggered");

          break;
      }

      return Future.value(true);
    });
  }
}
