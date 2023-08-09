import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gold_workshop/sections/workshop1/workshop1Home.dart';
import 'package:gold_workshop/sections/workshop2/workshop2Home.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'login.dart';
import 'sections/admin/adminHome.dart';
import 'sections/designer/designerHome.dart';


class HomeScreen extends StatefulWidget {
  @override
  LoginScreen createState() => LoginScreen();
}

class LoginScreen extends State<HomeScreen> {
  String? _appVersion="";
  String?  _jwtToken="";
  String? _user = "";
  dynamic _role;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    Timer(Duration(seconds: 3),
            ()=>    navigate());
  }




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          child:Center(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Image.asset("assets/images/logo.png",width: 512,),
                Text("مینیاتور",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 32),),
                SizedBox(height: 16,),
                Text("ورژن ${_appVersion}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),

                SizedBox(height: 8,),

              ],),
          )

      ),
    );
  }

  init()async{
    try {
      await dotenv.load(fileName: "assets/env");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final info = await PackageInfo.fromPlatform();
      prefs.setString("version", info.version);
      setState(() {
        _appVersion = info.version;
      });
      _jwtToken = prefs.getString("jwt");
      _user = prefs.getString('user');
      if(_user!.length>5)
      _role = jsonDecode(prefs.getString('user')!)['role']; // get driver user id
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${e}")));
    }
  }

  navigate()  {
      if (_jwtToken != null) {
        dynamic str = _jwtToken;
        dynamic jwt = str.length > 1 ? str.toString().split(".") : "";
        if (jwt.length != 3) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      LoginPage()),
                  (Route<dynamic> route) => false);
        } else {

          var payload = json.decode(
              ascii.decode(base64.decode(base64.normalize(jwt[1]))));

          if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
              .isAfter(DateTime.now())) {
            switch (_role) {
              case "Admin":
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AdminHomeScreen(str, payload)),
                );
                break;
              case "Designer":
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            DesignerHomeScreen(str, payload)),
                        (Route<dynamic> route) => false);
                break;
              case "Workshop1":
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Workshop1HomeScreen(str, payload)),
                        (Route<dynamic> route) => false);
                break;
              case "Workshop2":
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Workshop1HomeScreen(str, payload)),
                        (Route<dynamic> route) => false);
                break;
            }
          }
        }
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    LoginPage()),
                (Route<dynamic> route) => false);
      }

  }
}
