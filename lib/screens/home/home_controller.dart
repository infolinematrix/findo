import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/services/transaction_service.dart';
import 'package:finsoft2/utils/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final initHomeProvider = FutureProvider.autoDispose<InitAppModel>((ref) async {
//   final settings = ref.watch(getSettingsProvider);

//   return InitAppModel(
//     settings: settings,
//   );
// });

// class InitAppModel {
//   final Box<SettingsModel> settings;

//   InitAppModel({
//     required this.settings,
//   });
// }

// final homeProvider = FutureProvider((ref) async {
//   try {
//     QueryBuilder<TransactionsModel> builder =
//         objBox!.store.box<TransactionsModel>().query(
//               TransactionsModel_.txnDate.between(
//                   firstDayOfWeek().millisecondsSinceEpoch,
//                   lastDayOfWeek().millisecondsSinceEpoch),
//             );

//     Query<TransactionsModel> query = builder.build()
//       ..limit = 25
//       ..offset = 0;

//     List<TransactionsModel> data = query.find().toList();

//     return;
//   } catch (e) {
//     return;
//   }
// });

//------------------------------------------------------------------------

class InitDataModel {
  final Map<String, dynamic> thisDay;
  final Map<String, dynamic> thisWeek;
  final Map<String, dynamic> thisMonth;
  final Map<String, dynamic> thisYear;
  final List<TransactionsModel> thisTransactions;

  InitDataModel(
      {required this.thisDay,
      required this.thisWeek,
      required this.thisMonth,
      required this.thisYear,
      required this.thisTransactions});
}

final thisDayTransactionsProvider = Provider((ref) {
  List<TransactionsModel> transactions =
      TransactionService.instance.getAllToday();

  return transactions;
});

final thisWeekDataProvider = Provider((ref) {
  final txnData = TransactionService.instance.getAllWithDateRange(
      startDate: firstDayOfWeek(), endtDate: lastDayOfWeek());
  double income = 0.00;
  double expenditure = 0.00;

  for (var txn in txnData) {
    if (txn.crAmount != 0) income += txn.crAmount;
    if (txn.drAmount != 0) expenditure += txn.drAmount;
  }

  Map<String, dynamic> data = {
    'title': "Weekly",
    'income': income,
    'expenditure': expenditure
  };

  return data;
});

final thisMonthDataProvider = Provider((ref) {
  final txnData = TransactionService.instance.getAllWithDateRange(
      startDate: firstDayOfMonth(), endtDate: lastDayOfMonth());

  double income = 0.00;
  double expenditure = 0.00;

  for (var txn in txnData) {
    if (txn.crAmount != 0) income += txn.crAmount;
    if (txn.drAmount != 0) expenditure += txn.drAmount;
  }

  Map<String, dynamic> data = {
    'title': "Monthly",
    'income': income,
    'expenditure': expenditure
  };

  return data;
});

final thisYearDataProvider = Provider((ref) {
  final txnData = TransactionService.instance.getAllWithDateRange(
      startDate: firstDayOfYear(), endtDate: lastDayOfYear());

  double income = 0.00;
  double expenditure = 0.00;

  for (var txn in txnData) {
    if (txn.crAmount != 0) income += txn.crAmount;
    if (txn.drAmount != 0) expenditure += txn.drAmount;
  }

  Map<String, dynamic> data = {
    'title': "Yearly",
    'income': income,
    'expenditure': expenditure
  };

  return data;
});

final thisDayDataProvider = Provider((ref) {
  final txnData = TransactionService.instance.getAllToday();
  double income = 0.00;
  double expenditure = 0.00;
  for (var txn in txnData) {
    if (txn.crAmount != 0) income += txn.crAmount;
    if (txn.drAmount != 0) expenditure += txn.drAmount;
  }

  Map<String, dynamic> data = {
    'title': "Todays' Summary",
    'income': income,
    'expenditure': expenditure
  };

  return data;
});

//======================================================================
final homeDataProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, AsyncValue<InitDataModel>>(
        (ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<AsyncValue<InitDataModel>> {
  final Ref ref;
  HomeNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadData();
  }

  void loadData() {
    final alldata = InitDataModel(
      thisDay: ref.watch(thisDayDataProvider),
      thisWeek: ref.watch(thisWeekDataProvider),
      thisMonth: ref.watch(thisMonthDataProvider),
      thisYear: ref.watch(thisYearDataProvider),
      thisTransactions: ref.watch(thisDayTransactionsProvider),
    );

    state = AsyncValue<InitDataModel>.data(alldata);
  }

  // void overviewData() {
  //   //--Today
  //   double income0 = 0.00;
  //   double expenditure0 = 0.00;

  //   final txnData0 = TransactionService.instance.getAllToday();

  //   for (var txn in txnData0) {
  //     if (txn.crAmount != 0) income0 += txn.crAmount;
  //     if (txn.drAmount != 0) expenditure0 += txn.drAmount;
  //   }

  //   Map<String, dynamic> todaysData = {
  //     'key': 'TODAY',
  //     'title': "Todays' Summary",
  //     'income': income0,
  //     'expenditure': expenditure0
  //   };

  //   //--Weekly
  //   double income1 = 0.00;
  //   double expenditure1 = 0.00;

  //   final txnData1 = TransactionService.instance.getAllWithDateRange(
  //       startDate: firstDayOfWeek(), endtDate: lastDayOfWeek());
  //   for (var txn in txnData1) {
  //     if (txn.crAmount != 0) income1 += txn.crAmount;
  //     if (txn.drAmount != 0) expenditure1 += txn.drAmount;
  //   }

  //   Map<String, dynamic> weeklyData = {
  //     'key': 'THIS_WEEK',
  //     'title': 'This Week',
  //     'income': income1,
  //     'expenditure': expenditure1
  //   };

  //   //--Monthly
  //   double income2 = 0.00;
  //   double expenditure2 = 0.00;

  //   final txnData2 = TransactionService.instance.getAllWithDateRange(
  //       startDate: firstDayOfMonth(), endtDate: lastDayOfMonth());
  //   for (var txn in txnData2) {
  //     if (txn.crAmount != 0) income2 += txn.crAmount;
  //     if (txn.drAmount != 0) expenditure2 += txn.drAmount;
  //   }

  //   Map<String, dynamic> monthlyData = {
  //     'key': 'THIS_MONTH',
  //     'title': 'This Month',
  //     'income': income2,
  //     'expenditure': expenditure2
  //   };

  //   //--Yearly
  //   double income3 = 0.00;
  //   double expenditure3 = 0.00;

  //   final txnData3 = TransactionService.instance.getAllWithDateRange(
  //       startDate: firstDayOfYear(), endtDate: lastDayOfYear());
  //   for (var txn in txnData3) {
  //     if (txn.crAmount != 0) income3 += txn.crAmount;
  //     if (txn.drAmount != 0) expenditure3 += txn.drAmount;
  //   }

  //   Map<String, dynamic> yearlyData = {
  //     'key': 'THIS_YEAR',
  //     'title': 'This Year',
  //     'income': income3,
  //     'expenditure': expenditure3
  //   };

  //   List<Map<String, dynamic>> data = [
  //     {'today': todaysData},
  //     {
  //       'overall': [weeklyData, monthlyData, yearlyData]
  //     }
  //   ];
  //   //=====================================================================

  //   state = AsyncValue<List<Map<String, dynamic>>>.data(data);
  // }

}
