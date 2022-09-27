import 'package:finsoft2/data/source/objectstore.dart';
import 'package:finsoft2/screens/error_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/accounts_model.dart';
import '../data/models/settings_model.dart';
import '../data/models/transactions_model.dart';

// class InitAppModel {
//   final Box<SettingsModel> settings;
//   final Box<AccountsModel> accounts;

//   InitAppModel({
//     required this.settings,
//     required this.accounts,
//   });
// }

final hasSettings = FutureProvider.autoDispose<bool>((ref) async {
  try {
    final settingsData = objBox!.store.box<SettingsModel>();
    if (settingsData.isEmpty() == false) {
      return true;
    }
  } catch (e) {
    ErrorScreen(
      msg: e.toString(),
    );
  }
  return false;
});

final createSettings = FutureProvider.autoDispose
    .family((ref, Map<String, dynamic> formData) async {
  try {
    final settingsData = objBox!.store.box<SettingsModel>();
    final accountsData = objBox!.store.box<AccountsModel>();

    for (var element in formData.entries) {
      settingsData
          .putAsync(SettingsModel(key: element.key, value: element.value));
    }

    List<AccountsModel> accounts = [
      AccountsModel(name: 'Household Expense', isSystem: true),
      AccountsModel(name: 'Repaire & Maintanence', isSystem: true),
      AccountsModel(name: 'Educational Expense', isSystem: true),
      AccountsModel(name: 'Travelling and Conveyance', isSystem: true),
      AccountsModel(name: 'Loans Payment', isSystem: true),
      AccountsModel(name: 'Online Shopping', isSystem: true),
      AccountsModel(name: 'Bills Payment', isSystem: true),
      AccountsModel(name: 'Fuel Expenses', isSystem: true),
      AccountsModel(name: 'Others', isSystem: true),
    ];

    accountsData.putMany(accounts);
    objBox!.store.awaitAsyncSubmitted();

    return true;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
});

final getSettingsProvider = Provider((ref) {
  return objBox!.store.box<SettingsModel>();
});

final resetBoxProvider = FutureProvider<bool>((ref) async {
  try {
    final settingsData = objBox!.store.box<SettingsModel>();
    final accountsData = objBox!.store.box<AccountsModel>();
    final transactionsData = objBox!.store.box<TransactionsModel>();
    settingsData.removeAll();
    accountsData.removeAll();
    transactionsData.removeAll();

    return true;
  } catch (e) {
    return false;
  }
});
