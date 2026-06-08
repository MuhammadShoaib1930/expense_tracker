import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class AboutApp extends StatelessWidget {
  final bool isDark;
  const AboutApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    double fontSize = 18;
    return Dialog(
      child: SizedBox(
        height: 250.h,
        width: 400.w,
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Column(
            spacing: 10,
            children: [
              Shimmer.fromColors(
                baseColor: (isDark) ? Colors.white : Colors.black,
                highlightColor: Colors.blue,
                child: Text(
                  "About apk",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Developer: ",
                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                  Shimmer.fromColors(
                    baseColor: (isDark) ? Colors.white : Colors.black,
                    highlightColor: Colors.blue,
                    child: SelectableText(
                      "Muhammad Shoaib",
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Email: ",
                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                  Shimmer.fromColors(
                    baseColor: (isDark) ? Colors.white : Colors.black,
                    highlightColor: Colors.blue,
                    child: SelectableText(
                      "shoaibsn54321@gmail.com",
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Phone: ",
                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                  Shimmer.fromColors(
                    baseColor: (isDark) ? Colors.white : Colors.black,
                    highlightColor: Colors.blue,
                    child: SelectableText(
                      "03238602527",
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "wattsapp: ",
                    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                  ),
                  Shimmer.fromColors(
                    baseColor: (isDark) ? Colors.white : Colors.black,
                    highlightColor: Colors.blue,
                    child: SelectableText(
                      "03238602527",
                      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ElevatedButton(onPressed: () => context.pop(), child: Icon(Icons.close)),
            ],
          ),
        ),
      ),
    );
  }
}
