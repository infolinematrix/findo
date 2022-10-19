import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/data/repositories/account_repository.dart';
import 'package:findo/data/repositories/settings_repository.dart';
import 'package:findo/data/source/objectstore.dart';
import 'package:findo/objectbox.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountBox = objBox!.store.box<AccountsModel>();

class InitAppModel {
  final List settings;
  final List bankAccounts;

  InitAppModel({
    required this.settings,
    required this.bankAccounts,
  });
}

final inttAppProvider = FutureProvider.autoDispose<InitAppModel>((ref) async {
  final settings = await ref.watch(getSettingsProvider.future);
  final bankAccounts = await ref.watch(bankAccountsProvider.future);

  // isLoggedIn == true ? await ref.watch(getHomeProvider) : false;

  return InitAppModel(
    settings: settings,
    bankAccounts: bankAccounts,
  );
});

final getSettingsProvider = FutureProvider((ref) async {
  final data = await SettingsRepository().getAll();
  return data;
});

final bankAccountsProvider = FutureProvider((ref) async {
  // final data = await AccountRepository().listByType(type: 'BANK');
  QueryBuilder<AccountsModel> builder = accountBox.query(
      AccountsModel_.type.equals('BANK') &
          AccountsModel_.name.notEquals('') &
          AccountsModel_.parent.notEquals(0));

  Query<AccountsModel> query = builder.build();
  List<AccountsModel> data = query.find().toList();

  query.close();
  return data;
});

//--------------------------------------------------------------------
final initailBankAccountsProvider = StateNotifierProvider.autoDispose<
    BankAccountNotifier, AsyncValue<List<AccountsModel>>>((ref) {
  return BankAccountNotifier();
});

class BankAccountNotifier
    extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  BankAccountNotifier()
      : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getBankAccounts();
  }

  getBankAccounts() async {
    final data = await AccountRepository().listByType(type: 'BANK');
    state = AsyncValue<List<AccountsModel>>.data(data);
  }

  Future<bool> create(Map<String, dynamic> formData) async {
    try {
      objBox!.store.runInTransaction(TxMode.write, () {
        //--Create a prent Account (Bank)
        final accountData = AccountsModel(
            hasChild: false,
            name: formData['bank'],
            parent: 1,
            type: 'BANK',
            allowPayment: false,
            isActive: formData['isActive'] ?? false,
            allowAlert: false,
            allowReceipt: false,
            allowTransfer: true,
            openingBalance:
                double.parse(formData['openingBalance'].toString()).toDouble(),
            createdOn: DateTime.now().toLocal());
        final account =
            objBox!.store.box<AccountsModel>().putAsync(accountData);

        print(account);
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
