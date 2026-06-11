import 'dart:io' show File;

import 'package:excel/excel.dart' show Excel, TextCellValue, DoubleCellValue;
import 'package:expense_tracker/models/expanses_model.dart' show ExpansesModel;
import 'package:expense_tracker/models/settings_model.dart' show SettingsModel;
import 'package:expense_tracker/services/hive_service.dart' show HiveService;
import 'package:path_provider/path_provider.dart' show getDownloadsDirectory;

class AppExcelServices {
  Future<File> createExpenseExcel(List<ExpansesModel> expenses) async {
    SettingsModel settingsModel = HiveService.getSettings();
    HiveService.saveSettings(settingsModel.copyWith(token: settingsModel.token - 1));
    final excel = Excel.createExcel();
    final sheet = excel['Expenses'];

    // 📌 Header row
    sheet.appendRow([
      TextCellValue('Title'),
      TextCellValue('Status'),
      TextCellValue('Date'),
      TextCellValue('Price'),
    ]);

    // 📋 Data rows
    for (var e in expenses) {
      sheet.appendRow([
        TextCellValue(e.title),
        TextCellValue(e.isDone ? "Done" : "Pending"),
        TextCellValue("${e.dateTime.day}/${e.dateTime.month}/${e.dateTime.year}"),
        DoubleCellValue(e.prices),
      ]);
    }

    // 💰 Total row
    final total = expenses.fold(0.0, (sum, e) => (!e.isDone) ? sum + e.prices : 0);

    sheet.appendRow([
      TextCellValue(''),
      TextCellValue(''),
      TextCellValue('Total'),
      DoubleCellValue(total),
    ]);

    // 📂 Save file
    final directory = await getDownloadsDirectory();
    final filePath = '${directory!.path}/expense_report.xlsx';

    final fileBytes = excel.save();
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
    await file.writeAsBytes(fileBytes!);

    return file;
  }
}
