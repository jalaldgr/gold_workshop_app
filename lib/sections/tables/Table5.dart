import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/helper/workshop1Api.dart';
import 'package:gold_workshop/helper/workshop2Api.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:pluto_grid/pluto_grid.dart';

class Table5Screen extends StatefulWidget {
  final Color headerColor;
  const Table5Screen({Key? key, required this.headerColor}) : super(key: key);

  @override
  _Table5ScreenState createState() => _Table5ScreenState();
}

class _Table5ScreenState extends State<Table5Screen> {
  TextEditingController fullNameController=TextEditingController();
  TextEditingController userNameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  List<DataRow> tableItem=[];


  List<PlutoColumn> columns = [
    PlutoColumn(
        title: 'ردیف',
        field: 'row',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),

    /// Select Column definition
    PlutoColumn(
        title: 'سفارش دهنده',
        field: 'client_name',
        type: PlutoColumnType.text(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'شرح',
        field: 'description',
        type: PlutoColumnType.text(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'کد',
        field: 'code',
        type: PlutoColumnType.text(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'وزن',
        field: 'weight',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'کسر برش',
        field: 'cut_deficiency',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'کسر پاپیون',
        field: 'popion_deficiency',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'وزن نگین',
        field: 'jewel_weight',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'توضیحات',
        field: 'summary',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'ذوب',
        field: 'melting',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'مفتول کشی',
        field: 'wire_pulling',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'برش',
        field: 'cut',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'پاپیون',
        field: 'popion',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'حلقه',
        field: 'ring',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'زنجیر',
        field: 'chain',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'تکه زنجیر',
        field: 'piece_chain',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'عصایی',
        field: 'cane',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'مدبر',
        field: 'lock',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'مفتول',
        field: 'wire',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'لحیم',
        field: 'solder',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'گوی',
        field: 'ball',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'سرسنجاق',
        field: 'pin',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'رینگ',
        field: 'ring2',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'نیم ساخته',
        field: 'half_made',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'مفتول کشی',
        field: 'wiring',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'وزن نهایی',
        field: 'final_weight',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
    PlutoColumn(
        title: 'کسر پرداخت',
        field: 'burnish_deficiency',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100),
  ];

  List<PlutoRow> rows = [];

  updateTable()async{
    Map<String,dynamic> table5 = {};

    List rows = stateManager.rows.map((e) => e.cells['row']?.value).toList();
    List client_name = stateManager.rows.map((e) => e.cells['client_name']?.value).toList();
    List description = stateManager.rows.map((e) => e.cells['description']?.value).toList();
    List code = stateManager.rows.map((e) => e.cells['code']?.value).toList();
    List weight = stateManager.rows.map((e) => e.cells['weight']?.value).toList();
    List cut_deficiency = stateManager.rows.map((e) => e.cells['cut_deficiency']?.value).toList();
    List popion_deficiency = stateManager.rows.map((e) => e.cells['popion_deficiency']?.value).toList();
    List jewel_weight = stateManager.rows.map((e) => e.cells['jewel_weight']?.value).toList();
    List summary = stateManager.rows.map((e) => e.cells['summary']?.value).toList();
    List melting = stateManager.rows.map((e) => e.cells['melting']?.value).toList();
    List wire_pulling = stateManager.rows.map((e) => e.cells['wire_pulling']?.value).toList();
    List cut = stateManager.rows.map((e) => e.cells['cut']?.value).toList();
    List popion = stateManager.rows.map((e) => e.cells['popion']?.value).toList();
    List ring = stateManager.rows.map((e) => e.cells['ring']?.value).toList();
    List chain = stateManager.rows.map((e) => e.cells['chain']?.value).toList();
    List piece_chain = stateManager.rows.map((e) => e.cells['piece_chain']?.value).toList();
    List cane = stateManager.rows.map((e) => e.cells['cane']?.value).toList();
    List lock = stateManager.rows.map((e) => e.cells['lock']?.value).toList();
    List wire = stateManager.rows.map((e) => e.cells['wire']?.value).toList();
    List solder = stateManager.rows.map((e) => e.cells['solder']?.value).toList();
    List ball = stateManager.rows.map((e) => e.cells['ball']?.value).toList();
    List pin = stateManager.rows.map((e) => e.cells['pin']?.value).toList();
    List ring2 = stateManager.rows.map((e) => e.cells['ring2']?.value).toList();
    List half_made = stateManager.rows.map((e) => e.cells['half_made']?.value).toList();
    List wiring = stateManager.rows.map((e) => e.cells['wiring']?.value).toList();
    List final_weight = stateManager.rows.map((e) => e.cells['final_weight']?.value).toList();
    List burnish_deficiency = stateManager.rows.map((e) => e.cells['burnish_deficiency']?.value).toList();




    table5["row"]=rows.toList();
    table5["client_name"]=client_name.toList();
    table5["description"]=description.toList();
    table5["code"]=code.toList();
    table5["weight"]=weight.toList();
    table5["cut_deficiency"]=cut_deficiency.toList();
    table5["popion_deficiency"]=popion_deficiency.toList();
    table5["jewel_weight"]=jewel_weight.toList();
    table5["summary"]=summary.toList();
    table5["melting"]=melting.toList();
    table5["wire_pulling"]=wire_pulling.toList();
    table5["cut"]=cut.toList();
    table5["popion"]=popion.toList();
    table5["ring"]=ring.toList();
    table5["chain"]=chain.toList();
    table5["piece_chain"]=piece_chain.toList();
    table5["cane"]=cane.toList();
    table5["lock"]=lock.toList();
    table5["wire"]=wire.toList();
    table5["solder"]=solder.toList();
    table5["ball"]=ball.toList();
    table5["pin"]=pin.toList();
    table5["ring2"]=ring2.toList();
    table5["half_made"]=half_made.toList();
    table5["wiring"]=wiring.toList();
    table5["final_weight"]=final_weight.toList();
    table5["burnish_deficiency"]=burnish_deficiency.toList();



    tableData t = new tableData("تکمیل کارگاه 1", "", "", "","", "", jsonEncode(table5), "","","","");

    var respo = await AdminApi.postTable(t);

  }

  fetchTable() async {
    var tables = await AdminApi.getTable();
    if(tables.table5!.length>10){
      stateManager.setShowLoading(true);
      dynamic table5 =json.decode(tables.table5!);
      List rowNumber = table5["row"];
      List client_name = table5["client_name"];
      List description = table5["description"];
      List code = table5["code"];
      List weight = table5["weight"];
      List cut_deficiency = table5["cut_deficiency"];
      List popion_deficiency = table5["popion_deficiency"];
      List jewel_weight = table5["jewel_weight"];
      List summary = table5["summary"];
      List wire_pulling = table5["wire_pulling"];
      List melting = table5["melting"];
      List cut = table5["cut"];
      List popion = table5["popion"];
      List ring = table5["ring"];
      List chain = table5["chain"];
      List piece_chain = table5["piece_chain"];
      List cane = table5["cane"];
      List lock = table5["lock"];
      List wire = table5["wire"];
      List solder = table5["solder"];
      List ball = table5["ball"];
      List pin = table5["pin"];
      List ring2 = table5["ring2"];
      List half_made = table5["half_made"];
      List wiring = table5["wiring"];
      List final_weight = table5["final_weight"];
      List burnish_deficiency = table5["burnish_deficiency"];

      List<PlutoRow> updatedRows=[];
      for (var i = 0; i < rowNumber.length; i++) {
        updatedRows.add(PlutoRow(
          cells: {
            'row': PlutoCell(value:rowNumber[i] ),
            'client_name': PlutoCell(value: client_name[i]),
            'description': PlutoCell(value: description[i]),
            'code': PlutoCell(value: code[i]),
            'weight': PlutoCell(value: weight[i]),
            'cut_deficiency': PlutoCell(value: cut_deficiency[i]),
            'popion_deficiency': PlutoCell(value: popion_deficiency[i]),
            'jewel_weight': PlutoCell(value: jewel_weight[i]),
            'summary': PlutoCell(value: summary[i]),
            'melting': PlutoCell(value: melting[i]),
            'wire_pulling': PlutoCell(value: wire_pulling[i]),
            'cut': PlutoCell(value: cut[i]),
            'popion': PlutoCell(value: popion[i]),
            'ring': PlutoCell(value: ring[i]),
            'chain': PlutoCell(value: chain[i]),
            'piece_chain': PlutoCell(value: piece_chain[i]),
            'cane': PlutoCell(value: cane[i]),
            'lock': PlutoCell(value: lock[i]),
            'wire': PlutoCell(value: wire[i]),
            'solder': PlutoCell(value: solder[i]),
            'ball': PlutoCell(value: ball[i]),
            'pin': PlutoCell(value: pin[i]),
            'ring2': PlutoCell(value: ring2[i]),
            'half_made': PlutoCell(value: half_made[i]),
            'wiring': PlutoCell(value: wiring[i]),
            'final_weight': PlutoCell(value: final_weight[i]),
            'burnish_deficiency': PlutoCell(value: burnish_deficiency[i]),
          },
        ));
      }
      stateManager.refRows.clear();
      stateManager.insertRows(0, updatedRows);
      stateManager.setShowLoading(false);
    }else fetchOrders();
  }
  fetchOrders()async{
    var orders =await Workshop2Api.getAllActiveOrders() ;
    if(orders.length>0){
      int index =0;
      rows=[];
      orders.forEach((element) {
        index = index+1;
        rows.add(
          PlutoRow(
            cells: {
              'row': PlutoCell(value: element),
              'client_name': PlutoCell(value: element.clientFullName),
              'description':PlutoCell(value: element.description),
              'code':PlutoCell(value: element.code),
              'weight':PlutoCell(value: element.weight),
              'cut_deficiency':PlutoCell(value: 0),
              'popion_deficiency':PlutoCell(value: 0),
              'jewel_weight':PlutoCell(value: 0),
              'summary':PlutoCell(value: ""),
              'melting':PlutoCell(value: 0),
              'wire_pulling':PlutoCell(value: 0),
              'cut':PlutoCell(value: 0),
              'popion':PlutoCell(value: 0),
              'ring':PlutoCell(value:0),
              'chain':PlutoCell(value: 0),
              'piece_chain':PlutoCell(value: 0),
              'cane':PlutoCell(value: 0),
              'lock':PlutoCell(value: 0),
              'wire':PlutoCell(value: 0),
              'solder':PlutoCell(value: 0),
              'ball':PlutoCell(value: 0),
              'pin':PlutoCell(value: 0),
              'ring2':PlutoCell(value: 0),
              'half_made':PlutoCell(value: 0),
              'wiring':PlutoCell(value: 0),
              'final_weight':PlutoCell(value: 0),
              'burnish_deficiency':PlutoCell(value: 0),
            },
          ),
        );
      });
      stateManager.refRows.clear();
      stateManager.insertRows(0, rows);

    }else rows=[];

  }
  calculateTable()async{

      Map<String,dynamic> table5 = {};

      List rows = stateManager.rows.map((e) => e.cells['row']?.value).toList();
      List client_name = stateManager.rows.map((e) => e.cells['client_name']?.value).toList();
      List description = stateManager.rows.map((e) => e.cells['description']?.value).toList();
      List code = stateManager.rows.map((e) => e.cells['code']?.value).toList();
      List weight = stateManager.rows.map((e) => e.cells['weight']?.value).toList();
      List cut_deficiency = stateManager.rows.map((e) => e.cells['cut_deficiency']?.value).toList();
      List popion_deficiency = stateManager.rows.map((e) => e.cells['popion_deficiency']?.value).toList();
      List jewel_weight = stateManager.rows.map((e) => e.cells['jewel_weight']?.value).toList();
      List summary = stateManager.rows.map((e) => e.cells['summary']?.value).toList();
      List melting = stateManager.rows.map((e) => e.cells['melting']?.value).toList();
      List wire_pulling = stateManager.rows.map((e) => e.cells['wire_pulling']?.value).toList();
      List cut = stateManager.rows.map((e) => e.cells['cut']?.value).toList();
      List popion = stateManager.rows.map((e) => e.cells['popion']?.value).toList();
      List ring = stateManager.rows.map((e) => e.cells['ring']?.value).toList();
      List chain = stateManager.rows.map((e) => e.cells['chain']?.value).toList();
      List piece_chain = stateManager.rows.map((e) => e.cells['piece_chain']?.value).toList();
      List cane = stateManager.rows.map((e) => e.cells['cane']?.value).toList();
      List lock = stateManager.rows.map((e) => e.cells['lock']?.value).toList();
      List wire = stateManager.rows.map((e) => e.cells['wire']?.value).toList();
      List solder = stateManager.rows.map((e) => e.cells['solder']?.value).toList();
      List ball = stateManager.rows.map((e) => e.cells['ball']?.value).toList();
      List pin = stateManager.rows.map((e) => e.cells['pin']?.value).toList();
      List ring2 = stateManager.rows.map((e) => e.cells['ring2']?.value).toList();
      List half_made = stateManager.rows.map((e) => e.cells['half_made']?.value).toList();
      List wiring = stateManager.rows.map((e) => e.cells['wiring']?.value).toList();
      List final_weight = stateManager.rows.map((e) => e.cells['final_weight']?.value).toList();
      List burnish_deficiency = stateManager.rows.map((e) => e.cells['burnish_deficiency']?.value).toList();




      List<PlutoRow> updatedRows=[];
      for (var i = 0; i < rows.length; i++) {
        // code[i]=(double.parse(code[i])/2).toStringAsFixed(2);
        updatedRows.add(PlutoRow(
          cells: {
            'row': PlutoCell(value:rows[i] ),
            'client_name': PlutoCell(value: client_name[i]),
            'description': PlutoCell(value: description[i]),
            'code': PlutoCell(value: code[i]),
            'weight': PlutoCell(value: weight[i]),
            'cut_deficiency': PlutoCell(value: cut_deficiency[i]),
            'popion_deficiency': PlutoCell(value: popion_deficiency[i]),
            'jewel_weight': PlutoCell(value: jewel_weight[i]),
            'summary': PlutoCell(value: summary[i]),
            'melting': PlutoCell(value: melting[i]),
            'wire_pulling': PlutoCell(value: wire_pulling[i]),
            'cut': PlutoCell(value: cut[i]),
            'popion': PlutoCell(value: popion[i]),
            'ring': PlutoCell(value: ring[i]),
            'chain': PlutoCell(value: chain[i]),
            'piece_chain': PlutoCell(value: piece_chain[i]),
            'cane': PlutoCell(value: cane[i]),
            'lock': PlutoCell(value: lock[i]),
            'wire': PlutoCell(value: wire[i]),
            'solder': PlutoCell(value: solder[i]),
            'ball': PlutoCell(value: ball[i]),
            'pin': PlutoCell(value: pin[i]),
            'ring2': PlutoCell(value: ring2[i]),
            'half_made': PlutoCell(value: half_made[i]),
            'wiring': PlutoCell(value: wiring[i]),
            'final_weight': PlutoCell(value: final_weight[i]),
            'burnish_deficiency': PlutoCell(value: burnish_deficiency[i]),
          },
        ));
      }
      stateManager.refRows.clear();
      stateManager.insertRows(0, updatedRows);
      stateManager.setShowLoading(false);



  }


  @override
  void initState() {
    super.initState();
  }

  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: widget.headerColor?? Colors.pink,
        actions: [IconButton(onPressed: (){updateTable();}, icon: Icon(Icons.refresh))],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('جدول 5',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 22.0)),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          createHeader:  (stateManager) => _Header(stateManager: stateManager),


          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;

            fetchTable();
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            calculateTable();
            updateTable();
          },
          configuration: const PlutoGridConfiguration(style: PlutoGridStyleConfig()),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        stateManager.insertRows(stateManager.rows.length, [
          PlutoRow(
            cells: {
              'row': PlutoCell(value: 1+stateManager.rows.length),
              'client_name': PlutoCell(value: ""),
              'description': PlutoCell(value: ""),
              'code': PlutoCell(value: ""),
              'weight': PlutoCell(value: 0),
              'cut_deficiency': PlutoCell(value: 0),
              'popion_deficiency': PlutoCell(value: 0),
              'jewel_weight': PlutoCell(value: 0),
              'summary': PlutoCell(value: ""),
              'melting': PlutoCell(value: 0),
              'wire_pulling': PlutoCell(value: 0),
              'cut': PlutoCell(value: 0),
              'popion': PlutoCell(value: 0),
              'ring': PlutoCell(value: 0),
              'chain': PlutoCell(value: 0),
              'piece_chain': PlutoCell(value: 0),
              'cane': PlutoCell(value: 0),
              'lock': PlutoCell(value: 0),
              'wire': PlutoCell(value: 0),
              'solder': PlutoCell(value: 0),
              'ball': PlutoCell(value: 0),
              'pin': PlutoCell(value: 0),
              'ring2': PlutoCell(value: 0),
              'half_made': PlutoCell(value: 0),
              'wiring': PlutoCell(value: 0),
              'final_weight': PlutoCell(value: 0),
              'burnish_deficiency': PlutoCell(value: 0),
            },
          ),
        ]);


        },child: const Icon(Icons.add)),

    );
  }

}


