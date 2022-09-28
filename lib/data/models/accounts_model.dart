import 'package:finsoft2/data/models/ledger_model.dart';
import 'package:finsoft2/data/models/transactions_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class AccountsModel {
  int id;

  @Unique()
  String name;

  @Index()
  bool? isActive;
  bool? isSystem;
  double? budget;

  DateTime? createdOn = DateTime.now();

  @Backlink()
  final transactions = ToMany<TransactionsModel>();

  final ledger = ToOne<LedgerModel>();

  AccountsModel(
      {this.id = 0,
      required this.name,
      this.isActive = true,
      this.isSystem = false,
      this.budget = 0.00});
}
