import 'package:expense_tracker/models/expanses_model.dart';
import 'package:expense_tracker/services/app_graphs_services.dart';
import 'package:expense_tracker/services/date_time_service.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:expense_tracker/widgets/app_graphs.dart';
import 'package:expense_tracker/widgets/app_input_dilog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  Box boxExpanses = HiveService.expenseBox();
  final String expansesBoxName = HiveService.expenseBoxName;
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
                                color: (expanses[index].isDone)
                                    ? Colors.green[100]
                                    : Colors.white,
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
                                        return AppInputDilog(
                                          id: index,
                                          expanses: expanses[index],
                                        );
                                      },
                                    );
                                  },
                                  title: Center(
                                    child: Text(
                                      expanses[index].title,
                                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${DateTimeService.dateTimeToString(expanses[index].dateTime)[0]} ${DateTimeService.dateTimeToString(expanses[index].dateTime)[1]}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        "Rs,${expanses[index].prices.toString()}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Changed:${expanses[index].updated}",
                                        style: TextStyle(fontSize: 14),
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
