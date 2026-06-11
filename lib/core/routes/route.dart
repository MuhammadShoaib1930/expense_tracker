import 'package:expense_tracker/core/routes/route_name.dart' show RouteName;
import 'package:expense_tracker/services/google_ad_services.dart';
import 'package:expense_tracker/services/hive_service.dart';
import 'package:go_router/go_router.dart';

import '../../screens/home_screen.dart';
import '../../screens/monthly_screen.dart';
import '../../screens/weekly_screen.dart';
import '../../screens/yearly_screen.dart';

final GoRouter route = GoRouter(
  routes: [
    GoRoute(
      path: RouteName.homeScreen,
      builder: (context, state) => HomeScreen(googleAdServices: GoogleAdServices()),
    ),
    GoRoute(
      path: RouteName.weeklyScreen,
      builder: (context, state) => WeeklyScreen(
        boxExpanses: HiveService.expenseBox(),
        expansesBoxName: HiveService.expenseBoxName,
        isDark: HiveService.getSettings().isDark,
      ),
    ),
    GoRoute(
      path: RouteName.monthlyScreen,
      builder: (context, state) => MonthlyScreen(isDark: HiveService.getSettings().isDark),
    ),
    GoRoute(
      path: RouteName.yearlyScreen,
      builder: (context, state) => YearlyScreen(isDark: HiveService.getSettings().isDark),
    ),
  ],
);
