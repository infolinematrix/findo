import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/data/repositories/account_repository.dart';
import 'package:finsoft2/objectbox.g.dart';
import 'package:finsoft2/utils/functions.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/accounts_model.dart';
import '../../data/source/objectstore.dart';

//--Load Bank accounts
final banksProvider = FutureProvider.autoDispose((ref) async {
  final List<AccountsModel> banks =
      await AccountRepository().listByLedger(ledgerId: 1);

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

//--SCROLL START
final scrollProvider =
    StateNotifierProvider.autoDispose<ScrollState, int>((ref) {
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
  final transactionsBox = objBox!.store.box<TransactionsModel>();
  TransactionsState(this.ref, this.account)
      : super(const AsyncValue<List<TransactionsModel>>.loading());

  //--Save transaction
  Future<bool> addPayment({required Map<String, dynamic> formData}) async {
    try {
      // EasyLoading.show(status: 'Saving...');

      var txnDateTime = convertDateToLocal(formData['txnDate'].toString());

      objBox!.store.runInTransaction(TxMode.write, () {
        if (formData['txnMode'] == 'BANK') {
          //--Get Bank account
          AccountsModel? bank =
              AccountRepository().accountBox.get(formData['bank_account']);

          //--DEBIT
          final dataDr = TransactionsModel(
            account: account,
            description: formData['description'].toString().trim(),
            txnDate: txnDateTime,
            createdOn: DateTime.now().toUtc().toLocal(),
            txnType: "DR",
            amount: double.parse(formData['amount'].toString()).toDouble(),
            narration: "To, ${bank!.name}",
          );
          objBox!.store.box<TransactionsModel>().putAsync(dataDr);

          //--CREDIT
          final dataCr = TransactionsModel(
            account: formData['bank_account'],
            description: formData['description'].toString().trim(),
            txnDate: txnDateTime,
            createdOn: DateTime.now().toUtc().toLocal(),
            txnType: "CR",
            amount: double.parse(formData['amount'].toString()).toDouble(),
            narration: 'By ${formData['account_to']}',
          );
          objBox!.store.box<TransactionsModel>().putAsync(dataCr);
        } else {
          //--DEBIT
          final dataDr = TransactionsModel(
            account: account,
            description: formData['description'].toString().trim(),
            txnDate: txnDateTime,
            createdOn: DateTime.now().toUtc().toLocal(),
            txnType: "DR",
            amount: double.parse(formData['amount'].toString()).toDouble(),
            narration: "To, Cash",
          );
          objBox!.store.box<TransactionsModel>().putAsync(dataDr);

          //--CREDIT
          final dataCr = TransactionsModel(
            account: 0,
            description: formData['description'].toString().trim(),
            txnDate: txnDateTime,
            createdOn: DateTime.now().toUtc().toLocal(),
            txnType: "CR",
            amount: double.parse(formData['amount'].toString()).toDouble(),
            narration: 'By ${formData['to_account']}',
          );
          objBox!.store.box<TransactionsModel>().putAsync(dataCr);
        }
      });

      objBox!.store.awaitAsyncSubmitted();
      EasyLoading.dismiss();
      return true;
    } catch (e) {
      return false;
    }
  }
}
//--TRANSACTION END