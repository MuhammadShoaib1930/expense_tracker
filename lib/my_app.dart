import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'core/routes/route.dart';
import 'cubits/theme/theme_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,

        child: BlocSelector<ThemeCubit, ThemeState, ThemeData>(
          selector: (state) {
            if (state is ThemeInitial) {
              return (state.isDark) ? ThemeData.dark() : ThemeData.light();
            } else {
              return ThemeData.light();
            }
          },
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,

              routerConfig: route, theme: state);
          },
        ),
      ),
    );
  }
}
