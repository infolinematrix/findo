import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/source/objectstore.dart';
import 'package:finsoft2/objectbox.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountsBox = objBox!.store.box<AccountsModel>();

final allAccountsProvider =
    FutureProvider.autoDispose<List<AccountsModel>>((ref) async {
  try {
    final accountsData = objBox!.store.box<AccountsModel>();

    final qBuilder = accountsData.query(AccountsModel_.isActive.equals(true) &
        AccountsModel_.name.notEquals(''));

    qBuilder.order(AccountsModel_.name, flags: Order.caseSensitive);

    List<AccountsModel> data = qBuilder.build().find();

    return data;
  } catch (e) {
    return [];
  }
});

//-------------------------------------------------------------

final accountsProvider =
    StateNotifierProvider<AccountsState, AsyncValue<List<AccountsModel>>>(
        (ref) {
  return AccountsState();
});

class AccountsState extends StateNotifier<AsyncValue<List<AccountsModel>>> {
  AccountsState() : super(const AsyncValue<List<AccountsModel>>.loading()) {
    getAccounts();
  }

  getAccounts() {
    QueryBuilder<AccountsModel> builder = accountsBox.query(
        AccountsModel_.isActive.equals(true) &
            AccountsModel_.name.notEquals(''))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();

    List<AccountsModel> data = query.find().toList();

    state = AsyncValue<List<AccountsModel>>.data(data);

    query.close();
  }

  //--Create New
  Future<bool> create({required Map<String, dynamic> formData}) async {
    try {
      final data = AccountsModel(
        name: formData['name'],
        isActive: formData['isActive'],
        isSystem: false,
      );

      accountsBox.put(data);
      objBox!.store.awaitAsyncSubmitted();

      getAccounts();

      return true;
    } catch (e) {
      rethrow;
    }
  }
}
