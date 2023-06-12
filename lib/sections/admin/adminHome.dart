import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/sections/tables/tablesArchiveList.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../tables/Table1.dart';
import '../tables/Table2.dart';
import '../tables/Table3.dart';
import '../tables/Table4.dart';
import '../tables/Table5.dart';
import '../workshop1/workshop1OrdersList.dart';
import 'draw_menu_admin.dart';
import 'orders/ordersList.dart';



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
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(child:Padding(padding: EdgeInsets.all(4),child:
                                          OutlinedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Table1Screen(headerColor: Colors.pink,)));
                                              },
                                              child: Text("جدول 1",style: TextStyle(fontSize: 32),))
                                            ,)),
                                          Expanded(child:
                                          Padding(padding: EdgeInsets.all(4),
                                            child: OutlinedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => Table2Screen(headerColor: Colors.pink)));
                                                },
                                                child: Text("جدول 2",style: TextStyle(fontSize: 32),))
                                            ,)

                                          ),

                                        ],
                                      )),
                                  Expanded(
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(child:
                                          Padding(padding: EdgeInsets.all(4),child:
                                          OutlinedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Table3Screen(headerColor: Colors.pink)));
                                              },
                                              child: Text("جدول 3",style: TextStyle(fontSize: 32),))
                                            ,)
                                          ),
                                          Expanded(child:Padding(padding: EdgeInsets.all(4),child:
                                          OutlinedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Table4Screen(headerColor: Colors.pink)));
                                              },
                                              child: Text("جدول 4",style: TextStyle(fontSize: 32),))
                                            ,)),
                                          Expanded(child:
                                          Padding(padding: EdgeInsets.all(4),
                                            child: OutlinedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => Table5Screen(headerColor: Colors.pink)));
                                                },
                                                child: Text("جدول 5",style: TextStyle(fontSize: 32),))
                                            ,)

                                          ),
                                        ],
                                      )),
                      Card(color: Colors.blue.shade100,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                          Container(
                          child:
                          Row(crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Text("ذوب روزانه",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                              Expanded(child: Text("کسر پرداخت",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                              Expanded(child: Text("کسر ذوب",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                              Expanded(child: Text("کسر برش",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                              Expanded(child: Text("اختلاف برش",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                              Expanded(child: Text("مجموع",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                            ],
                          )
                            ,)
                          ,
                              SizedBox(height: 4,),
                        Container(decoration: BoxDecoration(color: Colors.blue.shade100
                        ),
                          child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("20",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center)),
                                    Expanded(
                                        child: Text("20",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center)),
                                    Expanded(
                                        child: Text("20",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center)),
                                    Expanded(
                                        child: Text("20",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center)),
                                    Expanded(
                                        child: Text("20",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center)),
                                    Expanded(
                                        child: Text(
                                      "20",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                            )),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TableArchiveListScreen()));
                                  },
                                  child: Text(
                                    "آرشیو جدول ها",
                                    style: TextStyle(fontSize: 32),
                                  )),
                            ))
                      ],
                    )),
                  Expanded(
                child: Padding(
              padding: EdgeInsets.all(32),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OrdersList()));
                  },
                  child: Text(
                    "سفارش ها",
                    style: TextStyle(fontSize: 32),
                  )),
            ))

          ])),
      drawer: SideMenuAdmin(),
    );
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
    Navigator.of(context).maybePop();
  }


}
