import 'package:flutter/material.dart';
import 'package:meet_link/routes/home.dart';
import 'package:motor_flutter/motor_flutter.dart';

import 'package:meet_link/routes/login.dart';
import 'package:meet_link/routes/scan.dart';

Future<void> main() async {
  await MotorFlutter.to.connect();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/': (ctx) => HomePage(),
      '/login': (ctx) => LoginPage(),
      '/scan': (ctx) => ScanPage(),
    },
  ));
}