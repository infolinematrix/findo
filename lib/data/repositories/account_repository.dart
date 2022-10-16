import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/source/objectstore.dart';
import 'package:finsoft2/objectbox.g.dart';

class AccountRepository {
  final accountBox = objBox!.store.box<AccountsModel>();

  //--List
  list({required int parent}) {
    QueryBuilder<AccountsModel> builder = accountBox.query(
        AccountsModel_.isActive.equals(true) &
            AccountsModel_.name.notEquals('') &
            AccountsModel_.parent.equals(parent))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();
    List<AccountsModel> data = query.find().toList();

    query.close();
    return data;
  }

  //--List account which are allowed for Receipt, Payment, Transafer
  listWithTxnType({required String txnType}) {
    switch (txnType) {
      case "RECEIPT":
        QueryBuilder<AccountsModel> builder = accountBox.query(
            AccountsModel_.isActive.equals(true) &
                AccountsModel_.name.notEquals('') &
                AccountsModel_.allowReceipt.equals(true))
          ..order(AccountsModel_.name, flags: Order.caseSensitive);

        Query<AccountsModel> query = builder.build();
        List<AccountsModel> data = query.find().toList();

        query.close();
        return data;

      case "TRANSFER":
        QueryBuilder<AccountsModel> builder = accountBox.query(
            AccountsModel_.isActive.equals(true) &
                AccountsModel_.name.notEquals('') &
                AccountsModel_.allowTransfer.equals(true))
          ..order(AccountsModel_.name, flags: Order.caseSensitive);

        Query<AccountsModel> query = builder.build();
        List<AccountsModel> data = query.find().toList();

        query.close();
        return data;

      default:
        QueryBuilder<AccountsModel> builder = accountBox.query(
            AccountsModel_.isActive.equals(true) &
                AccountsModel_.name.notEquals('') &
                AccountsModel_.allowPayment.equals(true))
          ..order(AccountsModel_.name, flags: Order.caseSensitive);

        Query<AccountsModel> query = builder.build();
        List<AccountsModel> data = query.find().toList();

        query.close();
        return data;
    }
  }

  listByLedger({required int ledgerId}) {
    QueryBuilder<AccountsModel> builder = accountBox.query(
        AccountsModel_.isActive.equals(true) &
            AccountsModel_.name.notEquals(''))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();
    List<AccountsModel> data = query.find().toList();

    query.close();
    return data;
  }

  listByType({required String type}) {
    QueryBuilder<AccountsModel> builder = accountBox.query(
        AccountsModel_.type.equals(type) & AccountsModel_.name.notEquals(''))
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
