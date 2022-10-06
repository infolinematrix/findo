import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/models/ledger_model.dart';
import 'package:finsoft2/data/repositories/account_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/source/objectstore.dart';

final accountBox = objBox!.store.box<AccountsModel>();
final ledgerBox = objBox!.store.box<LedgerModel>();

final accountProvider = StateNotifierProvider.autoDispose
    .family<AccountState, AsyncValue<List<AccountsModel>>, int>(
        (ref, ledgerId) {
  return AccountState(ledgerId: ledgerId);
});

class AccountState extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  final int ledgerId;
  AccountState({required this.ledgerId})
      : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getAccounts();
  }

  //---GET ALL
  getAccounts() async {
    final data = await AccountRepository().listByLedger(ledgerId: ledgerId);
    state = AsyncValue<List<AccountsModel>>.data(data);
  }

  // accountsByLedger({required ledgerId}) {
  //   final List<AccountsModel> data =
  //       AccountRepository().listByLedger(ledgerId: ledgerId);

  //   state = AsyncValue<List<AccountsModel>>.data(data);
  // }

  //--CREATE
  Future<bool> create({required Map<String, dynamic> formData}) async {
    try {
      final data = AccountsModel(
        name: formData['name'].toString().trim(),
        isActive: formData['isActive'] ?? false,
        isSystem: false,
        budget: formData['budget'] != null
            ? double.parse(formData['budget'].toString()).toDouble()
            : 0.0,
        createdOn: DateTime.now(),
      );

      final ledger = ledgerBox.get(formData['ledgerId']);
      data.ledger.target = ledger;

      accountBox.put(data);
      objBox!.store.awaitAsyncSubmitted();

      getAccounts();

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  //--GET
  Future get({required int id}) async {
    try {
      final data = accountBox.get(id);
      return data;
    } catch (e) {
      return false;
    }
  }

  //--DELETE
  Future<bool> delete({required int id}) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }

  //--UPDATE
  Future<bool> update(
      {required int id, required Map<String, dynamic> formData}) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
