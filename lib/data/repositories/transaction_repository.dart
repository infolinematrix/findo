import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/models/scroll_model.dart';
import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/data/source/objectstore.dart';

import '../../objectbox.g.dart';

class TransactionRepository {
  final accountBox = objBox!.store.box<AccountsModel>();
  final transactionBox = objBox!.store.box<TransactionsModel>();
  final scrollBox = objBox!.store.box<ScrollModel>();

  //--List
  Future<List<TransactionsModel>> accountTransactions(
      {required int accointId}) async {
    QueryBuilder<TransactionsModel> builder = transactionBox
        .query(TransactionsModel_.account.equals(accointId))
      ..order(TransactionsModel_.txnDate, flags: Order.descending);

    Query<TransactionsModel> query = builder.build();
    List<TransactionsModel> data = query.find().toList();

    query.close();
    return data;
  }

  //--Get Scroll
  Future<int> getScroll() async {
    try {
      var scroll = scrollBox.get(1);

      if (scroll != null) {
        return scroll.slno!;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  //--Update Scroll
  Future updateScroll() async {
    var scroll = scrollBox.get(1);

    if (scroll == null) {
      var newNo = ScrollModel(slno: 1);
      scrollBox.put(newNo);
    } else {
      scroll.slno = scroll.slno! + 1;
      scrollBox.put(scroll);
    }
  }
}
