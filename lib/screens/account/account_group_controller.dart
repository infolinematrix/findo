import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/data/repositories/account_repository.dart';
import 'package:findo/data/source/objectstore.dart';
import 'package:findo/utils/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountBox = objBox!.store.box<AccountsModel>();

final accountGroupsProvider = StateNotifierProvider.autoDispose<
    AccountGroupsNotifier, AsyncValue<List<AccountsModel>>>((ref) {
  return AccountGroupsNotifier();
});

class AccountGroupsNotifier
    extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  AccountGroupsNotifier()
      : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getAll();
  }

  //---GET ALL
  getAll() async {
    final data = await AccountRepository().allGroups();
    state = AsyncValue<List<AccountsModel>>.data(data);
  }

  //--CREATE
  Future<bool> create({required Map<String, dynamic> formData}) async {
    try {
      final data = AccountsModel(
        parent: 0,
        type: formData['accountType'].toString().trim(),
        name: formData['name'].toString().trim(),
        description: formData['description'].toString().trim(),
        createdOn: convertDateToLocal(DateTime.now().toString()),
        allowPayment: formData['allowPayment'],
        allowReceipt: formData['allowReceipt'],
        allowTransfer: formData['allowTransfer'],
        budget: 0.0,
        openingBalance: 0.0,
      );

      accountBox.put(data);
      objBox!.store.awaitAsyncSubmitted();

      getAll();

      return true;
    } catch (e) {
      return false;
    }
  }

  //--UPDATE
  Future update({required int id, required Map<String, dynamic> data}) async {}

  //--DELETE
  Future delete({required int id}) async {}
}
