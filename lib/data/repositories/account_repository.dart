import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/source/objectstore.dart';
import 'package:finsoft2/objectbox.g.dart';

class AccountRepository {
  final accountBox = objBox!.store.box<AccountsModel>();

  //--List
  list() {
    QueryBuilder<AccountsModel> builder = accountBox.query(
        AccountsModel_.isActive.equals(true) &
            AccountsModel_.name.notEquals(''))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();
    List<AccountsModel> data = query.find().toList();

    query.close();
    return data;
  }

  listByLedger({required int ledgerId}) {
    QueryBuilder<AccountsModel> builder = accountBox.query(
        AccountsModel_.isActive.equals(true) &
            AccountsModel_.name.notEquals('') &
            AccountsModel_.ledger.equals(ledgerId))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();
    List<AccountsModel> data = query.find().toList();

    query.close();
    return data;
  }

  //--Get
  Future get({required id}) async {}

  //--Create
  Future create() async {}

  //--Update
  Future update({required id, required Map<String, dynamic> formData}) async {}

  //--Delete
  Future delete({required id}) async {}
}
