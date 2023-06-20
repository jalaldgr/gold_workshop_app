import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/sections/designer/designerOrdersList.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/serverApi.dart';
import '../../models/userModel.dart';
import '../admin/orders/ordersList.dart';
import '../tables/Table1.dart';
import '../tables/Table2.dart';
import '../tables/Table3.dart';
import '../tables/Table4.dart';
import '../tables/Table5.dart';
import '../tables/tablesArchiveList.dart';
import 'draw_menu_designer.dart';



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
  bool _isAdmin = false;
  dynamic table6;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isUserAdmin();
  }

  Future fetchTables() async {
    var tables = await AdminApi.getTable();
    table6 =json.decode(tables.table6!);
    if(tables.table6!.length>10){
      return  table6 =json.decode(tables.table6!);
    }


  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.lightGreen,
        ),
        drawer:SideMenuDesigner(),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body:_isAdmin?
        Center(
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
                                    InkWell(
                                      onTap: (){
                                        setState(() {

                                        });
                                      },
                                      child:Card(color: Colors.blue.shade100,
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
                                            ],
                                          ),
                                        ),
                                      ),)
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

                ])):
        Center(
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
                                      builder: (context) => DesignerOrdersList()));
                            },
                            child: Text("سفارش ها",style: TextStyle(fontSize: 32),)),
                      )),
                ]))
    );
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
    Navigator.of(context).maybePop();
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

  Future isUserAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic user = jsonDecode(prefs.getString(
        "user")!); //convert string to json object. dynamic is flexible variable
    userData userDataModel =userData.fromJson(user); //
    print(userDataModel.toJson());
    setState(() {
      if(userDataModel.isAdmin=="yes")_isAdmin =  true;
      else _isAdmin =  false;
    });

  }

}
