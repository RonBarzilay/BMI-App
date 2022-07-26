import 'dart:ui';

import 'package:bmi_calaulator_app/win/result_win.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'win/input_win.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // VibrationWebPlugin vibrationWebPlugin = VibrationWebPlugin();
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(color: Color(0xFF0A0E21), centerTitle: true),
          scaffoldBackgroundColor: Color(0xFF0A0E21)),
      // home: InputWindow(),
      initialRoute: '/',
      routes: {
        '/': (context) => InputWindow(),
        '/YOUR-BMI': (context) =>
            ResultWindow(resultText: '', bmiResult: '', interpretation: ''),
      },
    );
  }
}
