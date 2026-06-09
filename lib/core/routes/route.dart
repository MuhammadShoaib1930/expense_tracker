import 'package:expense/core/routes/route_name.dart';
import 'package:go_router/go_router.dart';

import '../../screens/home_screen.dart';
import '../../screens/monthly_screen.dart';
import '../../screens/weekly_screen.dart';
import '../../screens/yearly_screen.dart';

final GoRouter route = GoRouter(
  routes: [
    GoRoute(path: RouteName.homeScreen, builder: (context, state) => HomeScreen()),
    GoRoute(path: RouteName.weeklyScreen, builder: (context, state) => WeeklyScreen()),
    GoRoute(path: RouteName.monthlyScreen, builder: (context, state) => MonthlyScreen()),
    GoRoute(path: RouteName.yearlyScreen, builder: (context, state) => YearlyScreen()),
  ],
);
