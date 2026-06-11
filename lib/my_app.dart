import 'package:expense_tracker/models/settings_model.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/routes/route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      child: ValueListenableBuilder(
        valueListenable: Hive.box<SettingsModel>(
          HiveService.settingBoxName,
        ).listenable(keys: [HiveService.settingBoxName]),
        builder: (context, Box<SettingsModel> box, child) {
          SettingsModel settingsModel = box.get(HiveService.settingBoxName)??HiveService.getSettings();
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,

            routerConfig: route,
            theme: (settingsModel.isDark) ? ThemeData.dark() : ThemeData.light(),
          );
        },
      ),
    );
  }
}
