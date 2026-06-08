import 'package:expense_tracker/models/settings_model.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class AppNamePickerDialog extends StatelessWidget {
  final bool isDark;
  const AppNamePickerDialog({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    nameController.text = HiveService.getSettings().userName;
    return Dialog(
      child: SizedBox(
        height: 200.h,
        width: 400.w,
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Column(
            spacing: 10,
            children: [
              Shimmer.fromColors(
                baseColor: (isDark) ? Colors.white : Colors.black,
                highlightColor: Colors.blue,
                child: Text(
                  "Enter user name!",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                // initialValue: settingsModel.userName,
                controller: nameController,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 15,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty) {
                        SettingsModel settingsModel = HiveService.getSettings();
                        HiveService.saveSettings(
                          settingsModel.copyWith(userName: nameController.text.toString()),
                        );
                        context.pop();
                      }
                    },
                    child: Text("Save"),
                  ),
                  ElevatedButton(onPressed: () => context.pop(), child: Text("Close")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
