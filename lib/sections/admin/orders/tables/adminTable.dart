import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:pluto_grid/pluto_grid.dart';

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


  List<PlutoColumn> columns = [

    PlutoColumn (
      title: 'ردیف',
      field: 'row',
      type: PlutoColumnType.number(),
        enableEditingMode: true,
      width: 100

    ),
    /// Select Column definition
    PlutoColumn(
        title: 'متفرقه',
        field: 'other',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100


    ),
    PlutoColumn(
        title: 'بار مصرفی',
        field: 'consumption_load',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100


    ),
    PlutoColumn(
        title: 'مجموع بار مصرفی و متفرقه',
        field: 'consumptions_load_and_other',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 200


    ),
    PlutoColumn(
        title: 'بعد از ذوب',
        field: 'after_melt',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100


    ),
    PlutoColumn(
        title: 'اختلاف',
        field: 'difference',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100


    ),
    PlutoColumn(
        title: 'بعد از صفحه گیری',
        field: 'after_paging',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 150


    ),
    PlutoColumn(
        title: 'اختلاف نهایی',
        field: 'final_difference',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 120


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
  updateTable() async {
    stateManager.setShowLoading(true);
    var tables = await AdminApi.getTable();
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
        backgroundColor: Colors.pink,
        actions: [IconButton(onPressed: (){updateTable();}, icon: Icon(Icons.refresh))],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('جدول 1',
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

          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;

            updateTable();
          },
          onChanged: (PlutoGridOnChangedEvent event) {
            print(event);
          },
          configuration: const PlutoGridConfiguration(style: PlutoGridStyleConfig()),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        stateManager.insertRows(stateManager.rows.length, [
          PlutoRow(
            cells: {
              'row': PlutoCell(value: 1+stateManager.rows.length),
              'other': PlutoCell(value: 2),
              'consumption_load': PlutoCell(value: 3),
              'consumptions_load_and_other': PlutoCell(value: 4),
              'after_melt': PlutoCell(value: 5),
              'difference': PlutoCell(value: 6),
              'after_paging': PlutoCell(value: 7),
              'final_difference': PlutoCell(value: 8),

            },
          ),
        ]);
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

        tableData t = new tableData("تکمیل کارگاه 1", jsonEncode(table1), "table2", "table3", "table4", "table5", "table6");

        var respo = await AdminApi.postTable(t);


        },child: const Icon(Icons.add)),

    );
  }


}
