import 'package:hive/hive.dart';

class DatabaseHelper {
  deleteBoxItem({required String key}) async {
    var box = await Hive.openBox('carts');
    box.delete(key);
  }

  addBoxItem({required String key, required dynamic value}) async {
    var box = await Hive.openBox('carts');
    box.put(key, value);
  }

  dynamic getBoxItem({required String key}) async {
    var box = await Hive.openBox('carts');
    return box.get(key, defaultValue: null);
  }
}
