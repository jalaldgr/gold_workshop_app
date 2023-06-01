import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/sections/workshop1/draw_menu_workshop1.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'workshop1OrdersList.dart';



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
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.amber,
        ),
        backgroundColor: Colors.white,
        drawer: SideMenuWorkshop1(),
        body: Center(
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Workshop1OrdersList()));
                            },
                            child: Text("سفارش ها",style: TextStyle(fontSize: 32),)),
                      )),
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: OutlinedButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Workshop1OrdersList()));
                            },
                            child: Text("جدول ها",style: TextStyle(fontSize: 32),)),
                      ))        ])));
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
    Navigator.of(context).maybePop();
  }


}
