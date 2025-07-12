import 'package:flutter/material.dart';
import 'package:rise/screens/dashboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      // Set according to your design (iPhone X is common)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Cattle Hut Depatment',
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const Dashboard(),);
  }

}