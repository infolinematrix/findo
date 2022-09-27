import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/source/objectstore.dart';
import 'package:finsoft2/objectbox.g.dart';
import 'package:finsoft2/services/account_service.dart';
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

// -- GET ACCOUNT
final getAccountProvider = FutureProvider.family
    .autoDispose<AccountsModel, int>((ref, int accountId) async {
  final accountsData = AccountService.instance.getAccount(accountId: accountId);
  return accountsData;
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
        isVisible: formData['isVisible'],
        isTemporary: formData['isTemporary'],
        budget: formData['budget'],
        description: formData['description'],
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

  //--Update Account
  Future<bool> update(
      {required int id, required Map<String, dynamic> formData}) async {
    AccountsModel accountsData =
        AccountService.instance.getAccount(accountId: id);

    accountsData.name = formData['name'].toString().trim();
    accountsData.isActive = formData['isActive'];
    accountsData.isVisible = formData['isVisible'];
    accountsData.isTemporary = formData['isTemporary'];
    accountsData.description = formData['description'].toString().trim();

    accountsData.budget =
        double.parse(formData['budget'].toString()).toDouble();

    accountsBox.put(accountsData);
    objBox!.store.awaitAsyncSubmitted();
    getAccounts();
    return true;
  }
}
