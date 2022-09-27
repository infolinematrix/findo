import 'package:objectbox/objectbox.dart';

@Entity()
class SettingsModel {
  int id;

  @Index()
  String key;
  String value;

  SettingsModel({this.id = 0, required this.key, required this.value});
}
