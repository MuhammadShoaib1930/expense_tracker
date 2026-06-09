import 'package:share_plus/share_plus.dart';
import 'dart:io';

import 'app_excel_services.dart';
import 'app_pdf_services.dart';
import 'hive_service.dart';

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
