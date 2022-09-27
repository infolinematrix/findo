import 'package:objectbox/objectbox.dart';
import 'accounts_model.dart';

@Entity()
class TransactionsModel {
  int id;

  double drAmount;
  double crAmount;
  String? description;
  String txnMode;
  String txnType;

  @Index()
  DateTime? txnDate;

  DateTime? createdOn = DateTime.now();

  final account = ToOne<AccountsModel>();

  TransactionsModel({
    this.id = 0,
    this.drAmount = 0.00,
    this.crAmount = 0.00,
    this.txnMode = 'Cash',
    this.txnType = 'DR',
    this.description,
    this.txnDate,
    this.createdOn,
  });
}
