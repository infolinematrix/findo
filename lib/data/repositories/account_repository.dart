import 'package:findo/data/models/accounts_model.dart';
import 'package:findo/data/models/transactions_model.dart';
import 'package:findo/data/source/objectstore.dart';
import 'package:findo/objectbox.g.dart';

class AccountRepository {
  final accountBox = objBox!.store.box<AccountsModel>();
  final transactionBox = objBox!.store.box<TransactionsModel>();

  //** GROUPS **//
  Future<List<AccountsModel>> allGroups() async {
    QueryBuilder<AccountsModel> builder = accountBox.query(
        AccountsModel_.isActive.equals(true) &
            AccountsModel_.name.notEquals('') &
            AccountsModel_.parent.equals(0))
      ..order(AccountsModel_.name, flags: Order.caseSensitive);

    Query<AccountsModel> query = builder.build();
    List<AccountsModel> data = query.find().toList();

    query.close();
    return data;
  }

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
                AccountsModel_.parent.notEquals(0) &
                AccountsModel_.hasChild.equals(false) &
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
                AccountsModel_.parent.notEquals(0) &
                AccountsModel_.hasChild.equals(false) &
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
                AccountsModel_.parent.notEquals(0) &
                AccountsModel_.hasChild.equals(false) &
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
  Future get({required id}) async {
    final account = accountBox.get(id);

    return account!;
  }

  //--Update
  Future update({required id, required Map<String, dynamic> formData}) async {
    final account = accountBox.get(id);
    account!.name = formData['name'].toString().trim();

    accountBox.putAsync(account);

    return true;
  }

  //--Delete

  Future<bool> delete({required id}) async {
    /**
       * Account can't delete
       * 1) accout is System
       * 2) account is Inactive
       * 3) account has transactions
       * 4) account is locked
       * 5) account has Child account
       */

    bool childAccountExist = true;
    bool hasTransactions = true;

    final account = accountBox.get(id);

    //--Has child Account
    QueryBuilder<AccountsModel> childBuilder =
        accountBox.query(AccountsModel_.parent.equals(account!.id));
    Query<AccountsModel> childQuery = childBuilder.build();
    List<AccountsModel> chidData = childQuery.find().toList();
    childQuery.close();

    if (chidData.isEmpty) {
      childAccountExist = false;
    }

    QueryBuilder<TransactionsModel> builder =
        transactionBox.query(TransactionsModel_.account.equals(account.id));
    Query<TransactionsModel> query = builder.build();
    List<TransactionsModel> data = query.find().toList();
    query.close();
    if (data.isEmpty) hasTransactions = false;

    if (childAccountExist == false &&
        hasTransactions == false &&
        account.isSystem == false &&
        account.isLocked == false &&
        account.isActive == true) {
      accountBox.remove(account.id);
      return true;
    }

    return false;
  }
}
