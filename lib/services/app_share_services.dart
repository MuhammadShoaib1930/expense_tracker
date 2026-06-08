import 'package:expense_tracker/services/app_excel_services.dart';
import 'package:expense_tracker/services/app_pdf_services.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class AppShareServices {
  Future<void> shareFile(File file) async {
    await Share.shareXFiles([XFile(file.path)], text: 'My Expense Report');
  }

  Future<void> sharePdf() async {
    final file = await AppPdfServices().createExpensePdf(HiveService.expenseBox().values.toList());

    await shareFile(file);
  }

  Future<void> shareExcel() async {
    final file = await AppExcelServices().createExpenseExcel(
      HiveService.expenseBox().values.toList(),
    );

    await shareFile(file);
  }
}
