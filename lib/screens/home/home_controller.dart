import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/models/settings_model.dart';
import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/services/transaction_service.dart';
import 'package:finsoft2/utils/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/source/objectstore.dart';
import '../../objectbox.g.dart';
import '../../services/settings_service.dart';

final initHomeProvider = FutureProvider.autoDispose<InitAppModel>((ref) async {
  final settings = ref.watch(getSettingsProvider);

  return InitAppModel(
    settings: settings,
  );
});

class InitAppModel {
  final Box<SettingsModel> settings;

  InitAppModel({
    required this.settings,
  });
}

final homeProvider = FutureProvider((ref) async {
  try {
    QueryBuilder<TransactionsModel> builder =
        objBox!.store.box<TransactionsModel>().query(
              TransactionsModel_.txnDate.between(
                  firstDayOfWeek().millisecondsSinceEpoch,
                  lastDayOfWeek().millisecondsSinceEpoch),
            );

    Query<TransactionsModel> query = builder.build()
      ..limit = 25
      ..offset = 0;

    List<TransactionsModel> data = query.find().toList();

    print(firstDayOfWeek().toString());
    print(data);

    return;
  } catch (e) {
    return;
  }
});
//------------------------------------------------------------------------

class InitDataModel {
  final Map<String, dynamic> thisWeek;
  final Map<String, dynamic> thisMonth;
  final Map<String, dynamic> thisYear;
  final List<Map<String, dynamic>> accountListData;

  InitDataModel(
      {required this.thisWeek,
      required this.thisMonth,
      required this.thisYear,
      required this.accountListData});
}

final initialData = FutureProvider.autoDispose<InitDataModel>((ref) async {
  final thisWeekData = ref.watch(thisWeekDataProvider);
  final thisMonthData = ref.watch(thisMonthDataProvider);
  final thisYearData = ref.watch(thisYearDataProvider);
  final allAccountListData = ref.watch(accountMontlyProvider);

  return InitDataModel(
      thisWeek: thisWeekData,
      thisMonth: thisMonthData,
      thisYear: thisYearData,
      accountListData: allAccountListData);
});

final accountMontlyProvider = Provider((ref) {
  final accountsBox = objBox!.store.box<AccountsModel>();
  QueryBuilder<AccountsModel> accountBuilder = accountsBox.query(
      AccountsModel_.isActive.equals(true) & AccountsModel_.name.notEquals(''))
    ..order(AccountsModel_.name, flags: Order.caseSensitive);

  Query<AccountsModel> accountQuery = accountBuilder.build();

  List<AccountsModel> accountData = accountQuery.find().toList();

  List<Map<String, dynamic>> accountListData = [];

  for (var account in accountData) {
    accountListData.addAll([
      {
        'accountTitle': account.name,
        'budget': account.budget,
      }
    ]);
  }
  return;
});

final thisWeekDataProvider = Provider((ref) {
  QueryBuilder<TransactionsModel> builder =
      objBox!.store.box<TransactionsModel>().query(
            TransactionsModel_.txnDate.between(
                firstDayOfWeek().millisecondsSinceEpoch,
                lastDayOfWeek().millisecondsSinceEpoch),
          );

  Query<TransactionsModel> query = builder.build();
  List<TransactionsModel> txnData = query.find().toList();

  double incomeW = 0.00;
  double expenditureW = 0.00;

  for (var txn in txnData) {
    if (txn.crAmount != 0) incomeW += txn.crAmount;
    if (txn.drAmount != 0) expenditureW += txn.drAmount;
  }

  return {'weeklyIncome': incomeW, 'weeklyExpenditure': expenditureW};
});

final thisMonthDataProvider = Provider((ref) {
  final txnData = TransactionService.instance.getAllWithDateRange(
      startDate: firstDayOfMonth(), endtDate: lastDayOfMonth());

  double incomeM = 0.00;
  double expenditureM = 0.00;

  for (var txn in txnData) {
    if (txn.crAmount != 0) incomeM += txn.crAmount;
    if (txn.drAmount != 0) expenditureM += txn.drAmount;
  }

  return {'monthlyIncome': incomeM, 'monthlyExpenditure': expenditureM};
});

