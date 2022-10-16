import 'package:objectbox/objectbox.dart';

@Entity()
class AccountsModel {
  int id;

  @Index()
  int? parent;

  @Unique()
  String name;
  String type;
  bool hasChild;
  bool allowAlert;
  bool isLocked;

  @Index()
  bool? isActive;

  @Index()
  bool? isSystem;

  double? budget;
  bool? allowReceipt;
  bool? allowPayment;
  bool? allowTransfer;
  double? openingBalance;

  @Property(type: PropertyType.date)
  DateTime? createdOn;

  AccountsModel({
    this.id = 0,
    required this.parent,
    required this.name,
    this.isActive = true,
    this.isSystem = false,
    required this.type,
    required this.hasChild,
    this.allowAlert = false,
    this.isLocked = false,
    this.budget = 0.00,
    this.allowPayment = true,
    this.allowReceipt = true,
    this.allowTransfer = false,
    this.openingBalance = 0.00,
    required this.createdOn,
  });
}
