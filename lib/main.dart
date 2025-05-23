import 'package:akugbe/screens/bottom_bar.dart';
import 'package:akugbe/screens/feed.dart';
import 'package:akugbe/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      enableScaleWH: () => true,
      enableScaleText: () => true,
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
            title: 'Akugbe',
            home: Builder(builder: (BuildContext context) {
              return const SplashScreen();
              // return const Feed();
            }));
      },
    );
  }
}
