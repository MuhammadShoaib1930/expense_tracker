import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../cubits/theme/theme_cubit.dart';
import '../models/settings_model.dart';
import '../services/app_pdf_services.dart';
import '../services/app_share_services.dart';
import '../services/hive_service.dart';
import 'about_app.dart';
import 'app_image_picker.dart';
import 'app_name_picker_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.r),
          bottomRight: Radius.circular(50.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 15,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  SizedBox(
                    width: 100.r,
                    height: 100.r,
                    child: InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AppImagePicker(isDark: isDark),
                      ),

                      child: ValueListenableBuilder(
                        valueListenable: Hive.box<SettingsModel>(
                          HiveService.settingBoxName,
                        ).listenable(),
                        builder: (context, Box<SettingsModel> box, child) {
                          final settings = box.get(HiveService.settingBoxName);

                          final String path = settings?.profileImagePath ?? '';

                          return CircleAvatar(
                            radius: 40,
                            backgroundImage: path.isNotEmpty ? FileImage(File(path)) : null,
                            backgroundColor: Colors.blue,

                            child: path.isEmpty
                                ? const Icon(Icons.person, size: 40, color: Colors.white)
                                : null,
                          );
                        },
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: (isDark) ? Colors.white : Colors.black,
                    highlightColor: Colors.blue,
                    child: InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AppNamePickerDialog(isDark: isDark),
                      ),
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box<SettingsModel>(
                          HiveService.settingBoxName,
                        ).listenable(),
                        builder: (context, Box<SettingsModel> box, child) {
                          final settings = box.get(HiveService.settingBoxName);
                          return Text(
                            settings?.userName ?? "Guest",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 300.w,
              child: ElevatedButton.icon(
                onPressed: () {
                  SettingsModel settingsModel = HiveService.getSettings();
                  HiveService.saveSettings(settingsModel.copyWith(isDark: !settingsModel.isDark));
                  context.read<ThemeCubit>().themeTogle();
                },
                label: Text((isDark) ? "Light" : "Dark", style: TextStyle(fontSize: 18)),
                icon: Icon((isDark) ? Icons.sunny : Icons.dark_mode),
              ),
            ),
            SizedBox(
              width: 300.w,
              child: ElevatedButton.icon(
                onPressed: () {
                  AppPdfServices().createExpensePdf(HiveService.expenseBox().values.toList());
                },
                label: Text("Download expanses report as pdf! ", style: TextStyle(fontSize: 18)),
                icon: Icon(Icons.file_copy),
              ),
            ),
            SizedBox(
              width: 300.w,
              child: ElevatedButton.icon(
                onPressed: () {
                  AppPdfServices().createExpensePdf(HiveService.expenseBox().values.toList());
                },
                label: Text("Download expanses report as Excel! ", style: TextStyle(fontSize: 18)),
                icon: Icon(Icons.file_copy),
              ),
            ),
            SizedBox(
              width: 300.w,
              child: ElevatedButton.icon(
                onPressed: () {
                  AppShareServices().shareExcel();
                },
                label: Text("Shear expanses report as Excel! ", style: TextStyle(fontSize: 18)),
                icon: Icon(Icons.share),
              ),
            ),
            SizedBox(
              width: 300.w,
              child: ElevatedButton.icon(
                onPressed: () {
                  AppShareServices().sharePdf();
                },
                label: Text("Shear expanses report as pdf! ", style: TextStyle(fontSize: 18)),
                icon: Icon(Icons.share),
              ),
            ),

            SizedBox(
              width: 300.w,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AboutApp(isDark: isDark),
                  );
                },
                label: Text("About", style: TextStyle(fontSize: 18)),
                icon: Icon(Icons.info),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
