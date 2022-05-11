import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelivog/Models/loading.dart';
import 'package:kelivog/Screens/splash_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: const Size(392.7, 737.4),
      builder: (){  return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KELIVOG',
        builder: LoadingScreen.init(),
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          //    scaffoldBackgroundColor: Colors.grey[300],
          scaffoldBackgroundColor: Colors.transparent,
        ),
        home: const SplashScreen(),
      );},
    );
  }
}