class _Header extends StatefulWidget {
  const _Header({
    required this.stateManager,
    Key? key,
  }) : super(key: key);

  final PlutoGridStateManager stateManager;

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {

  PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.stateManager.setSelectingMode(gridSelectingMode);
    });
  }


  void handleRemoveCurrentColumnButton() {
    final currentColumn = widget.stateManager.currentColumn;

    if (currentColumn == null) {
      return;
    }

    widget.stateManager.removeColumns([currentColumn]);
  }

  void handleRemoveCurrentRowButton() {
    widget.stateManager.removeCurrentRow();
    updateTable();

  }



  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: handleRemoveCurrentRowButton,
      child: const Text('حذف سطر انتخاب شده',style: TextStyle(color: Colors.black),),
    );
  }


  updateTable()async{
    Map<String,dynamic> table5 = {};
    List rows = widget.stateManager.rows.map((e) => e.cells['row']?.value).toList();
    List client_name = widget.stateManager.rows.map((e) => e.cells['client_name']?.value).toList();
    List description = widget.stateManager.rows.map((e) => e.cells['description']?.value).toList();
    List code = widget.stateManager.rows.map((e) => e.cells['code']?.value).toList();
    List weight = widget.stateManager.rows.map((e) => e.cells['weight']?.value).toList();
    List cut_deficiency = widget.stateManager.rows.map((e) => e.cells['cut_deficiency']?.value).toList();
    List popion_deficiency = widget.stateManager.rows.map((e) => e.cells['popion_deficiency']?.value).toList();
    List jewel_weight = widget.stateManager.rows.map((e) => e.cells['jewel_weight']?.value).toList();
    List summary = widget.stateManager.rows.map((e) => e.cells['summary']?.value).toList();
    List melting = widget.stateManager.rows.map((e) => e.cells['melting']?.value).toList();
    List wire_pulling = widget.stateManager.rows.map((e) => e.cells['wire_pulling']?.value).toList();
    List cut = widget.stateManager.rows.map((e) => e.cells['cut']?.value).toList();
    List popion = widget.stateManager.rows.map((e) => e.cells['popion']?.value).toList();
    List ring = widget.stateManager.rows.map((e) => e.cells['ring']?.value).toList();
    List chain = widget.stateManager.rows.map((e) => e.cells['chain']?.value).toList();
    List piece_chain = widget.stateManager.rows.map((e) => e.cells['piece_chain']?.value).toList();
    List cane = widget.stateManager.rows.map((e) => e.cells['cane']?.value).toList();
    List lock = widget.stateManager.rows.map((e) => e.cells['lock']?.value).toList();
    List wire = widget.stateManager.rows.map((e) => e.cells['wire']?.value).toList();
    List solder = widget.stateManager.rows.map((e) => e.cells['solder']?.value).toList();
    List ball = widget.stateManager.rows.map((e) => e.cells['ball']?.value).toList();
    List pin = widget.stateManager.rows.map((e) => e.cells['pin']?.value).toList();
    List ring2 = widget.stateManager.rows.map((e) => e.cells['ring2']?.value).toList();
    List half_made = widget.stateManager.rows.map((e) => e.cells['half_made']?.value).toList();
    List wiring = widget.stateManager.rows.map((e) => e.cells['wiring']?.value).toList();
    List final_weight = widget.stateManager.rows.map((e) => e.cells['final_weight']?.value).toList();
    List burnish_deficiency = widget.stateManager.rows.map((e) => e.cells['burnish_deficiency']?.value).toList();

    table5["row"]=rows.toList();
    table5["client_name"]=client_name.toList();
    table5["description"]=description.toList();
    table5["code"]=code.toList();
    table5["weight"]=weight.toList();
    table5["cut_deficiency"]=cut_deficiency.toList();
    table5["popion_deficiency"]=popion_deficiency.toList();
    table5["jewel_weight"]=jewel_weight.toList();
    table5["summary"]=summary.toList();
    table5["melting"]=melting.toList();
    table5["wire_pulling"]=wire_pulling.toList();
    table5["cut"]=cut.toList();
    table5["popion"]=popion.toList();
    table5["ring"]=ring.toList();
    table5["chain"]=chain.toList();
    table5["piece_chain"]=piece_chain.toList();
    table5["cane"]=cane.toList();
    table5["lock"]=lock.toList();
    table5["wire"]=wire.toList();
    table5["solder"]=solder.toList();
    table5["ball"]=ball.toList();
    table5["pin"]=pin.toList();
    table5["ring2"]=ring2.toList();
    table5["half_made"]=half_made.toList();
    table5["wiring"]=wiring.toList();
    table5["final_weight"]=final_weight.toList();
    table5["burnish_deficiency"]=burnish_deficiency.toList();



    tableData t = new tableData("تکمیل کارگاه 1", "", "", "","", "", jsonEncode(table5), "","","","");

    var respo = await AdminApi.postTable(t);

  }


}