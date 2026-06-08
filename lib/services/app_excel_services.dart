import 'dart:io';
import 'package:excel/excel.dart';
import 'package:expense_tracker/models/expanses_model.dart';
import 'package:path_provider/path_provider.dart';

class AppExcelServices {
  Future<File> createExpenseExcel(List<ExpansesModel> expenses) async {
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
    final total = expenses.fold(0.0, (sum, e) => sum + e.prices);

    sheet.appendRow([
      TextCellValue(''),
      TextCellValue(''),
      TextCellValue('Total'),
      DoubleCellValue(total),
    ]);

    // 📂 Save file
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/expense_report.xlsx';

    final fileBytes = excel.save();
    final file = File(filePath);

    await file.writeAsBytes(fileBytes!);

    return file;
  }
}
