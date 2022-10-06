import 'package:finsoft2/data/models/ledger_model.dart';
import 'package:finsoft2/data/source/objectstore.dart';
import 'package:finsoft2/objectbox.g.dart';

class LederRepository {
  final ledgerBox = objBox!.store.box<LedgerModel>();

  //--List
  Future list() async {
    QueryBuilder<LedgerModel> builder = ledgerBox.query(
        LedgerModel_.isActive.equals(true) & LedgerModel_.name.notEquals(''))
      ..order(LedgerModel_.name, flags: Order.caseSensitive);

    Query<LedgerModel> query = builder.build();
    List<LedgerModel> data = query.find().toList();

    query.close();
    return data;
  }

  //--Get
  Future get({required id}) async {}

  //--Create
  Future create() async {}

  //--Update
  Future update({required id, required Map<String, dynamic> formData}) async {}

  //--Delete
  Future delete({required id}) async {}
}
