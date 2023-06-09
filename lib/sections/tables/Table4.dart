import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:pluto_grid/pluto_grid.dart';

class Table4Screen extends StatefulWidget {
  final Color headerColor;
  const Table4Screen({Key? key, required this.headerColor}) : super(key: key);

  @override
  _Table4ScreenState createState() => _Table4ScreenState();
}

class _Table4ScreenState extends State<Table4Screen> {

  late PlutoGridStateManager gridAStateManager;

  late PlutoGridStateManager gridBStateManager;

  List<PlutoColumn> gridAColumns = [

    PlutoColumn (
      title: 'ردیف',
      field: 'row',
      type: PlutoColumnType.number(),
        enableEditingMode: true,
      width: 100
    ),
    /// Select Column definition
    PlutoColumn(
        title: 'شرح',
        field: 'description',
        type: PlutoColumnType.select(['متفرقه','حلقه','مفتول','گوی','لحیم','زنجیر','تکه زنجیر','مدبر','کارساخت','سرسنجاق']),
        enableEditingMode: true,
        width: 100
    ),
    PlutoColumn(
        title: 'وزن ورودی',
        field: 'import_weight',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100
    ),
    PlutoColumn(
        title: 'توضیحات',
        field: 'summary',
        type: PlutoColumnType.text(),
        enableEditingMode: true,
        width: 300
    )
  ];

  List<PlutoColumn> gridBColumns = [
    PlutoColumn(
        title: 'شرح',
        field: 'description',
        type: PlutoColumnType.text(),
        enableEditingMode: true,
        width: 100
    ),
    PlutoColumn(
        title: 'مانده واقعی',
        field: 'real_balance',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100
    ),
    PlutoColumn(
        title: 'مانده سیستم',
        field: 'system_balance',
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
        title: 'توضیحات',
        field: 'summary',
        type: PlutoColumnType.text(),
        enableEditingMode: true,
        width: 100
    )
  ];

