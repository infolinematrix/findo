import '../data/models/accounts_model.dart';
import '../data/source/objectstore.dart';

class AccountService {
  AccountService._();
  static final instance = AccountService._();

  final accountsBox = objBox!.store.box<AccountsModel>();

  getAccount({required int accountId}) {
    final account = accountsBox.get(accountId);

    return account;
  }
}
