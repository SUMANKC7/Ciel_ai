import 'package:ciel_ai/consts.dart';
import 'package:ciel_ai/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  Gemini.init(apiKey: Gemini_API_Key);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        child: MaterialApp(
          home: HomePage(),
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Color(0xFFF0F8FF),
            primaryColor: Color(0xFF42A5F5),
          ),
        ),
      ),
    );
  }
}
