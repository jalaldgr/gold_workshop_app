import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/sections/workshop1/draw_menu_workshop1.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class Workshop1HomeScreen extends StatefulWidget {
  Workshop1HomeScreen(this.jwt, this.payload);

  factory Workshop1HomeScreen.fromBase64(String jwt) => Workshop1HomeScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  _Workshop1HomeScreenState createState() => _Workshop1HomeScreenState();
}

class _Workshop1HomeScreenState extends State<Workshop1HomeScreen> {


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
        backgroundColor: Colors.white,
        drawer: SideMenuWorkshop1(),
        body: Column(children: <Widget>[
          ElevatedButton(onPressed: logOut, child: Text("خروج کارگاه 1"))

        ]));
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
    Navigator.of(context).maybePop();
  }


}
