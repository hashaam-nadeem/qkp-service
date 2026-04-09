import 'package:attendance/screens/splash.dart';
import 'package:attendance/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void dialogBox() {
  EasyLoading.instance
    ..backgroundColor = Colors.transparent
    ..progressColor = mainColor
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10
    ..textColor = mainColor
    ..indicatorColor = mainColor
    ..dismissOnTap = false
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..indicatorSize = 60
    ..maskType = EasyLoadingMaskType.black;
}
void main() {
  dialogBox();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance',
       builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: mainColor,
      ),
      home: Splash(),
    );
  }
}

