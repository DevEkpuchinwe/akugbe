import 'package:akugbe/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://raapnfbewyiflaoaxgmi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJhYXBuZmJld3lpZmxhb2F4Z21pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg5MzU1NDgsImV4cCI6MjA2NDUxMTU0OH0.ZPFOBHDmmNQO3bwlesxNNJx7C4PxdUljiqaanfOcwvM',
    //authFlowType: AuthFlowType.implicit,
  );

  runApp(const ProviderScope(child: MyApp()));
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
