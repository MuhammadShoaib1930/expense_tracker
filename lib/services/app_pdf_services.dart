import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import '../models/expanses_model.dart';

class AppPdfServices {
  Future<File> createExpensePdf(List<ExpansesModel> expenses) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // 📌 Title
              pw.Text(
                'Expense Report',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),

              pw.SizedBox(height: 20),

              // 📊 Table Header
              pw.Row(
                children: [
                  pw.Expanded(child: pw.Text('Title')),
                  pw.Expanded(child: pw.Text('Status')),
                  pw.Expanded(child: pw.Text('Date')),
                  pw.Expanded(child: pw.Text('Price')),
                ],
              ),

              pw.Divider(),

              // 📋 Expense List
              ...expenses.map(
                (e) => pw.Row(
                  children: [
                    pw.Expanded(child: pw.Text(e.title)),

                    pw.Expanded(child: pw.Text(e.isDone ? "Done" : "Pending")),

                    pw.Expanded(
                      child: pw.Text("${e.dateTime.day}/${e.dateTime.month}/${e.dateTime.year}"),
                    ),

                    pw.Expanded(child: pw.Text("\$${e.prices.toStringAsFixed(2)}")),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // 💰 Total
              pw.Text(
                "Total: \$${expenses.fold(0.0, (sum, e) => sum + e.prices).toStringAsFixed(2)}",
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    // 📂 Save file
    final directory = await getDownloadsDirectory();
    final filePath = '${directory!.path}/expense_report.pdf';
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
