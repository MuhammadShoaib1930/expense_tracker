import 'package:expense_tracker/cubits/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.r),
          bottomRight: Radius.circular(50.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 15,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  SizedBox(width: 100.r, height: 100.r, child: CircleAvatar()),
                  Shimmer.fromColors(
                    baseColor: (isDark) ? Colors.white : Colors.black,
                    highlightColor: Colors.blue,
                    child: Text(
                      " ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 300.w,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (isDark) {
                    context.read<ThemeCubit>().themeLight();
                  } else {
                    context.read<ThemeCubit>().themeDark();
                  }
                },
                label: Text((isDark) ? "Light" : "Dark", style: TextStyle(fontSize: 18)),
                icon: Icon((isDark) ? Icons.sunny : Icons.dark_mode),
              ),
            ),

            SizedBox(
              width: 300.w,
              child: ElevatedButton.icon(
                onPressed: () {},
                label: Text("About", style: TextStyle(fontSize: 18)),
                icon: Icon(Icons.info),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
