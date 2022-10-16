import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/data/repositories/account_repository.dart';
import 'package:finsoft2/data/repositories/transaction_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/accounts_model.dart';
import '../../data/source/objectstore.dart';

//--Load Bank accounts
final banksProvider = FutureProvider.autoDispose((ref) async {
  final List<AccountsModel> banks =
      await AccountRepository().listByLedger(parent: 1);

  return banks;
});

//--ALLOW SAVE
final allowSaveProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
});

//--IS CASH/BANK
final txnModeProvider = StateProvider.autoDispose<String>((ref) {
  return 'CASH';
});

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
  final transactionsBox = objBox!.store.box<TransactionsModel>();
  TransactionsState(this.ref, this.account)
      : super(const AsyncValue<List<TransactionsModel>>.loading()) {
    getAll(account);
  }

  //--Recent 100 entries
  getAll(account) async {
    final data =
        await TransactionRepository().accountTransactions(accointId: account);
    state = AsyncValue<List<TransactionsModel>>.data(data);
  }
}
//--TRANSACTION END