import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'parst/draw_menu_designer.dart';



class DesignerHomeScreen extends StatefulWidget {
  DesignerHomeScreen(this.jwt, this.payload);

  factory DesignerHomeScreen.fromBase64(String jwt) => DesignerHomeScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;


  @override
  _DesignerHomeScreenState createState() => _DesignerHomeScreenState();
}

class _DesignerHomeScreenState extends State<DesignerHomeScreen> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.green),
          backgroundColor: Colors.amber,
        ),
        drawer:SideMenuDesigner(),
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          ElevatedButton(onPressed: logOut, child: Text("خروج طراح"))

        ]));
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
    Navigator.of(context).maybePop();
  }


}
