import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import '../../helper/serverApi.dart';

class TableArchiveListScreen extends StatefulWidget {
  const TableArchiveListScreen({Key? key}) : super(key: key);

  @override
  _TableArchiveListScreenState createState() => _TableArchiveListScreenState();
}

class _TableArchiveListScreenState extends State<TableArchiveListScreen> {

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
          title: const Text('آرشیو جدول ها',
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
              Center(
                child: FutureBuilder(
                  future: AdminApi.getTables(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<tableData>> snapshot) =>
                  snapshot.hasData && snapshot.data!.isNotEmpty
                      ?
                  Padding(padding: EdgeInsets.all(4),
                      child:
                      Column(
                        children: [
                          Container(
                            child:ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return _buildPaymentItem(
                                    context,
                                    snapshot.data?[index],
                                    index);
                              }),
                          ),
                        ],
                      )
                  )
                      : snapshot.hasError
                      ? Center(
                    child: Text('Error: ${snapshot.error}'),
                  )
                      : snapshot.data != null
                      ? const Center(
                    child: Text("بدون جدول..."),
                  )
                      : CircularProgressIndicator(),
                ),
              )
            ],),),
    );
  }




  Widget _buildPaymentItem(BuildContext context,
       tableData? table,int? index) {
    var table6 =json.decode("${table!.table6!}");
    return Padding(padding: EdgeInsets.all(4),
      child:
      Container( color: (index! % 2 == 0) ? Colors.black12 : Colors.indigo.shade100,height: 100,
        child:
        Card(color: Colors.blue.shade100,
          child:
          Container(padding: EdgeInsets.all(8),
            child: Row(children: [
              Text("${table.date}"),

              Expanded(child:
              Column(
                children: [
                  Container(decoration: BoxDecoration(color: Colors.blue.shade100),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text("ذوب روزانه",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("کسر پرداخت",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("کسر ذوب",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("کسر برش",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("اختلاف برش",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text(
                              "جمع",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 4,),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: Text("${table6["daily_melt"].toStringAsFixed(3)?? "0"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("${table6["burnish_deficiency"].toStringAsFixed(3)?? "0"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("${table6["melt_deficiency"].toStringAsFixed(3)?? "0"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("${table6["cut_deficiency"].toStringAsFixed(3)?? "0"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text("${table6["cut_deference"].toStringAsFixed(3)?? "0"}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center)),
                        Expanded(
                            child: Text(
                              "${table6["sum"].toStringAsFixed(3)?? "0"}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  ),
                ],
              ))
            ]),
          ),
        )
      )

      ,);
  }
}



