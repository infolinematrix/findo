import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/services/transaction_service.dart';
import 'package:finsoft2/utils/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    if (txn.txnType == 'CR') income += txn.account;
    if (txn.txnType == 'DR') expenditure += txn.amount;
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
    if (txn.txnType == 'CR') income += txn.account;
    if (txn.txnType == 'DR') expenditure += txn.amount;
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
    if (txn.txnType == 'CR') income += txn.account;
    if (txn.txnType == 'DR') expenditure += txn.amount;
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
    if (txn.txnType == 'CR') income += txn.account;
    if (txn.txnType == 'DR') expenditure += txn.amount;
  }

  Map<String, dynamic> data = {
    'title': "Todays' Summary",
    'income': income,
    'expenditure': expenditure
  };

  return data;
});

//=============================================================--=========
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
}
