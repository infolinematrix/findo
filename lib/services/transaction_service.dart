import 'package:finsoft2/objectbox.g.dart';

import '../data/models/accounts_model.dart';
import '../data/models/transactions_model.dart';
import '../data/source/objectstore.dart';
import '../utils/functions.dart';

class TransactionService {
  TransactionService._();
  static final instance = TransactionService._();

  final accountsBox = objBox!.store.box<AccountsModel>();
  final transactionBox = objBox!.store.box<TransactionsModel>();

  //---------ALL TRANSACTION LIST----------------------//
  List<TransactionsModel> getAll(int? accountId) {
    QueryBuilder<TransactionsModel> builder;

    if (accountId == null) {
      builder = objBox!.store.box<TransactionsModel>().query();
    } else {
      builder = objBox!.store
          .box<TransactionsModel>()
          .query(TransactionsModel_.account.equals(accountId));
    }

    //--Sorting
    builder.order(TransactionsModel_.id, flags: Order.descending);

    Query<TransactionsModel> query = builder.build();
    List<TransactionsModel> data = query.find().toList();

    query.close();
    return data;
  }

  //---------DATE RANGE TRANSACTION LIST---------------//
  List<TransactionsModel> getAllWithDateRange(
      {int? accountId,
      required DateTime startDate,
      required DateTime endtDate}) {
    QueryBuilder<TransactionsModel> builder;

    if (accountId == null) {
      builder = objBox!.store.box<TransactionsModel>().query(
            TransactionsModel_.txnDate.between(startDate.millisecondsSinceEpoch,
                endtDate.millisecondsSinceEpoch),
          );
    } else {
      builder = objBox!.store.box<TransactionsModel>().query(TransactionsModel_
          .txnDate
          .between(
              startDate.millisecondsSinceEpoch, endtDate.millisecondsSinceEpoch)
          .and(TransactionsModel_.account.equals(accountId)));
    }

    //--Sorting
    builder.order(TransactionsModel_.id, flags: Order.descending);

    Query<TransactionsModel> query = builder.build();
    List<TransactionsModel> data = query.find().toList();

    query.close();
    return data;
  }

  //---------CURRENT DATE TRANSACTION LIST-----------//
  List<TransactionsModel> getAllToday({int? accountId}) {
    QueryBuilder<TransactionsModel> builder;

    if (accountId == null) {
      builder = objBox!.store.box<TransactionsModel>().query(TransactionsModel_
          .txnDate
          .greaterOrEqual(dateTodayStart().millisecondsSinceEpoch));
    } else {
      builder = objBox!.store.box<TransactionsModel>().query(TransactionsModel_
          .txnDate
          .greaterOrEqual(dateTodayStart().millisecondsSinceEpoch)
          .and(TransactionsModel_.account.equals(accountId)));
    }
    //--Sorting
    builder.order(TransactionsModel_.id, flags: Order.descending);

    Query<TransactionsModel> query = builder.build();
    List<TransactionsModel> data = query.find().toList();

    query.close();
    return data;
  }

  //---------ADD TRANSACTION-------------------------//
  bool add({required Map<String, dynamic> data}) {
    return true;
  }

  //---------DELETE TRANSACTION----------------------//
  bool delete({required int txnId}) {
    return true;
  }
}