final thisYearDataProvider = Provider((ref) {
  QueryBuilder<TransactionsModel> builder =
      objBox!.store.box<TransactionsModel>().query(
            TransactionsModel_.txnDate.between(
                firstDayOfYear().millisecondsSinceEpoch,
                lastDayOfYear().millisecondsSinceEpoch),
          );

  Query<TransactionsModel> query = builder.build();
  List<TransactionsModel> txnData = query.find().toList();

  double incomeY = 0.00;
  double expenditureY = 0.00;

  for (var txn in txnData) {
    if (txn.crAmount != 0) incomeY += txn.crAmount;
    if (txn.drAmount != 0) expenditureY += txn.drAmount;
  }

  return {'yearlyIncome': incomeY, 'yearlyExpenditure': expenditureY};
});

//======================================================================
final homeDataProvider = StateNotifierProvider.autoDispose<HomeNotifier,
    AsyncValue<List<Map<String, dynamic>>>>((ref) {
  return HomeNotifier(ref);
});

class HomeNotifier
    extends StateNotifier<AsyncValue<List<Map<String, dynamic>>>> {
  final Ref ref;
  HomeNotifier(this.ref) : super(const AsyncValue.loading()) {
    overviewData();
  }

  void overviewData() {
    //--Today
    double income0 = 0.00;
    double expenditure0 = 0.00;

    final txnData0 = TransactionService.instance.getAllToday();

    for (var txn in txnData0) {
      if (txn.crAmount != 0) income0 += txn.crAmount;
      if (txn.drAmount != 0) expenditure0 += txn.drAmount;
    }

    Map<String, dynamic> todaysData = {
      'key': 'TODAY',
      'title': "Todays' Summary",
      'income': income0,
      'expenditure': expenditure0
    };

    //--Weekly
    double income1 = 0.00;
    double expenditure1 = 0.00;

    final txnData1 = TransactionService.instance.getAllWithDateRange(
        startDate: firstDayOfWeek(), endtDate: lastDayOfWeek());
    for (var txn in txnData1) {
      if (txn.crAmount != 0) income1 += txn.crAmount;
      if (txn.drAmount != 0) expenditure1 += txn.drAmount;
    }

    Map<String, dynamic> weeklyData = {
      'key': 'THIS_WEEK',
      'title': 'This Week',
      'income': income1,
      'expenditure': expenditure1
    };

    //--Monthly
    double income2 = 0.00;
    double expenditure2 = 0.00;

    final txnData2 = TransactionService.instance.getAllWithDateRange(
        startDate: firstDayOfMonth(), endtDate: lastDayOfMonth());
    for (var txn in txnData2) {
      if (txn.crAmount != 0) income2 += txn.crAmount;
      if (txn.drAmount != 0) expenditure2 += txn.drAmount;
    }

    Map<String, dynamic> monthlyData = {
      'key': 'THIS_MONTH',
      'title': 'This Month',
      'income': income2,
      'expenditure': expenditure2
    };

    //--Yearly
    double income3 = 0.00;
    double expenditure3 = 0.00;
    // QueryBuilder<TransactionsModel> builder3 =
    //     objBox!.store.box<TransactionsModel>().query(
    //           TransactionsModel_.txnDate.between(
    //               firstDayOfYear().millisecondsSinceEpoch,
    //               lastDayOfYear().millisecondsSinceEpoch),
    //         );

    // Query<TransactionsModel> query3 = builder3.build();
    // List<TransactionsModel> txnData3 = query3.find().toList();
    // query3.close();

    final txnData3 = TransactionService.instance.getAllWithDateRange(
        startDate: firstDayOfYear(), endtDate: lastDayOfYear());
    for (var txn in txnData3) {
      if (txn.crAmount != 0) income3 += txn.crAmount;
      if (txn.drAmount != 0) expenditure3 += txn.drAmount;
    }

    Map<String, dynamic> yearlyData = {
      'key': 'THIS_YEAR',
      'title': 'This Year',
      'income': income3,
      'expenditure': expenditure3
    };

    List<Map<String, dynamic>> data = [
      {'today': todaysData},
      {
        'overall': [weeklyData, monthlyData, yearlyData]
      }
    ];
    //=====================================================================

    state = AsyncValue<List<Map<String, dynamic>>>.data(data);
  }
}
