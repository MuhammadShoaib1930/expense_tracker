import 'package:expense_tracker/core/routes/route_name.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:expense_tracker/screens/monthly_screen.dart';
import 'package:expense_tracker/screens/weekly_screen.dart';
import 'package:expense_tracker/screens/yearly_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter route = GoRouter(
  routes: [
    GoRoute(path: RouteName.homeScreen, builder: (context, state) => HomeScreen()),
    GoRoute(path: RouteName.weeklyScreen, builder: (context, state) => WeeklyScreen()),
    GoRoute(path: RouteName.monthlyScreen, builder: (context, state) => MonthlyScreen()),
    GoRoute(path: RouteName.yearlyScreen, builder: (context, state) => YearlyScreen()),
  ],
);
