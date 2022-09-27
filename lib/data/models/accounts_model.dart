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
  bool? isTemporary;
  double? budget;

  DateTime? createdOn = DateTime.now();

  @Backlink()
  final transactions = ToMany<TransactionsModel>();

  AccountsModel(
      {this.id = 0,
      required this.name,
      this.isActive = true,
      this.isSystem = false,
      this.isTemporary = false,
      this.budget = 0.00});
}
