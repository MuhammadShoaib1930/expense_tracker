import 'package:expense_tracker/services/hive_service.dart' show HiveService;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../core/routes/route_name.dart';
import '../widgets/app_drawer.dart';
import '../widgets/app_input_dilog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Shimmer.fromColors(
          baseColor: (HiveService.getSettings().isDark) ? Colors.grey : Colors.black,
          highlightColor: Colors.blue,
          child: Text("Expanses Tracker"),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push(RouteName.weeklyScreen),
                  child: Text("Weekly", style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push(RouteName.monthlyScreen),
                  child: Text("Monthly", style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push(RouteName.yearlyScreen),
                  child: Text("Yearly", style: TextStyle(fontSize: 18)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push(RouteName.addMobileScreen),
                  child: Text("AddMobileScreen", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => AppInputDilog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
