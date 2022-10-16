import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/repositories/account_repository.dart';
import 'package:finsoft2/data/source/objectstore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountBox = objBox!.store.box<AccountsModel>();

final bankAccountsProvider = StateNotifierProvider.autoDispose<
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

  create() {}
}
