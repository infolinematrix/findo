import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/data/repositories/account_repository.dart';
import 'package:finsoft2/data/repositories/transaction_repository.dart';
import 'package:finsoft2/objectbox.g.dart';
import 'package:finsoft2/utils/functions.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/accounts_model.dart';
import '../../data/source/objectstore.dart';

//--Load Bank accounts
final banksProvider = FutureProvider.autoDispose((ref) async {
  final List<AccountsModel> banks =
      await AccountRepository().listByLedger(ledgerId: 2);

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

  //--Payment transaction
  Future<bool> addPayment({required Map<String, dynamic> formData}) async {
    try {
      var scrollNo = await TransactionRepository().getScroll();

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
            scrollNo: scrollNo + 1,
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
            scrollNo: scrollNo + 1,
          );
          objBox!.store.box<TransactionsModel>().putAsync(dataCr);
        } else {
          //--DEBIT
          final dataDr = TransactionsModel(
            txnMode: "PAYMENT",
            account: account,
            description: formData['description'].toString().trim(),
            txnDate: txnDateTime,
            createdOn: DateTime.now().toUtc().toLocal(),
            txnType: "DR",
            amount: double.parse(formData['amount'].toString()).toDouble(),
            narration: "To Cash",
            scrollNo: scrollNo + 1,
          );
          objBox!.store.box<TransactionsModel>().putAsync(dataDr);

          //--CREDIT
          final dataCr = TransactionsModel(
            account: 1, //--Cash Account
            description: formData['description'].toString().trim(),
            txnDate: txnDateTime,
            createdOn: DateTime.now().toUtc().toLocal(),
            txnType: "CR",
            amount: double.parse(formData['amount'].toString()).toDouble(),
            narration: 'By ${formData['to_account']}',
            scrollNo: scrollNo + 1,
          );
          objBox!.store.box<TransactionsModel>().putAsync(dataCr);
        }
      });

      //--UPDATE SCROLL NO
      await TransactionRepository().updateScroll();

      objBox!.store.awaitAsyncSubmitted();
      getAll(account);

      EasyLoading.dismiss();
      return true;
    } catch (e) {
      return false;
    }
  }

  //--Payment transaction
  Future<bool> addReceipt({required Map<String, dynamic> formData}) async {
    try {
      var scrollNo = await TransactionRepository().getScroll();
      var txnDateTime = convertDateToLocal(formData['txnDate'].toString());

      objBox!.store.runInTransaction(TxMode.write, () {
        if (formData['txnMode'] == 'BANK') {
          //--Get Bank account
          AccountsModel? bank =
              AccountRepository().accountBox.get(formData['bank_account']);

          //--CREDIT
          final dataDr = TransactionsModel(
            account: account,
            description: formData['description'].toString().trim(),
            txnDate: txnDateTime,
            createdOn: DateTime.now().toUtc().toLocal(),
            txnType: "CR",
            amount: double.parse(formData['amount'].toString()).toDouble(),
            narration: "By ${bank!.name}",
            scrollNo: scrollNo + 1,
          );
          objBox!.store.box<TransactionsModel>().putAsync(dataDr);

          //--DEBIT
          final dataCr = TransactionsModel(
            account: formData['bank_account'],
            description: formData['description'].toString().trim(),
            txnDate: txnDateTime,
            createdOn: DateTime.now().toUtc().toLocal(),
            txnType: "DR",
            amount: double.parse(formData['amount'].toString()).toDouble(),
            narration: 'To ${formData['account_to']}',
            scrollNo: scrollNo + 1,
          );
          objBox!.store.box<TransactionsModel>().putAsync(dataCr);
        } else {
          //--CREDIT
          final dataDr = TransactionsModel(
            txnMode: "RECEIPT",
            account: account,
            description: formData['description'].toString().trim(),
            txnDate: txnDateTime,
            createdOn: DateTime.now().toUtc().toLocal(),
            txnType: "CR",
            amount: double.parse(formData['amount'].toString()).toDouble(),
            narration: "By Cash",
            scrollNo: scrollNo + 1,
          );
          objBox!.store.box<TransactionsModel>().putAsync(dataDr);

          //--DEBIT
          final dataCr = TransactionsModel(
            account: 1, //--Cash Account
            description: formData['description'].toString().trim(),
            txnDate: txnDateTime,
            createdOn: DateTime.now().toUtc().toLocal(),
            txnType: "DR",
            amount: double.parse(formData['amount'].toString()).toDouble(),
            narration: 'To ${formData['to_account']}',
            scrollNo: scrollNo + 1,
          );
          objBox!.store.box<TransactionsModel>().putAsync(dataCr);
        }
      });

      //--UPDATE SCROLL NO
      await TransactionRepository().updateScroll();

      objBox!.store.awaitAsyncSubmitted();
      getAll(account);
      EasyLoading.dismiss();
      return true;
    } catch (e) {
      EasyLoading.dismiss();
      return false;
    }
  }

  //--Transfer Transaction
  Future<bool> addTransfer({required Map<String, dynamic> formData}) async {
    var scrollNo = await TransactionRepository().getScroll();
    var txnDateTime = convertDateToLocal(formData['txnDate'].toString());
    try {
      //--Cash Deposit to Bank --
      if (formData['txnType'] == 1) {
        /**
         * DEBIT
         */
        final dataDr = TransactionsModel(
          txnMode: "TRANSFER",
          account:
              int.parse(formData['bank'].toString()).toInt(), //--Bank Account
          description: formData['description'].toString().trim(),
          txnDate: txnDateTime,
          createdOn: txnDateTime,
          txnType: "DR",
          amount: double.parse(formData['amount'].toString()).toDouble(),
          narration: 'By Cash',
          scrollNo: scrollNo + 1,
        );
        objBox!.store.box<TransactionsModel>().putAsync(dataDr);

        /**
       * CREDIT
       */
        final dataCr = TransactionsModel(
          txnMode: "TRANSFER",
          account: 1, //--Cash Account
          description: formData['description'].toString().trim(),
          txnDate: txnDateTime,
          createdOn: DateTime.now().toUtc().toLocal(),
          txnType: "CR",
          amount: double.parse(formData['amount'].toString()).toDouble(),
          narration: "To Bank",
          scrollNo: scrollNo + 1,
        );
        objBox!.store.box<TransactionsModel>().putAsync(dataCr);
      } else {
        /**
         * DEBIT
         */
        final dataDr = TransactionsModel(
          txnMode: "TRANSFER",
          account: 1, //--Cash Account
          description: formData['description'].toString().trim(),
          txnDate: txnDateTime,
          createdOn: DateTime.now().toUtc().toLocal(),
          txnType: "DR",
          amount: double.parse(formData['amount'].toString()).toDouble(),
          narration: "By ${formData['bank']}",
          scrollNo: scrollNo + 1,
        );
        objBox!.store.box<TransactionsModel>().putAsync(dataDr);

        /**
       * CREDIT
       */
        final dataCr = TransactionsModel(
          txnMode: "TRANSFER",
          account:
              int.parse(formData['bank'].toString()).toInt(), //--Bank Account
          description: formData['description'].toString().trim(),
          txnDate: txnDateTime,
          createdOn: DateTime.now().toUtc().toLocal(),
          txnType: "CR",
          amount: double.parse(formData['amount'].toString()).toDouble(),
          narration: 'To Cash',
          scrollNo: scrollNo + 1,
        );
        objBox!.store.box<TransactionsModel>().putAsync(dataCr);
      }

      //--UPDATE SCROLL NO
      await TransactionRepository().updateScroll();

      objBox!.store.awaitAsyncSubmitted();

      getAll(account);
      EasyLoading.dismiss();
      return true;
    } catch (e) {
      EasyLoading.dismiss();
      return false;
    }
  }

  //--Delete Transaction
  Future<bool> delete({required int scrollNo}) async {
    return true;
  }
}
//--TRANSACTION END