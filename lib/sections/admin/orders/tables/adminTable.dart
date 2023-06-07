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
        'row': PlutoCell(value: 2020),
        'other': PlutoCell(value: 2020),
        'consumption_load': PlutoCell(value: 2020),
        'consumptions_load_and_others': PlutoCell(value: 2020),
        'after_melt': PlutoCell(value: 2020),
        'difference': PlutoCell(value: 2020),
        'after_paging': PlutoCell(value: 2020),
        'final_difference': PlutoCell(value: 2020),

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
      floatingActionButton: FloatingActionButton(onPressed: () {
        stateManager.insertRows(0, [
          PlutoRow(
            cells: {
              'row': PlutoCell(value: 2020),
              'other': PlutoCell(value: 2020),
              'consumption_load': PlutoCell(value: 2020),
              'consumptions_load_and_others': PlutoCell(value: 2020),
              'after_melt': PlutoCell(value: 2020),
              'difference': PlutoCell(value: 2020),
              'after_paging': PlutoCell(value: 2020),
              'final_difference': PlutoCell(value: 2020),

            },
          ),
        ]);
        print("gihiii");
        },child: const Icon(Icons.add)),

    );
  }


}
