import 'package:expense_tracker/models/expanses_model.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  HiveService._();
  static final HiveService instance = HiveService._();
  final String boxName = "expanses";

  late Box<ExpansesModel> box;
  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ExpansesModelAdapter());
    await Hive.openBox<ExpansesModel>(boxName);

    box = Hive.box<ExpansesModel>(boxName);
  }

  Future<void> store(ExpansesModel data) async {
    await box.put(data.id, data);
  }

  List<ExpansesModel> get() {
    return box.values.toList();
  }

  Future<void> update(ExpansesModel expanses) async {
    if (box.containsKey(expanses.id)) {}
    await box.put(expanses.id, expanses);
    for (var item in box.keys.toList()) {
      print(item);
    }
  }

  Future<void> delete(ExpansesModel expanses) async {
    await box.delete(expanses.id);
  }

  Future<void> deleteAll() async {
    await box.clear();
  }
}
