<<<<<<< HEAD
import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/data/repositories/account_repository.dart';
import 'package:finsoft2/data/repositories/transaction_repository.dart';
import 'package:finsoft2/data/source/objectstore.dart';
import 'package:finsoft2/services/transaction_service.dart';
import 'package:finsoft2/utils/functions.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:objectbox/objectbox.dart';
=======
import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/services/transaction_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
>>>>>>> 3e88900f7094f933b75ddadb8baf31f97d3dcf08

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
<<<<<<< HEAD

  //--Payment transaction
  Future<bool> addPayment(
      {required int accountNo, required Map<String, dynamic> formData}) async {
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
            account: accountNo,
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
            account: accountNo,
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
      getTransactions(accountNo);

      EasyLoading.dismiss();
      return true;
    } catch (e) {
      return false;
    }
  }

  //--Payment transaction
  Future<bool> addReceipt(
      {required int accountNo, required Map<String, dynamic> formData}) async {
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
            account: accountNo,
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
            account: accountNo,
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
      getTransactions(accountNo);
      EasyLoading.dismiss();
      return true;
    } catch (e) {
      EasyLoading.dismiss();
      return false;
    }
  }

  //--Transfer Transaction
  Future<bool> addTransfer(
      {required int accountNo, required Map<String, dynamic> formData}) async {
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

      getTransactions(accountNo);
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
=======
>>>>>>> 3e88900f7094f933b75ddadb8baf31f97d3dcf08
}
