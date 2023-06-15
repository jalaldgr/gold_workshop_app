import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/sections/workshop1/draw_menu_workshop1.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/serverApi.dart';
import '../tables/Table1.dart';
import '../tables/Table2.dart';
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
  dynamic table6;


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
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: Center(
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child:Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child:
                              Row(crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                Expanded(child:Padding(padding: EdgeInsets.all(4),child:
                                OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Table1Screen(headerColor: Colors.amber,)));
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
                                                builder: (context) => Table2Screen(headerColor: Colors.amber)));
                                      },
                                      child: Text("جدول 2",style: TextStyle(fontSize: 32),))
                                  ,)

                                ),
                              ],)),
                              Expanded(child: Column(children: [
                                Expanded(child:
                                    InkWell(child:
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

                                            Container(
                                              decoration:
                                              BoxDecoration(color: Colors.blue.shade100),
                                              child: FutureBuilder(
                                                future: fetchTables(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<dynamic> snapshot) =>
                                                snapshot.hasData
                                                    ? _buildTableItem(context, snapshot.data)
                                                    : CircularProgressIndicator(),
                                              ),
                                            )
                                            ,
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: (){setState(() {

                                    });},)
                                )
                              ],))
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
                                      builder: (context) => Workshop1OrdersList()));
                            },
                            child: Text("سفارش ها",style: TextStyle(fontSize: 32),)),
                      ))        ])));
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
    Navigator.of(context).maybePop();
  }
  Future fetchTables() async {
    var tables = await AdminApi.getTable();
    table6 =json.decode(tables.table6!);
    if(tables.table6!.length>10){
      return  table6 =json.decode(tables.table6!);
    }


  }
  Widget _buildTableItem(BuildContext context, dynamic table) {
    return Row(
      children: [
        Expanded(
            child: Text("${table["daily_melt"]!=null? table["daily_melt"].toStringAsFixed(3): "0"}",
                style: TextStyle(
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)),
        Expanded(
            child: Text("${table["burnish_deficiency"].toStringAsFixed(3)?? "0"}",
                style: TextStyle(
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)),
        Expanded(
            child: Text("${table["melt_deficiency"].toStringAsFixed(3)?? "0"}",
                style: TextStyle(
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)),
        Expanded(
            child: Text("${table["cut_deficiency"].toStringAsFixed(3)?? "0"}",
                style: TextStyle(
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)),
        Expanded(
            child: Text("${table["cut_deference"].toStringAsFixed(3)?? "0"}",
                style: TextStyle(
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)),
        Expanded(
            child: Text(
              "${table["sum"].toStringAsFixed(3)?? "0"}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )),
      ],
    );
  }


}
