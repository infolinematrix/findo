import 'package:objectbox/objectbox.dart';

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
  @Property(type: PropertyType.date)
  DateTime? txnDate;

  @Index()
  int account;

  String? narration;

  @Property(type: PropertyType.date)
  DateTime? createdOn = DateTime.now();

  TransactionsModel({
    this.id = 0,
    this.account = 0,
    this.scrollNo = 0,
    this.amount = 0.00,
    this.txnType = 'DR',
    this.description,
    this.txnDate,
    this.createdOn,
    this.narration,
  });
}
