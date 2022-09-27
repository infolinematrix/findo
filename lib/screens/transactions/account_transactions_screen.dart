import 'package:animate_do/animate_do.dart';
import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:finsoft2/theme/colors.dart';
import 'package:finsoft2/widgets/no_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../utils/index.dart';
import '../../widgets/index.dart';
import '../error_screen.dart';
import '../home/home_controller.dart';
import '../loading.dart';
import 'transaction_controller.dart';

class AccountTransactions extends ConsumerWidget {
  const AccountTransactions({Key? key, required this.account})
      : super(key: key);
  final AccountsModel account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txns = ref.watch(transactionsProvider(account.id));

    return txns.when(
      error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
      loading: () => const Center(
        child: Loading(),
      ),
      data: (data) {
        return Scaffold(
          appBar: AppBar(
            title: Text(account.name),
            actions: const [],
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 1.0,
            backgroundColor: const Color(0xFFE57373),
            onPressed: () {
              Navigator.pushNamed(context, '/payment_action',
                  arguments: account);
            },
            child: Icon(
              Icons.add,
              size: 28.0.sp,
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          body: SafeArea(
            child: data.isEmpty
                ? const Center(
                    child: NoDataScreen(),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InfoBox(
                        text: Text(
                          "Transactions",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        color: Colors.transparent,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            TransactionsModel txn = data[index];

                            double amount = 0.00;
                            String txnType = '';

                            if (txn.txnType == 'DR') {
                              amount = txn.drAmount;
                              txnType = 'Payment';
                            } else if (txn.txnType == 'CR') {
                              amount = txn.crAmount;
                              txnType = 'Receipt';
                            } else {
                              //--TRANSFER
                              txnType = 'Transfer';
                            }

                            return Container(
                              margin:
                                  EdgeInsets.only(left: 8.0.sp, right: 8.0.sp),
                              child: BounceInDown(
                                duration:
                                    Duration(milliseconds: (index + 1) * 100),
                                child: Slidable(
                                  key: ValueKey(index),
                                  endActionPane: ActionPane(
                                    extentRatio: .20.sp,
                                    dragDismissible: true,
                                    motion: const ScrollMotion(),
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          UIHelper.horizontalSpaceMedium(),
                                          Container(
                                            height: 50.0.sp,
                                            margin:
                                                EdgeInsets.only(bottom: 8.0.sp),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8.sp),
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.sp,
                                                vertical: 8.sp),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () async {
                                                AlertAction? action =
                                                    await confirmDialog(context,
                                                        "Are you sure? \nOnce delete the it can't be recover.");

                                                if (action == AlertAction.ok) {
                                                  ref
                                                      .read(
                                                          transactionsProvider(
                                                                  account.id)
                                                              .notifier)
                                                      .deleteEntry(id: txn.id)
                                                      .then((value) => {
                                                            if (value == true)
                                                              {
                                                                //--Update Home Data
                                                                ref
                                                                    .watch(homeDataProvider
                                                                        .notifier)
                                                                    .loadData(),
                                                                showToast(
                                                                    msg:
                                                                        'Data deleted permanently')
                                                              }
                                                          });
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  child: TransactionItem(
                                    account: account.name,
                                    amount: amount,
                                    txnDate: txn.txnDate,
                                    txnType: txnType,
                                    txnDrCr: txn.txnType,
                                    txnMode: txn.txnMode,
                                    description: txn.description,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}

Container accountItems(String description, double amount, String dateString,
        String type, String txnType,
        {Color oddColour = Colors.white}) =>
    Container(
      padding: EdgeInsets.only(
          top: 12.0.sp, bottom: 12.0.sp, left: 8.0.sp, right: 16.0.sp),
      margin: EdgeInsets.only(top: 8.0.sp, left: 16.0.sp, right: 16.0.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(strToShortDate(dateString),
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold)),
              Text("${txnType == 'DR' ? '-' : '+'} ${formatCurrency(amount)}",
                  style: TextStyle(
                      fontSize: 15.0.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))
            ],
          ),
          const SizedBox(
            height: 4.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(description, style: const TextStyle()),
              Text(type,
                  style: const TextStyle(
                      color: AppColors.primaryGreyText, fontSize: 14.0))
            ],
          ),
        ],
      ),
    );
