import 'package:expense_tracker/models/expanses_model.dart';

class AppGraphsServices {
  static double maxValue(List<ExpansesModel> expanses) {
    double max = double.negativeInfinity;
    for (var value in expanses) {
      max = (max < value.prices) ? value.prices : max;
    }
    return max;
  }
  static double minValue(List<ExpansesModel> expanses) {
    double min = double.infinity;
    for (var value in expanses) {
      min = (min > value.prices) ? value.prices : min;
    }
    return min;
  }

  static double totalExpanses(List<ExpansesModel> expanses) {
    double max = 0;
    for (var exp in expanses) {
      max += exp.prices;
    }
    return max;
  }
}
