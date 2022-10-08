import 'package:finsoft2/data/models/ledger_model.dart';
import 'package:finsoft2/data/models/scroll_model.dart';
import 'package:finsoft2/data/source/objectstore.dart';
import 'package:finsoft2/screens/error_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objectbox/objectbox.dart';

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
    final ledgerBox = objBox!.store.box<LedgerModel>();
    final accountBox = objBox!.store.box<AccountsModel>();
    final scrollBox = objBox!.store.box<ScrollModel>();

    //--Transaction Begins
    objBox!.store.runInTransaction(TxMode.write, () {
      /**
       * Settings
       */
      for (var element in formData.entries) {
        settingBox
            .putAsync(SettingsModel(key: element.key, value: element.value));
      }

      /**
       * Creating Ledgers/Groups
       */
      List<LedgerModel> ledgers = [
        LedgerModel(
            name: 'Cash Account',
            isSystem: true,
            isActive: true,
            isVisible: false),
        LedgerModel(
            name: 'Bank Account',
            isSystem: true,
            isActive: true,
            isVisible: true),
        LedgerModel(
            name: 'Household Expenses',
            isSystem: false,
            isActive: true,
            isVisible: true),
        LedgerModel(
            name: 'Bills', isSystem: false, isActive: true, isVisible: true),
        LedgerModel(
            name: 'Loans', isSystem: false, isActive: true, isVisible: true),
        LedgerModel(
            name: 'Entertainment',
            isSystem: false,
            isActive: true,
            isVisible: true),
        LedgerModel(
            name: 'Travelling',
            isSystem: false,
            isActive: true,
            isVisible: true),
        LedgerModel(
            name: 'Food & Beverage',
            isSystem: false,
            isActive: true,
            isVisible: true),
      ];

      ledgerBox.putMany(ledgers);
      objBox!.store.awaitAsyncSubmitted();

      /**
       * Creating Accounts
       */
      AccountsModel accounts = AccountsModel(
          name: 'Cash', isSystem: true, isVisible: false, allowTransfer: true);

      final ledger = ledgerBox.get(1);
      accounts.ledger.target = ledger; //--Set Cash Ledger
      accountBox.put(accounts);
      objBox!.store.awaitAsyncSubmitted();

      /**
       * Scroll
       */
      ScrollModel scroll = ScrollModel(slno: 0);
      scrollBox.put(scroll);
      objBox!.store.awaitAsyncSubmitted();

      /**
       * Final returns
       */
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
  // QueryBuilder<SettingsModel> builder;
  // builder =
  //     objBox!.store.box<SettingsModel>().query(SettingsModel_.key.equals(key));

  // Query<SettingsModel> query = builder.build();

  // SettingsModel data = query.findFirst()!;
  // return data;
}

currencySymbol() {
  SettingsModel settings = getSetting(key: 'currency');

  String currency = settings.value;
  final currencyIcon =
      currencies.where((element) => element['code'] == currency).first;
  return currencyIcon['icon'];
}
