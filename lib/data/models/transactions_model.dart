import 'package:objectbox/objectbox.dart';
import 'accounts_model.dart';

@Entity()
class TransactionsModel {
  int id;

  double amount;
  String? description;

  @Index()
  int scrollNo;

  @Index()
  String txnType;

  @Index()
  DateTime? txnDate;

  DateTime? createdOn = DateTime.now();

  final account = ToOne<AccountsModel>();

  TransactionsModel({
    this.id = 0,
    this.scrollNo = 0,
    this.amount = 0.00,
    this.txnType = 'DR',
    this.description,
    this.txnDate,
    this.createdOn,
  });
}
