import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/expanses_model.dart';
import '../services/app_graphs_services.dart';

class AppGraphs extends StatelessWidget {
  final List<ExpansesModel> expanses;
  const AppGraphs({super.key, required this.expanses});

  @override
  Widget build(BuildContext context) {
    double maxValueY = AppGraphsServices.maxValue(expanses);
    double minValuey = AppGraphsServices.minValue(expanses);
    return BarChart(
      curve: Curves.bounceInOut,
      duration: Duration(seconds: 2),
      transformationConfig: FlTransformationConfig(),

      BarChartData(
        borderData: FlBorderData(border: Border.all(), show: false),

        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),

        maxY: maxValueY,
        minY: minValuey,
        gridData: const FlGridData(show: false),

        barGroups: List.generate(expanses.length, (index) {
          return BarChartGroupData(
            x: index + 1,
            barRods: [
              BarChartRodData(
                toY: expanses[index].prices,
                color: Colors.blue,
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  color: Colors.grey[200],
                  fromY: maxValueY,
                  toY: minValuey,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
