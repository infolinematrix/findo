import '../data/models/accounts_model.dart';
import '../data/source/objectstore.dart';
import '../objectbox.g.dart';

class AccountService {
  AccountService._();
  static final instance = AccountService._();

  final accountsBox = objBox!.store.box<AccountsModel>();

  getAll() {
    final builder = accountsBox.query(AccountsModel_.isActive.equals(true) &
        AccountsModel_.name.notEquals(''))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();

    List<AccountsModel> data = query.find().toList();
    query.close();

    return data;
  }

  getAccount({required int accountId}) {
    final account = accountsBox.get(accountId);

    return account;
  }
}
