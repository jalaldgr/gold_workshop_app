import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';

class Table3Screen extends StatefulWidget {
  final Color headerColor;
  const Table3Screen({Key? key, required this.headerColor}) : super(key: key);

  @override
  _Table3ScreenState createState() => _Table3ScreenState();
}

class _Table3ScreenState extends State<Table3Screen> {

  List<PlutoColumn> columns = [

    PlutoColumn (
        title: 'شرح',
        field: 'description',
        type: PlutoColumnType.select(['متفرقه','حلقه','مفتول','گوی','لحیم','زنجیر','تکه زنجیر','مدبر','کارساخت']),
        enableEditingMode: true,
        width: 100
    ),
    /// Select Column definition
    PlutoColumn(
      title: 'متفرقه',
      field: 'other',
      type: PlutoColumnType.number(format: "#.###"),
      enableEditingMode: true,
      width: 100,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          format: "#.###",
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(
                text: 'جمع',
                style: TextStyle(color: Colors.red),
              ),
              const TextSpan(text: ' : '),
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'حلقه',
      field: 'ring',
      type: PlutoColumnType.number(format: "#.###"),
      enableEditingMode: true,
      width: 100,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          format: "#.###",
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'مفتول',
      field: 'wire',
      type: PlutoColumnType.number(format: "#.###"),
      enableEditingMode: true,
      width: 100,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          format: "#.###",
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'گوی',
      field: 'ball',
      type: PlutoColumnType.number(format: "#.###"),
      enableEditingMode: true,
      width: 100,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          format: "#.###",
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'لحیم',
      field: 'solder',
      type: PlutoColumnType.number(format: "#.###"),
      enableEditingMode: true,
      width: 100,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          format: "#.###",
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'زنجیر',
      field: 'chain',
      type: PlutoColumnType.number(format: "#.###"),
      enableEditingMode: true,
      width: 100,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          format: "#.###",
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'تکه زنجیر',
      field: 'piece_chain',
      type: PlutoColumnType.number(format: "#.###"),
      enableEditingMode: true,
      width: 100,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          format: "#.###",
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'مدبر',
      field: 'lock',
      type: PlutoColumnType.number(format: "#.###"),
      enableEditingMode: true,
      width: 100,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          format: "#.###",
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'کارساخت',
      field: 'work_made',
      type: PlutoColumnType.number(format: "#.###"),
      enableEditingMode: true,
      width: 100,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          format: "#.###",
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
    PlutoColumn(
      title: 'مجموع',
      field: 'sum',
      type: PlutoColumnType.number(),
      enableEditingMode: true,
      width: 100,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          format: "#.###",
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              TextSpan(text: text),
            ];
          },
        );
      },
    )


  ];

  List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'description': PlutoCell(value: 'متفرقه'),
        'other': PlutoCell(value: 0),
        'ring': PlutoCell(value: 0),
        'wire': PlutoCell(value: 0),
        'ball': PlutoCell(value: 0),
        'solder': PlutoCell(value: 0),
        'chain': PlutoCell(value: 0),
        'piece_chain': PlutoCell(value: 0),
        'lock': PlutoCell(value: 0),
        'work_made': PlutoCell(value: 0),
        'sum': PlutoCell(value: 0),


      },
    ),
  ];

  /// columnGroups that can group columns can be omitted.
  updateTable() async {
    Map<String,dynamic> table3 = {};

    List description = stateManager.rows.map((e) => e.cells['description']?.value).toList();
    List other = stateManager.rows.map((e) => e.cells['other']?.value).toList();
    List ring = stateManager.rows.map((e) => e.cells['ring']?.value).toList();
    List wire = stateManager.rows.map((e) => e.cells['wire']?.value).toList();
    List ball = stateManager.rows.map((e) => e.cells['ball']?.value).toList();
    List solder = stateManager.rows.map((e) => e.cells['solder']?.value).toList();
    List chain = stateManager.rows.map((e) => e.cells['chain']?.value).toList();
    List piece_chain = stateManager.rows.map((e) => e.cells['piece_chain']?.value).toList();
    List lock = stateManager.rows.map((e) => e.cells['lock']?.value).toList();
    List work_made = stateManager.rows.map((e) => e.cells['work_made']?.value).toList();
    List sum = stateManager.rows.map((e) => e.cells['sum']?.value).toList();


    table3["description"]=description.toList();
    table3["other"]=other.toList();
    table3["ring"]=ring.toList();
    table3["wire"]=wire.toList();
    table3["ball"]=ball.toList();
    table3["solder"]=solder.toList();
    table3["chain"]=chain.toList();
    table3["piece_chain"]=piece_chain.toList();
    table3["lock"]=lock.toList();
    table3["work_made"]=work_made.toList();
    table3["sum"]=sum.toList();

    tableData t = new tableData("تکمیل کارگاه 2", "", "", jsonEncode(table3), "","", "", "","","","","");

    var respo = await AdminApi.postTable(t);

  }

  fetchTable() async {


    var tables = await AdminApi.getTable();
    if(tables.table3!.length>10){
      stateManager.setShowLoading(true);
      dynamic table3 =json.decode(tables.table3!);
      List description = table3["description"];
      List other = table3["other"];
      List ring = table3["ring"];
      List wire = table3["wire"];
      List ball = table3["ball"];
      List solder = table3["solder"];
      List chain = table3["chain"];
      List piece_chain = table3["piece_chain"];
      List lock = table3["lock"];
      List work_made = table3["work_made"];
      List sum = table3["sum"];

      List<PlutoRow> updatedRows=[];
      for (var i = 0; i < description.length; i++) {
        updatedRows.add(PlutoRow(
          cells: {
            'description': PlutoCell(value:description[i] ),
            'other': PlutoCell(value: other[i]),
            'ring': PlutoCell(value: ring[i]),
            'wire': PlutoCell(value: wire[i]),
            'ball': PlutoCell(value: ball[i]),
            'solder': PlutoCell(value: solder[i]),
            'chain': PlutoCell(value: chain[i]),
            'piece_chain': PlutoCell(value: piece_chain[i]),
            'lock': PlutoCell(value: lock[i]),
            'work_made': PlutoCell(value: work_made[i]),
            'sum': PlutoCell(value: sum[i]),
          },
        ));
      }

      stateManager.refRows.clear();
      stateManager.insertRows(0, updatedRows);
      stateManager.setShowLoading(false);
    }
  }


  calculateTable()async{

    List description = stateManager.rows.map((e) => e.cells['description']?.value).toList();
    List other = stateManager.rows.map((e) => e.cells['other']?.value).toList();
    List ring = stateManager.rows.map((e) => e.cells['ring']?.value).toList();
    List wire = stateManager.rows.map((e) => e.cells['wire']?.value).toList();
    List ball = stateManager.rows.map((e) => e.cells['ball']?.value).toList();
    List solder = stateManager.rows.map((e) => e.cells['solder']?.value).toList();
    List chain = stateManager.rows.map((e) => e.cells['chain']?.value).toList();
    List piece_chain = stateManager.rows.map((e) => e.cells['piece_chain']?.value).toList();
    List lock = stateManager.rows.map((e) => e.cells['lock']?.value).toList();
    List work_made = stateManager.rows.map((e) => e.cells['work_made']?.value).toList();
    List sum = stateManager.rows.map((e) => e.cells['sum']?.value).toList();

    List<PlutoRow> updatedRows=[];
      for (var i = 0; i < description.length; i++) {

        if(stateManager.rows[i].cells["other"]?.column.title==description[i]){
          var summ = ring[i] + wire[i] + ball[i] + solder[i] + chain[i] + piece_chain[i] + lock[i] + work_made[i];
          sum[i]=summ;
          other[i] = summ*-1;
        }else if(stateManager.rows[i].cells["ring"]?.column.title==description[i]){
          var summ = other[i] + wire[i] + ball[i] + solder[i] + chain[i] + piece_chain[i] + lock[i] + work_made[i];
          sum[i]=summ;
          ring[i] = summ*-1;
        }else if(stateManager.rows[i].cells["wire"]?.column.title==description[i]){
          var summ = ring[i] + other[i] + ball[i] + solder[i] + chain[i] + piece_chain[i] + lock[i] + work_made[i];
          sum[i]=summ;
          wire[i] = summ*-1;
        }else if(stateManager.rows[i].cells["ball"]?.column.title==description[i]){
          var summ = ring[i] + wire[i] + other[i] + solder[i] + chain[i] + piece_chain[i] + lock[i] + work_made[i];
          sum[i]=summ;
          ball[i] = summ*-1;
        }else if(stateManager.rows[i].cells["solder"]?.column.title==description[i]){
          var summ = ring[i] + wire[i] + ball[i] + other[i] + chain[i] + piece_chain[i] + lock[i] + work_made[i];
          sum[i]=summ;
          solder[i] = summ*-1;
        }else if(stateManager.rows[i].cells["chain"]?.column.title==description[i]){
          var summ = ring[i] + wire[i] + ball[i] + solder[i] + other[i] + piece_chain[i] + lock[i] + work_made[i];
          sum[i]=summ;
          chain[i] = summ*-1;
        }else if(stateManager.rows[i].cells["piece_chain"]?.column.title==description[i]){
          var summ = ring[i] + wire[i] + ball[i] + solder[i] + chain[i] + other[i] + lock[i] + work_made[i];
          sum[i]=summ;
          piece_chain[i] = summ*-1;
        }else if(stateManager.rows[i].cells["lock"]?.column.title==description[i]){
          var summ = ring[i] + wire[i] + ball[i] + solder[i] + chain[i] + piece_chain[i] + other[i] + work_made[i];
          sum[i]=summ;
          lock[i] = summ*-1;
        }else if(stateManager.rows[i].cells["work_made"]?.column.title==description[i]){
          var summ = ring[i] + wire[i] + ball[i] + solder[i] + chain[i] + piece_chain[i] + lock[i] + other[i];
          sum[i]=summ;
          work_made[i] = summ*-1;
        }


        updatedRows.add(PlutoRow(
          cells: {
            'description': PlutoCell(value:description[i] ),
            'other': PlutoCell(value: other[i]),
            'ring': PlutoCell(value: ring[i]),
            'wire': PlutoCell(value: wire[i]),
            'ball': PlutoCell(value: ball[i]),
            'solder': PlutoCell(value: solder[i]),
            'chain': PlutoCell(value: chain[i]),
            'piece_chain': PlutoCell(value: piece_chain[i]),
            'lock': PlutoCell(value: lock[i]),
            'work_made': PlutoCell(value: work_made[i]),
            'sum': PlutoCell(value: sum[i]),
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
        actions: [
          SizedBox(width: 32,),
          IconButton(onPressed: (){
            setState(() {
              stateManager.removeCurrentRow();
              updateTable();
            });

            }, icon: Icon(Icons.delete),tooltip: "حذف سطر انتخاب شده"),

        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:  Text('جدول 3   ${Jalali.now().formatFullDate()}',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 22.0)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Container(
        padding: const EdgeInsets.all(15),
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;

            fetchTable();
            calculateTable();
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            calculateTable();
            updateTable();
          },
          configuration: const PlutoGridConfiguration(
              enterKeyAction: PlutoGridEnterKeyAction.editingAndMoveRight,

              style: PlutoGridStyleConfig(evenRowColor: Colors.black12,
                cellTextStyle: TextStyle(fontSize: 16),

              )),        ),
      ),
      floatingActionButton: FloatingActionButton(tooltip: "افزودن سطر جدید",
          onPressed: () async {
        stateManager.insertRows(stateManager.rows.length, [
          PlutoRow(
            cells: {
              'description': PlutoCell(value: 'متفرقه'),
              'other': PlutoCell(value: 0),
              'ring': PlutoCell(value: 0),
              'wire': PlutoCell(value: 0),
              'ball': PlutoCell(value: 0),
              'solder': PlutoCell(value: 0),
              'chain': PlutoCell(value: 0),
              'piece_chain': PlutoCell(value: 0),
              'lock': PlutoCell(value: 0),
              'work_made': PlutoCell(value: 0),
              'sum': PlutoCell(value: 0),


            },
          ),
        ]);
        updateTable();
      },child: const Icon(Icons.add)),

    );
  }

}

