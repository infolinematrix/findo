import 'package:objectbox/objectbox.dart';

@Entity()
class ScrollModel {
  int? id;

  int? slno;

  ScrollModel({
    this.slno = 1,
  });
}
