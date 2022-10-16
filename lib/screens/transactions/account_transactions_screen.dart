import 'package:animate_do/animate_do.dart';
import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:finsoft2/screens/account/account_transaction_controller.dart';
import 'package:finsoft2/screens/error_screen.dart';
import 'package:finsoft2/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountTransactionScreen extends ConsumerWidget {
  const AccountTransactionScreen({Key? key, required this.param})
      : super(key: key);

  final Map<String, dynamic> param;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AccountsModel account = param['account'] as AccountsModel;
    final transactions = ref.watch(accountTractionsProvider(account.id));

    return transactions.when(
      error: (error, stackTrace) => ErrorScreen(msg: error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
      data: (data) {
        return Scaffold(
          appBar: AppBar(title: Text(account.name)),
          floatingActionButton: TransactionButton(
            account: account,
            txnType: param['txnType'].toString().trim(),
          ),
          body: SafeArea(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return FadeInDown(
                  duration: Duration(milliseconds: (index + 1) * 100),
                  child: TransactionWidget(txn: data[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class TransactionButton extends StatelessWidget {
  const TransactionButton(
      {Key? key, required this.account, required this.txnType})
      : super(key: key);

  final AccountsModel account;
  final String txnType;

  @override
  Widget build(BuildContext context) {
    if (txnType == "PAYMENT") {
      return Draggable(
        feedback: Stack(
          children: [
            FloatingActionButton.extended(
              label: Text(
                "PAYMENT",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(Icons.add),
              onPressed: null,
            ),
          ],
        ),
        childWhenDragging: Container(),
        // onDragEnd: (details) => print(details.offset),
        child: SlideInRight(
          duration: const Duration(milliseconds: 500),
          child: Stack(
            children: [
              FloatingActionButton.extended(
                label: Text(
                  "PAYMENT",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, "/payment", arguments: account);
                },
              ),
            ],
          ),
        ),
      );
    }
    if (txnType == "RECEIPT") {
      return Draggable(
        feedback: Stack(
          children: [
            FloatingActionButton.extended(
              label: Text(
                "RECEIPT",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              icon: const Icon(Icons.add),
              onPressed: null,
            ),
          ],
        ),
        childWhenDragging: Container(),
        // onDragEnd: (details) => print(details.offset),
        child: SlideInRight(
          duration: const Duration(milliseconds: 500),
          child: Stack(
            children: [
              FloatingActionButton.extended(
                label: Text(
                  "RECEIPT",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, "/receipt", arguments: account);
                },
              ),
            ],
          ),
        ),
      );
    }

    return const Text("TRANSFER");
  }
}
