import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../workshop1/workshop1OrdersList.dart';
import 'draw_menu_admin.dart';
import 'orders/ordersList.dart';
import 'orders/tables/adminTable.dart';



class AdminHomeScreen extends StatefulWidget {
  AdminHomeScreen(this.jwt, this.payload);

  factory AdminHomeScreen.fromBase64(String jwt) => AdminHomeScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {


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
          backgroundColor: Colors.pink,
        ),
        backgroundColor: Colors.white,
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
                                      builder: (context) => OrdersList()));
                            },
                            child: Text("سفارش ها",style: TextStyle(fontSize: 32),)),
                      )),
                  Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(32),
                                child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AdminTableScreen()));
                                    },
                                    child: Text("جدول ها",style: TextStyle(fontSize: 32),)),
                              )),
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(32),
                                child: OutlinedButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => OrdersList()));
                                    },
                                    child: Text("آرشیو جدول ها",style: TextStyle(fontSize: 32),)),
                              ))

                        ],
                      ))
                ]
            )
        ),
        drawer: SideMenuAdmin(),
    );
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
    Navigator.of(context).maybePop();
  }


}
