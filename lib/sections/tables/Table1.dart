import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';

class Table1Screen extends StatefulWidget {
  final Color headerColor;

  const Table1Screen({Key? key, required this.headerColor}) : super(key: key);

  @override
  _Table1ScreenState createState() => _Table1ScreenState();
}

class _Table1ScreenState extends State<Table1Screen> {
  TextEditingController fullNameController=TextEditingController();
  TextEditingController userNameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  List<DataRow> tableItem=[];


  List<PlutoColumn> columns = [

    PlutoColumn (
      title: 'ردیف',
      field: 'row',
      type: PlutoColumnType.number(),
        enableEditingMode: true,
      width: 70
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
        title: 'بار مصرفی',
        field: 'consumption_load',
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
        title: 'مجموع بار مصرفی و متفرقه',
        field: 'consumptions_load_and_other',
        type: PlutoColumnType.number(format: "#.###"),
        readOnly: true,
        width: 200,
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
        title: 'بعد از ذوب',
        field: 'after_melt',
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
        title: 'اختلاف',
        field: 'difference',
        type: PlutoColumnType.number(format: "#.###"),
        readOnly: true,
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
        title: 'بعد از صفحه گیری',
        field: 'after_paging',
        type: PlutoColumnType.number(format: "#.###"),
        enableEditingMode: true,
        width: 150,
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
        title: 'اختلاف نهایی',
        field: 'final_difference',
        type: PlutoColumnType.number(format: "#.###"),
        readOnly: true,
        width: 120,
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

  ];

  List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 1),
        'other': PlutoCell(value: 0),
        'consumption_load': PlutoCell(value: 0),
        'consumptions_load_and_other': PlutoCell(value: 0),
        'after_melt': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'after_paging': PlutoCell(value: 0),
        'final_difference': PlutoCell(value: 0),

      },
    ),
  ];

  /// columnGroups that can group columns can be omitted.
  fetchTable() async {

    var tables = await AdminApi.getTable();
    if(tables.table1!.length>10){
      stateManager.setShowLoading(true);
      dynamic table1 =json.decode(tables.table1!);
      List rowNumber = table1["row"];
      List other = table1["other"];
      List consumption_loads = table1["consumption_load"];
      List consumptions_load_and_other = table1["consumptions_load_and_other"];
      List after_melt = table1["after_melt"];
      List difference = table1["difference"];
      List after_paging = table1["after_paging"];
      List final_difference = table1["final_difference"];

      List<PlutoRow> updatedRows=[];
      for (var i = 0; i < rowNumber.length; i++) {
        updatedRows.add(PlutoRow(
          cells: {
            'row': PlutoCell(value:rowNumber[i] ),
            'other': PlutoCell(value: other[i]),
            'consumption_load': PlutoCell(value: consumption_loads[i]),
            'consumptions_load_and_other': PlutoCell(value: consumptions_load_and_other[i]),
            'after_melt': PlutoCell(value: after_melt[i]),
            'difference': PlutoCell(value: difference[i]),
            'after_paging': PlutoCell(value: after_paging[i]),
            'final_difference': PlutoCell(value: final_difference[i]),

          },
        ));
      }

      stateManager.refRows.clear();
      stateManager.insertRows(0, updatedRows);
      stateManager.setShowLoading(false);

    }
  }

  updateTable()async{
    Map<String,dynamic> table1 = {};

    List rows = stateManager.rows.map((e) => e.cells['row']?.value).toList();
    List others = stateManager.rows.map((e) => e.cells['other']?.value).toList();
    List consumption_loads = stateManager.rows.map((e) => e.cells['consumption_load']?.value).toList();
    List consumptions_load_and_others = stateManager.rows.map((e) => e.cells['consumptions_load_and_other']?.value).toList();
    List after_melts = stateManager.rows.map((e) => e.cells['after_melt']?.value).toList();
    List differences = stateManager.rows.map((e) => e.cells['difference']?.value).toList();
    List after_pagings = stateManager.rows.map((e) => e.cells['after_paging']?.value).toList();
    List final_differences = stateManager.rows.map((e) => e.cells['final_difference']?.value).toList();

    table1["row"]=rows.toList();
    table1["other"]=others.toList();
    table1["consumption_load"]=consumption_loads.toList();
    table1["consumption_load"]=consumption_loads.toList();
    table1["consumptions_load_and_other"]=consumptions_load_and_others.toList();
    table1["after_melt"]=after_melts.toList();
    table1["difference"]=differences.toList();
    table1["difference"]=differences.toList();
    table1["after_paging"]=after_pagings.toList();
    table1["final_difference"]=final_differences.toList();

    tableData t = new tableData("تکمیل کارگاه 1", jsonEncode(table1), "", "","", "", "", "","","","","");

    var respo = await AdminApi.postTable(t);
  }

  resetTable(){

    List<PlutoRow> updatedRows=[];
      updatedRows.add(PlutoRow(
        cells: {
          'row': PlutoCell(value: 1),
          'other': PlutoCell(value: 0),
          'consumption_load': PlutoCell(value: 0),
          'consumptions_load_and_other': PlutoCell(value: 0),
          'after_melt': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),
          'after_paging': PlutoCell(value: 0),
          'final_difference': PlutoCell(value: 0),

        },
      ));
    stateManager.refRows.clear();
    stateManager.insertRows(0, updatedRows);
    updateTable();
  }

  calculateTable() async {

    var tables = await AdminApi.getTable();
    dynamic table1 =json.decode(tables.table1!);
    dynamic table6 =json.decode(tables.table6!);
    dynamic table2 =json.decode(tables.table2!);

    table6["melt_deficiency"]=0;
    table2["export"][2]=0;

      stateManager.setShowLoading(true);
      List rows = stateManager.rows.map((e) => e.cells['row']?.value).toList();
      List others = stateManager.rows.map((e) => e.cells['other']?.value).toList();
      List consumption_loads = stateManager.rows.map((e) => e.cells['consumption_load']?.value).toList();
      List consumptions_load_and_others = stateManager.rows.map((e) => e.cells['consumptions_load_and_other']?.value).toList();
      List after_melts = stateManager.rows.map((e) => e.cells['after_melt']?.value).toList();
      List differences = stateManager.rows.map((e) => e.cells['difference']?.value).toList();
      List after_pagings = stateManager.rows.map((e) => e.cells['after_paging']?.value).toList();
      List final_differences = stateManager.rows.map((e) => e.cells['final_difference']?.value).toList();

      List<PlutoRow> updatedRows=[];
      for (var i = 0; i < rows.length; i++) {
        // update this table
        consumptions_load_and_others[i] = others[i]+consumption_loads[i];
        differences[i] = consumptions_load_and_others[i]-after_melts[i];
        final_differences[i] = others[i]-after_pagings[i];

        table1["row"][i] = rows[i];
        table1["other"][i] = others[i];
        table1["consumption_load"][i] = consumption_loads[i];
        table1["consumptions_load_and_other"][i] = consumptions_load_and_others[i];
        table1["after_melt"][i] = after_melts[i];
        table1["difference"][i] = differences[i];
        table1["after_paging"][i] = after_pagings[i];
        table1["final_difference"][i] = final_differences[i];
        //update other tables
        table2["export"][2]+=final_differences[i];
        table6["melt_deficiency"]+=final_differences[i];
        updatedRows.add(PlutoRow(
          cells: {
            'row': PlutoCell(value:rows[i] ),
            'other': PlutoCell(value: others[i]),
            'consumption_load': PlutoCell(value: consumption_loads[i]),
            'consumptions_load_and_other': PlutoCell(value: consumptions_load_and_others[i]),
            'after_melt': PlutoCell(value: after_melts[i]),
            'difference': PlutoCell(value: differences[i]),
            'after_paging': PlutoCell(value: after_pagings[i]),
            'final_difference': PlutoCell(value: final_differences[i]),

          },
        ));
      }


    stateManager.refRows.clear();
      stateManager.insertRows(0, updatedRows);
      stateManager.setShowLoading(false);



      tableData t = new tableData("تکمیل کارگاه 1",jsonEncode(table1), jsonEncode(table2), "","", "","",  jsonEncode(table6),"","","","");
      var respo = await AdminApi.postTable(t);
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
          IconButton(onPressed: (){
            deleteCurrentRowAlertDialog(context );
          }, icon: Icon(Icons.delete),tooltip: "حذف سطر انتخاب شده"),
          SizedBox(width: 16,),
          IconButton(onPressed: (){
            resetTableAlertDialog(context);
          }, icon: Icon(Icons.cleaning_services_rounded),tooltip: "پاکسازی جدول"),

        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:  Text('جدول 1   ${Jalali.now().formatFullDate()}',
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
            if(event.column.readOnly==false){
              calculateTable();
            }
          },
          configuration: const PlutoGridConfiguration(
              enterKeyAction: PlutoGridEnterKeyAction.editingAndMoveRight,
              style: PlutoGridStyleConfig(evenRowColor: Colors.black12,
                cellTextStyle: TextStyle(fontSize: 16),

              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(tooltip: "افزودن سطر جدید",onPressed: () async {
        stateManager.insertRows(stateManager.rows.length, [
          PlutoRow(
            cells: {
              'row': PlutoCell(value: 1+stateManager.rows.length),
              'other': PlutoCell(value: 0),
              'consumption_load': PlutoCell(value: 0),
              'consumptions_load_and_other': PlutoCell(value: 0),
              'after_melt': PlutoCell(value: 0),
              'difference': PlutoCell(value: 0),
              'after_paging': PlutoCell(value: 0),
              'final_difference': PlutoCell(value: 0),

            },
          ),
        ]);
        updateTable();



        },child: const Icon(Icons.add)),

    );
  }



  deleteCurrentRowAlertDialog(BuildContext context ) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("انصراف",style: TextStyle(color: Colors.red),),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = TextButton(
      child: Text("تایید",style: TextStyle(color: Colors.blue,fontSize: 20)),
      onPressed:  () async {
        stateManager.removeCurrentRow();
        updateTable();
        setState(()  {
          Navigator.of(context).pop();
        });

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("حذف سطر انتخاب شده"),
      content: Text("آیا از حذف این سطر اطمینان دارید؟"),
      actions: [
        Column(children: [
          Row(children: [
            Expanded(child: cancelButton ),
            Expanded(child: continueButton )
          ],)
        ],)

      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  resetTableAlertDialog(BuildContext context ) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("انصراف",style: TextStyle(color: Colors.red),),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = TextButton(
      child: Text("تایید",style: TextStyle(color: Colors.blue,fontSize: 20)),
      onPressed:  () async {
        resetTable();
        setState(()  {
          Navigator.of(context).pop();
        });

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("پاکسازی جدول"),
      content: Text("آیا از پاکسازی جدول اطمینان دارید؟"),
      actions: [
        Column(children: [
          Row(children: [
            Expanded(child: cancelButton ),
            Expanded(child: continueButton )
          ],)
        ],)

      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

