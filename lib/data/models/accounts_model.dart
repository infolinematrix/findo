import 'package:finsoft2/data/models/ledger_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class AccountsModel {
  int id;

  @Unique()
  String name;

  @Index()
  bool? isActive;
  bool? isSystem;
  bool? isVisible;
  double? budget;
  bool? allowReceipt;
  bool? allowPayment;
  bool? allowTransfer;
  double? openingBalance;

  @Property(type: PropertyType.date)
  DateTime? createdOn;

  // @Backlink()
  // final transactions = ToMany<TransactionsModel>();

  final ledger = ToOne<LedgerModel>();

  AccountsModel(
      {this.id = 0,
      required this.name,
      this.isActive = true,
      this.isSystem = false,
      this.isVisible = true,
      this.allowPayment = true,
      this.allowReceipt = true,
      this.allowTransfer = false,
      this.openingBalance = 0.00,
      this.createdOn,
      this.budget = 0.00});
}
