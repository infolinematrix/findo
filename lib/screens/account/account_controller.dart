import 'package:findo/data/models/accounts_model.dart';

import 'package:findo/data/repositories/account_repository.dart';
import 'package:findo/data/source/objectstore.dart';
import 'package:findo/utils/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountBox = objBox!.store.box<AccountsModel>();

final hasChildProvider = StateProvider.autoDispose<bool>((ref) => false);

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
  Future<bool> create(
      {required AccountsModel parent,
      required Map<String, dynamic> formData}) async {
    try {
      final data = AccountsModel(
        name: formData['name'].toString().trim(),
        isActive: formData['isActive'] ?? true,
        parent: parent.id,
        description: formData['description'].toString().trim(),
        hasChild: formData['hasChild'] ?? false,
        type: parent.type.toString().trim(),
        createdOn: convertDateToLocal(DateTime.now().toString()),
        allowPayment: parent.allowPayment,
        allowReceipt: parent.allowReceipt,
        allowTransfer: parent.allowTransfer,
        budget: parent.type == 'EXPENSES'
            ? double.parse(formData['budget'].toString()).toDouble()
            : 0.0,
        openingBalance: formData['openingBalance'] != null
            ? double.parse(formData['openingBalance'].toString()).toDouble()
            : 0.0,
      );

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
