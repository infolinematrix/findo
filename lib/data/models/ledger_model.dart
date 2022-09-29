import 'package:finsoft2/data/models/accounts_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class LedgerModel {
  int id;

  @Unique()
  String name;

  @Index()
  bool? isActive;

  DateTime? createdOn = DateTime.now();

  @Backlink()
  final accounts = ToMany<AccountsModel>();

  LedgerModel({
    this.id = 0,
    required this.name,
    this.isActive = true,
  });
}
