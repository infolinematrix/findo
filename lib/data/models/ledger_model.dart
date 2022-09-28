import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class LedgerModel {
  int id;

  @Unique()
  String name;
  bool? isSystem;

  @Index()
  bool? isActive;

  @Index()
  String ledgerType;

  @Index()
  bool? hasChild;

  double openingBalance;

  DateTime? createdOn = DateTime.now();

  @Backlink()
  final accounts = ToMany<AccountsModel>();

  LedgerModel({
    this.id = 0,
    required this.name,
    required this.ledgerType,
    this.openingBalance = 0.0,
    this.isSystem = false,
    this.isActive = true,
    this.hasChild = false,
  });
}
