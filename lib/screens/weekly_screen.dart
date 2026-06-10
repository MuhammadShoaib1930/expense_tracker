import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/expanses_model.dart';
import '../services/app_graphs_services.dart';
import '../services/date_time_service.dart';
import '../services/hive_service.dart';
import '../widgets/app_graphs.dart';
import '../widgets/app_input_dilog.dart';

class WeeklyScreen extends StatelessWidget {
  final bool isDark;
  final Box boxExpanses;
  final String expansesBoxName;
  const WeeklyScreen({
    super.key,
    required this.isDark,
    required this.boxExpanses,
    required this.expansesBoxName,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        appBar: AppBar(
          title: Text("Expanses"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Weekly data!"),
              Tab(text: "Weekly Graph!"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<ExpansesModel>(expansesBoxName).listenable(),
                  builder: (context, value, child) {
                    final expanses = value.values.toList().reversed.take(7).toList();

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (expanses.isNotEmpty)
                          Expanded(flex: 2, child: AppGraphs(expanses: expanses)),
                        SizedBox(
                          height: 30.r,
                          child: Text(
                            "Total expanses: ${AppGraphsServices.totalExpanses(expanses).toString()}",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<ExpansesModel>(expansesBoxName).listenable(),
                  builder: (context, value, child) {
                    final expanses = value.values.toList().reversed.take(7).toList();

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 30.r,
                          child: Text(
                            "Total expanses: ${AppGraphsServices.totalExpanses(expanses).toString()}",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Card(
                                color: (isDark) ? Colors.grey : Colors.white,
                                child: ListTile(
                                  onLongPress: () {
                                    HiveService.expenseBox().put(
                                      expanses[index].id,
                                      expanses[index].copyWith(isDone: !expanses[index].isDone),
                                    );
                                  },
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AppInputDilog(id: index, expanses: expanses[index]);
                                      },
                                    );
                                  },
                                  title: Center(
                                    child: Text(
                                      expanses[index].title,
                                      style: TextStyle(
                                        decoration: (expanses[index].isDone)
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${DateTimeService.dateTimeToString(expanses[index].dateTime)[0]} ${DateTimeService.dateTimeToString(expanses[index].dateTime)[1]}",
                                    style: TextStyle(
                                      decoration: (expanses[index].isDone)
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      fontSize: 16,
                                    ),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        "Rs,${expanses[index].prices.toString()}",
                                        style: TextStyle(
                                          decoration: (expanses[index].isDone)
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Changed:${expanses[index].updated}",
                                        style: TextStyle(
                                          decoration: (expanses[index].isDone)
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading: IconButton(
                                    onPressed: () {
                                      HiveService.expenseBox().delete(expanses[index].id);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: expanses.length,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
