import 'package:hive_flutter/hive_flutter.dart';

import '../models/expanses_model.dart';
import '../models/settings_model.dart';

class HiveService {
  static const String settingBoxName = "settingsBox";
  static const String expenseBoxName = "expenseBox";

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(SettingsModelAdapter());
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ExpansesModelAdapter());
    }

    await Hive.openBox<SettingsModel>(settingBoxName);
    await Hive.openBox<ExpansesModel>(expenseBoxName);
  }

  static Box<SettingsModel> settingBox() {
    return Hive.box<SettingsModel>(settingBoxName);
  }

  static Box<ExpansesModel> expenseBox() {
    return Hive.box<ExpansesModel>(expenseBoxName);
  }

  static Future<void> saveSettings(SettingsModel setting) async {
    await settingBox().put(settingBoxName, setting);
  }

  static SettingsModel getSettings() {
    SettingsModel settingsModel = SettingsModel(
      isDark: false,
      userName: "Guest",
      profileImagePath: "",
      token: 3,
    );
    return settingBox().get(settingBoxName) ?? settingsModel;
  }
}
