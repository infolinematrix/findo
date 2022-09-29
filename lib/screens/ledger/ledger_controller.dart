import 'package:finsoft2/data/models/ledger_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/source/objectstore.dart';
import '../../objectbox.g.dart';

final ledgerBox = objBox!.store.box<LedgerModel>();

final ledgerProvider =
    StateNotifierProvider<LedgerState, AsyncValue<List<LedgerModel>>>((ref) {
  return LedgerState();
});

class LedgerState extends StateNotifier<AsyncValue<List<LedgerModel>>> {
  LedgerState() : super(const AsyncValue<List<LedgerModel>>.loading()) {
    getLedgers();
  }

  //---GET ALL
  getLedgers() {
    QueryBuilder<LedgerModel> builder = ledgerBox.query(
        LedgerModel_.isActive.equals(true) & LedgerModel_.name.notEquals(''))
      ..order(LedgerModel_.name, flags: Order.caseSensitive);

    Query<LedgerModel> query = builder.build();

    List<LedgerModel> data = query.find().toList();

    state = AsyncValue<List<LedgerModel>>.data(data);

    query.close();
  }

  //--CREATE
  Future<bool> create({required Map<String, dynamic> formData}) async {
    try {
      final data = LedgerModel(
        name: formData['name'].toString().trim(),
        isActive: formData['isActive'],
      );

      ledgerBox.put(data);
      objBox!.store.awaitAsyncSubmitted();

      getLedgers();
      return true;
    } catch (e) {
      return false;
    }
  }

  //--GET
  Future get({required int id}) async {
    try {
      final data = ledgerBox.get(id);
      return data;
    } catch (e) {
      return false;
    }
  }

  //--DELETE
  Future<bool> delete({required int id}) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }

  //--UPDATE
  Future<bool> update(
      {required int id, required Map<String, dynamic> formData}) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
