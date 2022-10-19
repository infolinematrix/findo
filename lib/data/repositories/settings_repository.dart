import 'package:findo/data/models/settings_model.dart';
import 'package:findo/data/source/objectstore.dart';
import 'package:objectbox/objectbox.dart';

class SettingsRepository {
  final settingBox = objBox!.store.box<SettingsModel>();

  getAll() async {
    QueryBuilder<SettingsModel> builder = settingBox.query();

    Query<SettingsModel> query = builder.build();
    List<SettingsModel> data = query.find().toList();

    query.close();
    return data;
  }
}
