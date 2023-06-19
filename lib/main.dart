

import 'dart:convert' show json, base64, ascii;
import 'dart:ui';
import "dart:convert";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gold_workshop/sections/workshop1/workshop1Home.dart';
import 'package:gold_workshop/sections/workshop2/workshop2Home.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'sections/admin/adminHome.dart';
import 'login.dart';
import 'sections/designer/designerHome.dart';

Future<void> main() async {
  runApp(MyApp());
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    await dotenv.load(fileName: "assets/env");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final info = await PackageInfo.fromPlatform();
    prefs.setString("version",info.version );
    var jwt = prefs.getString("jwt");
    if (jwt == null) return "N";
    return jwt.toString();
  }

  Future<String> get userRoleType async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic role =jsonDecode(prefs.getString('user')!)['role']; // get driver user id
    if (role == null) return "N";
    return role;
  }

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

      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {

            if (!snapshot.hasData) return  LoginPage();
            if (snapshot.data != "N") {
              dynamic str = snapshot.data;
              dynamic jwt = str.length > 1 ? str.toString().split(".") : "";
              if (jwt.length != 3) {
                return LoginPage();
              } else {
                var payload = json.decode(
                    ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                    .isAfter(DateTime.now())) {
                  return FutureBuilder(future: userRoleType,
                      builder:(context, snapshot){
                        print(snapshot.data);
                        if (!snapshot.hasData) return  LoginPage();

                        else{
                          switch(snapshot.data){

                            case "Admin":
                              return Scaffold(body:AdminHomeScreen(str, payload));
                              break;
                            case "Designer":
                              return Scaffold(body:DesignerHomeScreen(str, payload));
                              break;
                            case "Workshop1":
                              return Scaffold(body:Workshop1HomeScreen(str, payload));
                              break;
                            case "Workshop2":
                              return Scaffold(body:Workshop2HomeScreen(str, payload));
                              break;

                          }
                          return  LoginPage();
                        }
                      } );

                } else {
                  return LoginPage();
                }
              }
            } else {
              return  LoginPage();
            }
          }),
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