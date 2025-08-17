import 'package:ciel_ai/pages/home_page.dart';
import 'package:ciel_ai/pages/image_generate_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  Gemini.init(apiKey: dotenv.env['apiKey'] ?? '');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: MaterialApp(
          home: const HomePage(),
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF0F8FF),
            primaryColor: const Color(0xFF42A5F5),
          ),
        ),
      ),
    );
  }
}
