import 'package:objectbox/objectbox.dart';

@Entity()
class AccountsModel {
  int id;

  @Index()
  int parent;

  @Unique()
  String name;
  String type;
  bool hasChild;
  bool allowAlert;
  bool isLocked;

  @Index()
  bool isActive;

  @Index()
  bool isSystem;

  double? budget;
  bool? allowReceipt;
  bool? allowPayment;
  bool? allowTransfer;
  double? openingBalance;

  String description;

  @Property(type: PropertyType.date)
  DateTime? createdOn;

  AccountsModel({
    this.id = 0,
    required this.parent,
    required this.name,
    required this.type,
    required this.createdOn,
    this.description = '',
    this.isActive = true,
    this.isSystem = false,
    this.hasChild = false,
    this.allowAlert = false,
    this.isLocked = false,
    this.budget = 0.00,
    this.allowPayment = false,
    this.allowReceipt = false,
    this.allowTransfer = false,
    this.openingBalance = 0.00,
  });
}
