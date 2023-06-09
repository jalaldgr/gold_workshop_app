import 'dart:convert';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../helper/serverApi.dart';
import 'archiveTables/TableArchive1.dart';
import 'archiveTables/TableArchive2.dart';
import 'archiveTables/TableArchive3.dart';
import 'archiveTables/TableArchive4.dart';
import 'archiveTables/TableArchive5.dart';
class TableArchiveListScreen extends StatefulWidget {
  const TableArchiveListScreen({Key? key}) : super(key: key);

  @override
  _TableArchiveListScreenState createState() => _TableArchiveListScreenState();
}

class _TableArchiveListScreenState extends State<TableArchiveListScreen> {
  String _listState = "archive";
  String _searchKeyword = "keyword";

  @override
  void initState() {

    super.initState();
  }

  _searchOrders(s)async{
    print("trig search");
    if(s.toString().length>3){
      setState(() {
        _listState="search";
        _searchKeyword = s;
      });
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.pink,
          actions: <Widget>[
            IconButton(onPressed: (){setState(() {_listState="archive";});},
                tooltip: "بروزرسانی",
                icon: Icon(Icons.refresh)),

          ],          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Container(
            height: 48,
            child:
            EasySearchBar(
              onSearch: (s) => _searchOrders(s),
              title:  Text('لیست سفارش ها   ${Jalali.now().formatFullDate()}',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0)),
            ),

          ),
        ),
        drawer: SideMenuAdmin(),
        backgroundColor: Colors.white,
        body:SingleChildScrollView(scrollDirection: Axis.vertical,child:
          Stack(
            children: [
              Center(
                child: FutureBuilder(
                  future:_listState=="archive"? AdminApi.getTables():AdminApi.searchTables(_searchKeyword),
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
      Container( color: (index! % 2 == 0) ? Colors.black12 : Colors.indigo.shade100,height: 84,
        child:
        Card(color: Colors.blue.shade100,
          child:
          Container(padding: EdgeInsets.all(8),
            child: Row(children: [
              Column(children: [
                Text("${table.date}"),
                SizedBox(height: 4,),
                Row(children: [
                  TextButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Table1ArchiveScreen(headerColor: Colors.pink, table: table,)));
                  }, child: Text("1",style: TextStyle(fontSize: 20))),
                  TextButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Table2ArchiveScreen(headerColor: Colors.pink, table:  table,)));
                  }, child: Text("2",style: TextStyle(fontSize: 20))),
                  TextButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Table3ArchiveScreen(headerColor: Colors.pink, table:  table,)));
                  }, child: Text("3",style: TextStyle(fontSize: 20))),
                  TextButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Table4ArchiveScreen(headerColor: Colors.pink, table:  table,)));
                  }, child: Text("4",style: TextStyle(fontSize: 20))),
                  TextButton(onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Table5ArchiveScreen(headerColor: Colors.pink, table:  table,)));
                  }, child: Text("5",style: TextStyle(fontSize: 20),))
                ],),

                ],),
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



