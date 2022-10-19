import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/data/repositories/account_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Future create({required Map<String, dynamic> data}) async {}

  //--UPDATE
  Future update({required int id, required Map<String, dynamic> data}) async {}

  //--DELETE
  Future delete({required int id}) async {}
}
