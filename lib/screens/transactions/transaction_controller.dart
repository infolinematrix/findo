import 'package:finsoft2/constants/constants.dart';
import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/services/account_service.dart';
import 'package:finsoft2/services/transaction_service.dart';
import 'package:finsoft2/utils/functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/source/objectstore.dart';
import '../../objectbox.g.dart';

class InitTransactionModel {
  final List<AccountsModel>? accounts;
  final List<String>? txnModes;
  InitTransactionModel({required this.accounts, required this.txnModes});
}

final inttTransactionProvider =
    FutureProvider.autoDispose<InitTransactionModel>((ref) async {
  final allAccounts = await ref.watch(getAccounts);
  final txnMode = await ref.watch(txnModes);

  return InitTransactionModel(
    accounts: allAccounts,
    txnModes: txnMode,
  );
});

// -- GET ACCOUNT
final getAccount = Provider.family.autoDispose((ref, int accountId) {
  final accountsData = AccountService.instance.getAccount(accountId: accountId);
  return accountsData;
});
// -- GET Accounts
final getAccounts = Provider.autoDispose((ref) async {
  try {
    final accountsData = objBox!.store.box<AccountsModel>();
    final qBuilder = accountsData.query(AccountsModel_.isActive.equals(true) &
        AccountsModel_.name.notEquals(''));

    qBuilder.order(AccountsModel_.name, flags: Order.caseSensitive);

    List<AccountsModel> data = qBuilder.build().find();

    return data;
  } catch (e) {
    rethrow;
  }
});

final txnModes = Provider.autoDispose((ref) async {
  return txnMode;
});

//-------------------------------
final transactionsProvider = StateNotifierProvider.autoDispose
    .family<TransactionsState, AsyncValue<List<TransactionsModel>>, int>(
        name: 'TRANSACTION-PROVIDER', (ref, accountId) {
  return TransactionsState(ref, accountId);
});

//-------------------------------
class TransactionsState
    extends StateNotifier<AsyncValue<List<TransactionsModel>>> {
  final Ref ref;
  final int accountId;
  final transactions = objBox!.store.box<TransactionsModel>();

  TransactionsState(this.ref, this.accountId)
      : super(const AsyncValue<List<TransactionsModel>>.loading()) {
    getAccountTransactions();
  }

  getAccountTransactions() async {
    QueryBuilder<TransactionsModel> builder = transactions
        .query(TransactionsModel_.account.equals(accountId))
      ..order(TransactionsModel_.txnDate, flags: Order.descending);

    Query<TransactionsModel> query = builder.build()
      ..limit = 25
      ..offset = 0;

    List<TransactionsModel> data = query.find().toList();
    state = AsyncValue<List<TransactionsModel>>.data(data);

    query.close();
  }

//--Save transaction
  Future<bool> addEntry({required Map<String, dynamic> formData}) async {
    try {
      String txnType = 'DR';

      if (formData['txnType'] == 'RECEIPT') {
        txnType = 'CR';
      } else if (formData['txnType'] == 'PAYMENT') {
        txnType = 'DR';
      } else if (formData['txnType'] == 'TRANSFER') {
        txnType = 'TRFR';
      }

      var txnDateTime = convertDateToLocal(formData['date'].toString());
      final data = TransactionsModel(
        description: formData['description'],
        txnDate: txnDateTime,
        txnMode: formData['mode'],
        txnType: txnType,
        crAmount: formData['txnType'] == 'RECEIPT'
            ? double.parse(formData['amount'].toString()).toDouble()
            : 0.00,
        drAmount: formData['txnType'] == 'PAYMENT'
            ? double.parse(formData['amount'].toString()).toDouble()
            : 0.00,
      );
      final account =
          objBox!.store.box<AccountsModel>().get(formData['account']);
      data.account.target = account;

      transactions.put(data);
      objBox!.store.awaitAsyncSubmitted();

      getAccountTransactions();

      return true;
    } catch (e) {
      rethrow;
    }
  }

//--Delete Transaction
  Future<bool> deleteEntry({required int id}) async {
    try {
      transactions.remove(id);
      objBox!.store.awaitAsyncSubmitted();
      getAccountTransactions();
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

final transactionsFutureProvider = FutureProvider.autoDispose
    .family((ref, Map<String, dynamic> parameters) async {
  List<TransactionsModel> transactions = TransactionService.instance
      .getAllWithDateRange(
          startDate: parameters['startDate'], endtDate: parameters['endDate']);

  return transactions;
});
