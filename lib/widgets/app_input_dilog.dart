import 'package:expense_tracker/models/expanses_model.dart';
import 'package:expense_tracker/services/date_time_service.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:expense_tracker/widgets/app_snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class AppInputDilog extends StatelessWidget {
  final int? id;
  final ExpansesModel? expanses;
  const AppInputDilog({super.key, this.expanses, this.id});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController prices = TextEditingController();
    DateTime dateTime = DateTime.now();
    if (expanses != null) {
      title.text = expanses!.title;
      prices.text = expanses!.prices.toString();
    }
    Box boxExpanses = HiveService.expenseBox();
    return Dialog(
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: SizedBox(
          height: 300.r,
          width: 300.r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Text(
                "Adding new Expanse",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: title,

                decoration: InputDecoration(labelText: "Title", border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: prices,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Prices", border: OutlineInputBorder()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(DateTimeService.dateTimeToString(dateTime)[0]),
                  Text(DateTimeService.dateTimeToString(dateTime)[1]),
                ],
              ),
              if (expanses != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  spacing: 10,
                  children: [
                    Text("Done: ${(expanses!.isDone) ? 'true' : 'false'}"),
                    Text(
                      "Updated times: ${(expanses!.updated > 0) ? expanses!.updated.toString() : ''}",
                    ),
                  ],
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (expanses != null) {
                        boxExpanses.put(
                          expanses!.id,
                          expanses!.copyWith(
                            title: title.text.toString().trim(),
                            prices: double.parse(prices.text.toString().trim()),
                            updated: expanses!.updated + 1,
                          ),
                        );
                        appSnakBar(context, message: "Updated!");
                      } else {
                        String k = DateTime.now().microsecondsSinceEpoch.toString();
                        boxExpanses.put(
                          k,
                          ExpansesModel(
                            id: k,
                            title: title.text.toString().trim(),
                            prices: double.parse(prices.text.toString().trim()),
                            dateTime: DateTime.now(),
                          ),
                        );
                        appSnakBar(context, message: "Added new expanses!");
                      }
                      context.pop();
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
