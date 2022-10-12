import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/services/transaction_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountTractionsProvider = StateNotifierProvider.family.autoDispose<
    AccountTransactionsNotifier,
    AsyncValue<List<TransactionsModel>>,
    int>((ref, accountNo) {
  return AccountTransactionsNotifier(accountNo);
});

class AccountTransactionsNotifier
    extends StateNotifier<AsyncValue<List<TransactionsModel>>> {
  AccountTransactionsNotifier(int accountNo)
      : super(const AsyncValue<List<TransactionsModel>>.loading()) {
    getTransactions(accountNo);
  }

  getTransactions(int accountNo) async {
    final data = TransactionService.instance.getAll(accountNo);
    state = AsyncValue<List<TransactionsModel>>.data(data);
  }
}