  List<PlutoRow> gridARows = [
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 1),
        'description': PlutoCell(value: 'متفرقه'),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 2),
        'description': PlutoCell(value: "حلقه"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 3),
        'description': PlutoCell(value: "مفتول"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 4),
        'description': PlutoCell(value: "گوی"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 5),
        'description': PlutoCell(value: "لحیم"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 6),
        'description': PlutoCell(value: "زنجیر"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 7),
        'description': PlutoCell(value: "تکه زنجیر"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 8),
        'description': PlutoCell(value: "مدبر"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 9),
        'description': PlutoCell(value: "کارساخت"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 10),
        'description': PlutoCell(value: "کارساخت"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 11),
        'description': PlutoCell(value: "کارساخت"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 12),
        'description': PlutoCell(value: "کارساخت"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 13),
        'description': PlutoCell(value: "متفرقه"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 14),
        'description': PlutoCell(value: "متفرقه"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 15),
        'description': PlutoCell(value: "متفرقه"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 16),
        'description': PlutoCell(value: "متفرقه"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 17),
        'description': PlutoCell(value: "متفرقه"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 18),
        'description': PlutoCell(value: "متفرقه"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 19),
        'description': PlutoCell(value: "متفرقه"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 20),
        'description': PlutoCell(value: "متفرقه"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 21),
        'description': PlutoCell(value: "سرسنجاق"),
        'import_weight': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
  ];

  List<PlutoRow> gridBRows = [
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "متفرقه"),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "حلقه"),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "مفتول"),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "گوی"),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "لحیم"),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "زنجیر"),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "تکه زنجیر"),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "مدبر"),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "کارساخت",),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "سرسنجاق"),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
  ];

  /// columnGroups that can group columns can be omitted.
  updateTable() async {
    var tables = await AdminApi.getTable();

    if(tables.table41!.length>10){
      gridAStateManager.setShowLoading(true);
      dynamic table1 =json.decode(tables.table41!);
      List rowNumber = table1["row"];
      List description = table1["description"];
      List import_weight = table1["import_weight"];
      List summary = table1["summary"];

      List<PlutoRow> updatedRows=[];
      for (var i = 0; i < rowNumber.length; i++) {
        updatedRows.add(PlutoRow(
          cells: {
            'row': PlutoCell(value:rowNumber[i] ),
            'description': PlutoCell(value: description[i]),
            'import_weight': PlutoCell(value: import_weight[i]),
            'summary': PlutoCell(value: summary[i]),
          },
        ));
      }

      gridAStateManager.refRows.clear();
      gridAStateManager.insertRows(0, updatedRows);
      gridAStateManager.setShowLoading(false);


    }


    if(tables.table42!.length>10){
      gridBStateManager.setShowLoading(true);
      dynamic table1 =json.decode(tables.table42!);
      List description = table1["description"];
      List real_balance = table1["real_balance"];
      List system_balance = table1["system_balance"];
      List difference = table1["difference"];
      List summary = table1["summary"];

      List<PlutoRow> updatedRows=[];
      for (var i = 0; i < description.length; i++) {
        updatedRows.add(PlutoRow(
          cells: {
            'description': PlutoCell(value:description[i] ),
            'real_balance': PlutoCell(value: real_balance[i]),
            'system_balance': PlutoCell(value: system_balance[i]),
            'difference': PlutoCell(value: difference[i]),
            'summary': PlutoCell(value: summary[i]),

          },
        ));
      }

      gridBStateManager.refRows.clear();
      gridBStateManager.insertRows(0, updatedRows);
      gridBStateManager.setShowLoading(false);


    }


  }

  @override
  void initState() {

    super.initState();
  }


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
        title: const Text('جدول 4',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 22.0)),
      ),
      body: PlutoDualGrid(
        gridPropsA: PlutoDualGridProps(
          columns: gridAColumns,
          rows: gridARows,
          createHeader:  (stateManager) => _Header(stateManager: stateManager),
          onSorted: (PlutoGridOnSortedEvent event) {
            print('Grid A : $event');
          },
          onLoaded: (PlutoGridOnLoadedEvent event) {
            gridAStateManager = event.stateManager;
            updateTable();
          },
        ),


         gridPropsB:
         PlutoDualGridProps(
           columns: gridBColumns,
           rows: gridBRows,
           onSorted: (PlutoGridOnSortedEvent event) {
             print('Grid B : $event');
           },
           onLoaded: (PlutoGridOnLoadedEvent event) {
             gridBStateManager = event.stateManager;
           },


         )

        ,),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        gridAStateManager.insertRows(gridAStateManager.rows.length, [
          PlutoRow(
            cells: {
              'row': PlutoCell(value: gridAStateManager.rows.length+1),
              'description': PlutoCell(value: 'متفرقه'),
              'import_weight': PlutoCell(value: 0),
              'summary': PlutoCell(value: ""),


            },
          ),
        ]);
        Map<String,dynamic> table41 = {};
        List row = gridAStateManager.rows.map((e) => e.cells['row']?.value).toList();
        List description = gridAStateManager.rows.map((e) => e.cells['description']?.value).toList();
        List import_weight = gridAStateManager.rows.map((e) => e.cells['import_weight']?.value).toList();
        List summary = gridAStateManager.rows.map((e) => e.cells['summary']?.value).toList();
        table41["row"]=row.toList();
        table41["description"]=description.toList();
        table41["import_weight"]=import_weight.toList();
        table41["summary"]=summary.toList();
        tableData t = new tableData("تکمیل کارگاه 1", "", "", "",jsonEncode(table41), "", "", "");
        var respo = await AdminApi.postTable(t);



        Map<String,dynamic> table42 = {};
        List description42 = gridBStateManager.rows.map((e) => e.cells['description']?.value).toList();
        List real_balance = gridBStateManager.rows.map((e) => e.cells['real_balance']?.value).toList();
        List system_balance = gridBStateManager.rows.map((e) => e.cells['system_balance']?.value).toList();
        List difference = gridBStateManager.rows.map((e) => e.cells['difference']?.value).toList();
        List summary42 = gridBStateManager.rows.map((e) => e.cells['summary']?.value).toList();
        table42["description"]=description42.toList();
        table42["real_balance"]=real_balance.toList();
        table42["system_balance"]=system_balance.toList();
        table42["difference"]=difference.toList();
        table42["summary"]=summary42.toList();
        tableData t42 = new tableData("تکمیل کارگاه 1", "", "", "","", jsonEncode(table42), "", "");
        var respo42 = await AdminApi.postTable(t42);

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