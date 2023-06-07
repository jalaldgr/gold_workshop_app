import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';

class AdminTableScreen extends StatefulWidget {
  const AdminTableScreen({Key? key}) : super(key: key);

  @override
  _AdminTableScreenState createState() => _AdminTableScreenState();
}

class _AdminTableScreenState extends State<AdminTableScreen> {
  TextEditingController fullNameController=TextEditingController();
  TextEditingController userNameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  List<DataRow> tableItem=[];


  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.pink,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[IconButton(onPressed: (){setState(() {});}, icon: Icon(Icons.refresh))],
          title: const Text('جدول های امروز',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0)),
        ),
        drawer: SideMenuAdmin(),
        backgroundColor: Colors.white,
        body:SingleChildScrollView(child:
          Stack(
            children: [
              FutureBuilder(
                future: AdminApi.getTable(),
                builder: (BuildContext context,
                    AsyncSnapshot<tableData> snapshot) =>
                snapshot.hasData
                    ?
                Padding(padding: EdgeInsets.all(4),
                    child:
                    Column(
                      children: [
                        Card(
                          child: Container(alignment: Alignment.centerRight,padding: EdgeInsets.all(8),
                            child: Column(children: [
                              DataTable(columns: const <DataColumn>[
                                        DataColumn(
                                          label: Text(
                                            'ردیف',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'متفرقه',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                DataColumn(
                                  label: Text(
                                    'بار مصرفی',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'مجموع متفرقه و بار',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'بعد از ذوب',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'اختلاف',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'بعد از صفحه گیری',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'اختلاف نهایی',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),

                                      ], rows: tableItem
                              )
                            ]),
                          ),
                        ),
                      ],
                    )
                )
                    : snapshot.hasError
                    ? Center(
                      child: Text('Error: ${snapshot.error}'),)
                    : snapshot.data != null
                    ? const Center(
                      child: Text("..."),)
                    : CircularProgressIndicator(),
              )
            ],),)

        ,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        )

    );
  }




}
