import 'package:finsoft2/data/models/ledger_model.dart';

import '../data/source/objectstore.dart';

class LedgerService {
  LedgerService._();
  static final instance = LedgerService._();

  final ledgerBox = objBox!.store.box<LedgerModel>();
}
