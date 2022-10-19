import 'package:findo/data/models/scroll_model.dart';
import 'package:findo/data/source/objectstore.dart';
import 'package:findo/objectbox.g.dart';
import 'package:findo/screens/error_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/constants.dart';
import '../data/models/accounts_model.dart';
import '../data/models/settings_model.dart';
import '../data/models/transactions_model.dart';

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
  bool done = false;

  try {
    final settingBox = objBox!.store.box<SettingsModel>();

    final accountBox = objBox!.store.box<AccountsModel>();
    final scrollBox = objBox!.store.box<ScrollModel>();

    //--Transaction Begins
    objBox!.store.runInTransaction(TxMode.write, () {
      /**
       * Settings
       */
      for (var element in formData.entries) {
        if (element.key != 'theme') {
          settingBox
              .putAsync(SettingsModel(key: element.key, value: element.value));
        }
      }

      /**
       * Scroll
       */
      ScrollModel scroll = ScrollModel(slno: 0);
      scrollBox.put(scroll);

      /**
       * Inital Accounts
       */
      List<AccountsModel> accounts = [
        AccountsModel(
            createdOn: DateTime.now().toLocal(),
            hasChild: true,
            name: "Bank Accounts",
            parent: 0,
            type: 'BANK',
            allowAlert: false,
            allowPayment: false,
            allowReceipt: false,
            allowTransfer: true,
            isActive: true,
            isLocked: false,
            isSystem: true),
        AccountsModel(
            createdOn: DateTime.now().toLocal(),
            hasChild: true,
            name: "Household Expenses",
            parent: 0,
            type: 'EXPENSES',
            allowAlert: false,
            allowPayment: true,
            allowReceipt: false,
            allowTransfer: false,
            isActive: true,
            isLocked: false,
            isSystem: false),
        AccountsModel(
            createdOn: DateTime.now().toLocal(),
            hasChild: true,
            name: "Personal Expenses",
            parent: 0,
            type: 'EXPENSES',
            allowAlert: false,
            allowPayment: true,
            allowReceipt: false,
            allowTransfer: false,
            isActive: true,
            isLocked: false,
            isSystem: false),
        AccountsModel(
            createdOn: DateTime.now().toLocal(),
            hasChild: true,
            name: "Travelling & Conveyance",
            parent: 0,
            type: 'EXPENSES',
            allowAlert: false,
            allowPayment: true,
            allowReceipt: false,
            allowTransfer: false,
            isActive: true,
            isLocked: false,
            isSystem: false),
        AccountsModel(
            createdOn: DateTime.now().toLocal(),
            hasChild: true,
            name: "Health & Medical",
            parent: 0,
            type: 'EXPENSES',
            allowAlert: false,
            allowPayment: true,
            allowReceipt: false,
            allowTransfer: false,
            isActive: true,
            isLocked: false,
            isSystem: false),
        AccountsModel(
            createdOn: DateTime.now().toLocal(),
            hasChild: true,
            name: "Entertainment Expenses",
            parent: 0,
            type: 'EXPENSES',
            allowAlert: false,
            allowPayment: true,
            allowReceipt: false,
            allowTransfer: false,
            isActive: true,
            isLocked: false,
            isSystem: false),
        AccountsModel(
            createdOn: DateTime.now().toLocal(),
            hasChild: true,
            name: "Restaurant & Refreshment",
            parent: 0,
            type: 'EXPENSES',
            allowAlert: false,
            allowPayment: true,
            allowReceipt: false,
            allowTransfer: false,
            isActive: true,
            isLocked: false,
            isSystem: false),
        AccountsModel(
            createdOn: DateTime.now().toLocal(),
            hasChild: true,
            name: "Utility Expenses",
            parent: 0,
            type: 'EXPENSES',
            allowAlert: false,
            allowPayment: true,
            allowReceipt: false,
            allowTransfer: false,
            isActive: true,
            isLocked: false,
            isSystem: false),
      ];

      accountBox.putMany(accounts);

      objBox!.store.awaitAsyncSubmitted();
      done = true;
    });
  } catch (e) {
    done = false;
    return done;
  }
  return done;
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

getSetting({required String key}) {
  QueryBuilder<SettingsModel> builder;
  builder =
      objBox!.store.box<SettingsModel>().query(SettingsModel_.key.equals(key));

  Query<SettingsModel> query = builder.build();

  SettingsModel data = query.findFirst()!;
  return data;
}

currencySymbol() {
  SettingsModel settings = getSetting(key: 'currency');

  String currency = settings.value;
  final currencyIcon =
      currencies.where((element) => element['code'] == currency).first;
  return currencyIcon['icon'];
}
