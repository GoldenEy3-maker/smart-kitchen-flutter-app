import "package:hive_ce/hive.dart";
import "package:path_provider/path_provider.dart";

class HiveInitializer {
  HiveInitializer();

  Future<String> init() async {
    final storagePath = await getApplicationDocumentsDirectory();
    Hive.init(storagePath.path);
    return storagePath.path;
  }
}
