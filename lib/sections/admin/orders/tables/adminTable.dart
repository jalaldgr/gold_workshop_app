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

    PlutoColumn(
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
        field: 'consumptions_load_and_others',
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
        'row': PlutoCell(value: 0),
        'other': PlutoCell(value: 0),
        'consumption_load': PlutoCell(value: 0),
        'consumptions_load_and_others': PlutoCell(value: 0),
        'after_melt': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'after_paging': PlutoCell(value: 0),
        'final_difference': PlutoCell(value: 0),

      },
    ),
  ];

  /// columnGroups that can group columns can be omitted.


  @override
  void initState() {

    super.initState();
  }

  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: PlutoGrid(
          columns: columns,
          rows: rows,

          onLoaded: (PlutoGridOnLoadedEvent event) {
            stateManager = event.stateManager;

            // stateManager.setShowColumnFilter(true);
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
              'consumptions_load_and_others': PlutoCell(value: 4),
              'after_melt': PlutoCell(value: 5),
              'difference': PlutoCell(value: 6),
              'after_paging': PlutoCell(value: 7),
              'final_difference': PlutoCell(value: 8),

            },
          ),
        ]);
        Map<String,dynamic> table1 ={};

        List rows = stateManager.rows.map((e) => e.cells['row']?.value).toList();
        List others = stateManager.rows.map((e) => e.cells['other']?.value).toList();
        List consumption_loads = stateManager.rows.map((e) => e.cells['consumption_load']?.value).toList();
        List consumptions_load_and_otherss = stateManager.rows.map((e) => e.cells['consumptions_load_and_others']?.value).toList();
        List after_melts = stateManager.rows.map((e) => e.cells['after_melt']?.value).toList();
        List differences = stateManager.rows.map((e) => e.cells['difference']?.value).toList();
        List after_pagings = stateManager.rows.map((e) => e.cells['after_paging']?.value).toList();
        List final_differences = stateManager.rows.map((e) => e.cells['final_difference']?.value).toList();

        table1["row"]=rows.toList();
        table1["others"]=others.toList();
        table1["consumption_loads"]=consumption_loads.toList();
        table1["consumption_loads"]=consumption_loads.toList();
        table1["consumptions_load_and_otherss"]=consumptions_load_and_otherss.toList();
        table1["after_melts"]=after_melts.toList();
        table1["differences"]=differences.toList();
        table1["differences"]=differences.toList();
        table1["after_pagings"]=after_pagings.toList();
        table1["final_differences"]=final_differences.toList();




        tableData t = new tableData("تکمیل کارگاه 1", table1.toString(), "table2", "table3", "table4", "table5", "table6");

       var respo = await AdminApi.postTable(t);
        },child: const Icon(Icons.add)),

    );
  }


}
