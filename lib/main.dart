

import 'dart:ui';
import "dart:convert";
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gold_workshop/Home.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';



Future<void> main() async {
  runApp(MyApp());
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: PersianFonts.vazirTextTheme,
      ),
      // add local support
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", "US"),
        Locale("fa", "IR"),
      ],
      locale: const Locale("fa","IR"),// initial default local

      home: HomeScreen(),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
// this class added to PageView work in web or desktop platform
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}