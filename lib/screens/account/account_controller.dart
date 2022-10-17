import 'package:finsoft2/data/models/accounts_model.dart';

import 'package:finsoft2/data/repositories/account_repository.dart';
import 'package:finsoft2/data/source/objectstore.dart';
import 'package:finsoft2/utils/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountBox = objBox!.store.box<AccountsModel>();

final hasChildProvider = StateProvider<bool>((ref) => false);

final accountProvider = StateNotifierProvider.autoDispose
    .family<AccountState, AsyncValue<List<AccountsModel>>, int>((ref, account) {
  return AccountState(account: account);
});

final operationalAccounsProvider = StateNotifierProvider.family.autoDispose<
    OperationalAccountsNotifier,
    AsyncValue<List<AccountsModel>>,
    String>((ref, txnType) {
  return OperationalAccountsNotifier(txnType);
});

class AccountState extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  final int account;
  AccountState({required this.account})
      : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getAccounts(account);
  }

  //---GET ALL
  getAccounts(int account) async {
    final data = await AccountRepository().list(parent: account);
    state = AsyncValue<List<AccountsModel>>.data(data);
  }

  //--CREATE
  Future<bool> create({required Map<String, dynamic> formData}) async {
    try {
      final data = AccountsModel(
        name: formData['name'].toString().trim(),
        isActive: formData['isActive'] ?? true,
        isSystem: false,
        parent: int.parse(formData['parent'].toString()).toInt(),
        hasChild: formData['hasChild'],
        type: formData['accountType'],
        createdOn: convertDateToLocal(DateTime.now().toString()),
        allowPayment: formData['allowPayment'] ?? false,
        allowReceipt: formData['allowReceipt'] ?? false,
        allowTransfer: formData['allowTransfer'] ?? false,
        budget: formData['budget'] != null
            ? double.parse(formData['budget'].toString()).toDouble()
            : 0.0,
        openingBalance: formData['openingBalance'] != null
            ? double.parse(formData['openingBalance'].toString()).toDouble()
            : 0.0,
      );

      // final ledger = ledgerBox.get(formData['ledgerId']);
      // data.ledger.target = ledger;

      accountBox.put(data);
      objBox!.store.awaitAsyncSubmitted();

      getAccounts(account);

      return true;
    } catch (e) {
      return false;
    }
  }

  //--DELETE
  Future<bool> delete() async {
    try {
      final response = await AccountRepository().delete(id: account);
      getAccounts(account);
      return response;
    } catch (e) {
      return false;
    }
  }

  Future getAccount() async {
    final response = await AccountRepository().get(id: account);

    return response;
  }

  //--UPDATE
  Future<bool> update(
      {required int accountId,
      required int parentId,
      required Map<String, dynamic> formData}) async {
    try {
      final response =
          await AccountRepository().update(id: account, formData: formData);

      return response;
    } catch (e) {
      return false;
    }
  }
}

class OperationalAccountsNotifier
    extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  final String txnType;
  OperationalAccountsNotifier(this.txnType)
      : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getAccounts(txnType);
  }

  getAccounts(String txnType) async {
    final data = await AccountRepository().listWithTxnType(txnType: txnType);
    state = AsyncValue<List<AccountsModel>>.data(data);
  }
}
