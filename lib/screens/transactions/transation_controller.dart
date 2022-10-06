import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/accounts_model.dart';
import '../../data/source/objectstore.dart';
import '../../utils/functions.dart';

//--IS CASH/BANK

final txnModeProvider = StateProvider.autoDispose<String>((ref) {
  return 'CASH';
});

//--SCROLL START
final scrollProvider = StateNotifierProvider<ScrollState, int>((ref) {
  return ScrollState();
});

class ScrollState extends StateNotifier<int> {
  ScrollState() : super(0);
}
//--SCROLL END

//--TRANSATION START
final transactionProvider = StateNotifierProvider.family
    .autoDispose<TransactionsState, AsyncValue<List<TransactionsModel>>, int>(
        name: 'TRANSACTION-PROVIDER', (ref, account) {
  return TransactionsState(ref, account);
});

class TransactionsState
    extends StateNotifier<AsyncValue<List<TransactionsModel>>> {
  final Ref ref;
  final int account;
  final transactions = objBox!.store.box<TransactionsModel>();
  TransactionsState(this.ref, this.account)
      : super(const AsyncValue<List<TransactionsModel>>.loading());

  //--Save transaction
  Future<bool> addEntry({required Map<String, dynamic> formData}) async {
    try {
      var txnDateTime = convertDateToLocal(formData['date'].toString());

      /**
       * THIS IS DEBIT PART
       */

      final data1 = TransactionsModel(
        description: formData['description'],
        txnDate: txnDateTime,
        txnType: "DR",
        amount: double.parse(formData['amount'].toString()).toDouble(),
      );

      final account1 =
          objBox!.store.box<AccountsModel>().get(formData['account']);

      data1.account.target = account1;
      transactions.put(data1);

      /**
       * THIS IS CREDIT PART
       */

      final data2 = TransactionsModel(
        description: formData['description'],
        txnDate: txnDateTime,
        txnType: "DR",
        amount: double.parse(formData['amount'].toString()).toDouble(),
      );

      // final account2 =
      //     objBox!.store.box<AccountsModel>().get(formData['account']);

      // data2.account.target = account2;
      transactions.put(data2);

      objBox!.store.awaitAsyncSubmitted();

      // getAccountTransactions();

      return true;
    } catch (e) {
      rethrow;
    }
  }
}
//--TRANSACTION END