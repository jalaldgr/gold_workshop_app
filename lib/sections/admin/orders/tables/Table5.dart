import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:pluto_grid/pluto_grid.dart';

class Table5Screen extends StatefulWidget {
  const Table5Screen({Key? key}) : super(key: key);

  @override
  _Table5ScreenState createState() => _Table5ScreenState();
}

class _Table5ScreenState extends State<Table5Screen> {
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
        title: 'سفارش دهنده',
        field: 'client_name',
        type: PlutoColumnType.text(),
        enableEditingMode: true,
        width: 100


    ),

  ];

  List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 1),
        'client_name': PlutoCell(value: ""),


      },
    ),
  ];

  /// columnGroups that can group columns can be omitted.
  updateTable() async {


    var tables = await AdminApi.getTable();
    if(tables.table5!.length>10){
      stateManager.setShowLoading(true);
      dynamic table5 =json.decode(tables.table5!);
      List rowNumber = table5["row"];
      List client_name = table5["client_name"];

      List<PlutoRow> updatedRows=[];
      for (var i = 0; i < rowNumber.length; i++) {
        updatedRows.add(PlutoRow(
          cells: {
            'row': PlutoCell(value:rowNumber[i] ),
            'client_name': PlutoCell(value: client_name[i]),
          },
        ));
      }

      stateManager.refRows.clear();
      stateManager.insertRows(0, updatedRows);
      stateManager.setShowLoading(false);


    }


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
              'client_name': PlutoCell(value: 0),
            },
          ),
        ]);
        Map<String,dynamic> table5 = {};

        List rows = stateManager.rows.map((e) => e.cells['row']?.value).toList();
        List client_name = stateManager.rows.map((e) => e.cells['client_name']?.value).toList();


        table5["row"]=rows.toList();
        table5["client_name"]=client_name.toList();


        tableData t = new tableData("تکمیل کارگاه 1", "", "", "","", "", jsonEncode(table5), "");

        var respo = await AdminApi.postTable(t);


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
  }



  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: handleRemoveCurrentRowButton,
      child: const Text('حذف سطر انتخاب شده',style: TextStyle(color: Colors.black),),
    );
  }
}