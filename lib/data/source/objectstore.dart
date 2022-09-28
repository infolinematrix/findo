import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';

ObjectStore? objBox;
Admin? admin;

class ObjectStore {
  /// The Store of this app.
  late final Store store;

  ObjectStore._create(this.store) {
    // Add any additional setup code, e.g. build queries.
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectStore> create() async {
    final docsDir = await getApplicationDocumentsDirectory();

    final store =
        await openStore(directory: p.join(docsDir.path, "obx-finsdo"));

    //--Delete Database with all object
    // store.close();

    return ObjectStore._create(store);
  }
}
