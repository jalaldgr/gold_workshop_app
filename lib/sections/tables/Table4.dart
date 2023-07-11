import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
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
        width: 70
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
      type: PlutoColumnType.number( format: "#.###"),
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
      title: 'مانده دیروز',
      field: 'yesterday_balance',
      type: PlutoColumnType.number( format: "#.###"),
      enableEditingMode: true,
      width: 120,
      readOnly: true,
      backgroundColor: Colors.amberAccent,
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
      title: 'مانده واقعی',
      field: 'real_balance',
      type: PlutoColumnType.number( format: "#.###"),
      enableEditingMode: true,
      width: 120,
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          format: "#.###",
          rendererContext: rendererContext,
          type: PlutoAggregateColumnType.sum,
          alignment: Alignment.center,
        );
      },
    ),
    PlutoColumn(
      title: 'مانده سیستم',
      field: 'system_balance',
      type: PlutoColumnType.number( format: "#.###"),
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
    PlutoColumn(
      title: 'اختلاف',
      field: 'difference',
      type: PlutoColumnType.number( format: "#.###"),
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
        'yesterday_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "حلقه"),
        'yesterday_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "مفتول"),
        'yesterday_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "گوی"),
        'yesterday_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "لحیم"),
        'yesterday_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "زنجیر"),
        'yesterday_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "تکه زنجیر"),
        'yesterday_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "مدبر"),
        'yesterday_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "کارساخت",),
        'yesterday_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
    PlutoRow(
      cells: {
        'description': PlutoCell(value: "سرسنجاق"),
        'yesterday_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'system_balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),
        'summary': PlutoCell(value: ""),
      },
    ),
  ];
  updateTable() async {
    Map<String,dynamic> table41 = {};
    List row = gridAStateManager.rows.map((e) => e.cells['row']?.value).toList();
    List description = gridAStateManager.rows.map((e) => e.cells['description']?.value).toList();
    List import_weight = gridAStateManager.rows.map((e) => e.cells['import_weight']?.value).toList();
    List summary = gridAStateManager.rows.map((e) => e.cells['summary']?.value).toList();
    table41["row"]=row.toList();
    table41["description"]=description.toList();
    table41["import_weight"]=import_weight.toList();
    table41["summary"]=summary.toList();
    tableData t = new tableData("تکمیل کارگاه 1", "", "", "",jsonEncode(table41), "", "", "","","","","");
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
    tableData t42 = new tableData("تکمیل کارگاه 1", "", "", "","", jsonEncode(table42), "", "","","","","");
    var respo42 = await AdminApi.postTable(t42);
  }

  fetchTable() async {
    var tables = await AdminApi.getTable();
    var yesterdayTables = await AdminApi.getYesterdayTable4Balance();

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
      dynamic yesterdayTablesJson = json.decode(yesterdayTables.table42!);

      gridBStateManager.setShowLoading(true);
      dynamic table1 =json.decode(tables.table42!);
      List description = table1["description"];
      List real_balance = table1["real_balance"];
      List yesterday_balance = yesterdayTablesJson["real_balance"];
      List system_balance = table1["system_balance"];
      List difference = table1["difference"];
      List summary = table1["summary"];

      List<PlutoRow> updatedRows=[];
      for (var i = 0; i < description.length; i++) {
        updatedRows.add(PlutoRow(
          cells: {
            'description': PlutoCell(value:description[i] ),
            'yesterday_balance': PlutoCell(value: yesterday_balance[i]),
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

  calculateTableB()async{
    var tables = await AdminApi.getTable();
    dynamic table41 =json.decode(tables.table41!);
    dynamic table42 =json.decode(tables.table42!);

    List description42 = gridBStateManager.rows.map((e) => e.cells['description']?.value).toList();
    List yesterday_balance = gridBStateManager.rows.map((e) => e.cells['yesterday_balance']?.value).toList();
    List real_balance = gridBStateManager.rows.map((e) => e.cells['real_balance']?.value).toList();
    List system_balance = gridBStateManager.rows.map((e) => e.cells['system_balance']?.value).toList();
    List difference = gridBStateManager.rows.map((e) => e.cells['difference']?.value).toList();
    List summary42 = gridBStateManager.rows.map((e) => e.cells['summary']?.value).toList();
    table42["description"]=description42.toList();
    table42["real_balance"]=real_balance.toList();
    table42["system_balance"]=system_balance.toList();
    table42["difference"]=difference.toList();
    table42["summary"]=summary42.toList();
    List<PlutoRow> updatedRows=[];
    for (var i = 0; i < description42.length; i++) {
      difference[i] = real_balance[i] - system_balance[i];
      updatedRows.add(PlutoRow(
        cells: {
          'description': PlutoCell(value:description42[i] ),
          'yesterday_balance': PlutoCell(value: yesterday_balance[i]),
          'real_balance': PlutoCell(value: real_balance[i]),
          'system_balance': PlutoCell(value: system_balance[i]),
          'difference': PlutoCell(value: difference[i]),
          'summary': PlutoCell(value: summary42[i]),

        },
      ));
    }
    gridBStateManager.refRows.clear();
    gridBStateManager.insertRows(0, updatedRows);
    gridBStateManager.setShowLoading(false);

    tableData t = new tableData("تکمیل کارگاه 1","","", "", jsonEncode(table41),jsonEncode(table42),"", "","","","","");
    var respo = await AdminApi.postTable(t);



  }

  resetTable(){


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
          'yesterday_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'system_balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),
          'summary': PlutoCell(value: ""),
        },
      ),
      PlutoRow(
        cells: {
          'description': PlutoCell(value: "حلقه"),
          'yesterday_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'system_balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),
          'summary': PlutoCell(value: ""),
        },
      ),
      PlutoRow(
        cells: {
          'description': PlutoCell(value: "مفتول"),
          'yesterday_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'system_balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),
          'summary': PlutoCell(value: ""),
        },
      ),
      PlutoRow(
        cells: {
          'description': PlutoCell(value: "گوی"),
          'yesterday_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'system_balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),
          'summary': PlutoCell(value: ""),
        },
      ),
      PlutoRow(
        cells: {
          'description': PlutoCell(value: "لحیم"),
          'yesterday_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'system_balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),
          'summary': PlutoCell(value: ""),
        },
      ),
      PlutoRow(
        cells: {
          'description': PlutoCell(value: "زنجیر"),
          'yesterday_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'system_balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),
          'summary': PlutoCell(value: ""),
        },
      ),
      PlutoRow(
        cells: {
          'description': PlutoCell(value: "تکه زنجیر"),
          'yesterday_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'system_balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),
          'summary': PlutoCell(value: ""),
        },
      ),
      PlutoRow(
        cells: {
          'description': PlutoCell(value: "مدبر"),
          'yesterday_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'system_balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),
          'summary': PlutoCell(value: ""),
        },
      ),
      PlutoRow(
        cells: {
          'description': PlutoCell(value: "کارساخت",),
          'yesterday_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'system_balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),
          'summary': PlutoCell(value: ""),
        },
      ),
      PlutoRow(
        cells: {
          'description': PlutoCell(value: "سرسنجاق"),
          'yesterday_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'system_balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),
          'summary': PlutoCell(value: ""),
        },
      ),
    ];

    gridBStateManager.refRows.clear();
    gridBStateManager.insertRows(0, gridBRows);

    gridAStateManager.refRows.clear();
    gridAStateManager.insertRows(0, gridARows);
    fetchTable();
    updateTable();
  }

  calculateTableA()async{
    var tables = await AdminApi.getTable();
    dynamic table41 =json.decode(tables.table41!);
    dynamic table42 =json.decode(tables.table42!);
    dynamic table3 =json.decode(tables.table3!);
    dynamic table5 =json.decode(tables.table5!);

    dynamic cutSumTable5=0;
    dynamic meltingSumTable5=0;
    dynamic popionSumTable5=0;
    dynamic ringSumTable5=0;
    dynamic chainSumTable5=0;
    dynamic piece_chainSumTable5=0;
    dynamic caneSumTable5=0;
    dynamic lockSumTable5=0;
    dynamic wireSumTable5=0;
    dynamic solderSumTable5=0;
    dynamic ballSumTable5=0;
    dynamic pinSumTable5=0;
    dynamic ring2SumTable5=0;
    dynamic half_madeSumTable5=0;
    dynamic wiringSumTable5=0;
    dynamic final_weightSumTable5=0;
    dynamic burnish_deficiencySumTable5=0;
    List cutListTable5=table5["cut"];
    List meltingListTable5=table5["melting"];
    List popionListTable5=table5["popion"];
    List ringListTable5=table5["ring"];
    List chainListTable5=table5["chain"];
    List piece_chainListTable5=table5["piece_chain"];
    List caneListTable5=table5["cane"];
    List lockListTable5=table5["lock"];
    List wireListTable5=table5["wire"];
    List solderListTable5=table5["solder"];
    List ballListTable5=table5["ball"];
    List pinListTable5=table5["pin"];
    List ring2ListTable5=table5["ring2"];
    List half_madeListTable5=table5["half_made"];
    List wiringListTable5=table5["wiring"];
    List final_weightListTable5=table5["final_weight"];
    List burnish_deficiencyListTable5=table5["burnish_deficiency"];

    cutListTable5.forEach((element) {cutSumTable5+=element;});
    popionListTable5.forEach((element) {popionSumTable5+=element;});
    ringListTable5.forEach((element) {ringSumTable5+=element;});
    chainListTable5.forEach((element) {chainSumTable5+=element;});
    piece_chainListTable5.forEach((element) {piece_chainSumTable5+=element;});
    caneListTable5.forEach((element) {caneSumTable5+=element;});
    lockListTable5.forEach((element) {lockSumTable5+=element;});
    wireListTable5.forEach((element) {wireSumTable5+=element;});
    solderListTable5.forEach((element) {solderSumTable5+=element;});
    ballListTable5.forEach((element) {ballSumTable5+=element;});
    pinListTable5.forEach((element) {pinSumTable5+=element;});
    ring2ListTable5.forEach((element) {ring2SumTable5+=element;});
    half_madeListTable5.forEach((element) {half_madeSumTable5+=element;});
    wiringListTable5.forEach((element) {wiringSumTable5+=element;});
    final_weightListTable5.forEach((element) {final_weightSumTable5+=element;});
    burnish_deficiencyListTable5.forEach((element) {burnish_deficiencySumTable5;});
    meltingListTable5.forEach((element) {meltingSumTable5+=element;});


    dynamic descriptionSumTable3=0;
    dynamic otherSumTable3=0;
    dynamic ringSumTable3=0;
    dynamic wireSumTable3=0;
    dynamic ballSumTable3=0;
    dynamic solderSumTable3=0;
    dynamic chainSumTable3=0;
    dynamic piece_chainSumTable3=0;
    dynamic lockSumTable3=0;
    dynamic work_madeSumTable3=0;

    List descriptionListTable3=table3["description"];
    List otherListTable3=table3["other"];
    List ringListTable3=table3["ring"];
    List wireListTable3=table3["wire"];
    List ballListTable3=table3["ball"];
    List solderListTable3=table3["solder"];
    List chainListTable3=table3["chain"];
    List piece_chainListTable3=table3["piece_chain"];
    List lockListTable3=table3["lock"];
    List work_madeListTable3=table3["work_made"];

    otherListTable3.forEach((element) {otherSumTable3+=element;});
    ringListTable3.forEach((element) {ringSumTable3+=element;});
    wireListTable3.forEach((element) {wireSumTable3+=element;});
    ballListTable3.forEach((element) {ballSumTable3+=element;});
    solderListTable3.forEach((element) {solderSumTable3+=element;});
    chainListTable3.forEach((element) {chainSumTable3+=element;});
    piece_chainListTable3.forEach((element) {piece_chainSumTable3+=element;});
    lockListTable3.forEach((element) {lockSumTable3+=element;});
    work_madeListTable3.forEach((element) {work_madeSumTable3+=element;});
    if(otherSumTable3<0)otherSumTable3=otherSumTable3*-1;
    if(ringSumTable3<0)ringSumTable3=ringSumTable3*-1;
    if(wireSumTable3<0)wireSumTable3=wireSumTable3*-1;
    if(ballSumTable3<0)ballSumTable3=ballSumTable3*-1;
    if(solderSumTable3<0)solderSumTable3=solderSumTable3*-1;
    if(chainSumTable3<0)chainSumTable3=chainSumTable3*-1;
    if(piece_chainSumTable3<0)piece_chainSumTable3=piece_chainSumTable3*-1;
    if(lockSumTable3<0)lockSumTable3=lockSumTable3*-1;
    if(work_madeSumTable3<0)work_madeSumTable3=work_madeSumTable3*-1;



    List row = gridAStateManager.rows.map((e) => e.cells['row']?.value).toList();
    List description = gridAStateManager.rows.map((e) => e.cells['description']?.value).toList();
    List import_weight = gridAStateManager.rows.map((e) => e.cells['import_weight']?.value).toList();
    List summary = gridAStateManager.rows.map((e) => e.cells['summary']?.value).toList();
    List<PlutoRow> updatedRows=[];
    for (var i = 0; i < row.length; i++) {
      updatedRows.add(PlutoRow(
        cells: {
          'row': PlutoCell(value:row[i] ),
          'description': PlutoCell(value: description[i]),
          'import_weight': PlutoCell(value: import_weight[i]),
          'summary': PlutoCell(value: summary[i]),
        },
      ));
      //update table41
      table41["row"][i]=row[i];
      table41["description"][i]=description[i];
      table41["import_weight"][i]=import_weight[i];
      table41["summary"][i]=summary[i];
    }



    gridAStateManager.refRows.clear();
    gridAStateManager.insertRows(0, updatedRows);



    List description42 = gridBStateManager.rows.map((e) => e.cells['description']?.value).toList();
    List yesterday_balance = gridBStateManager.rows.map((e) => e.cells['yesterday_balance']?.value).toList();
    List real_balance = gridBStateManager.rows.map((e) => e.cells['real_balance']?.value).toList();
    List system_balance = gridBStateManager.rows.map((e) => e.cells['system_balance']?.value).toList();
    List difference = gridBStateManager.rows.map((e) => e.cells['difference']?.value).toList();
    List summary42 = gridBStateManager.rows.map((e) => e.cells['summary']?.value).toList();
    table42["description"]=description42.toList();
    table42["yesterday_balance"]=yesterday_balance.toList();
    table42["real_balance"]=real_balance.toList();
    table42["system_balance"]=system_balance.toList();
    table42["difference"]=difference.toList();
    table42["summary"]=summary42.toList();
    List<PlutoRow> updatedRows42=[];
    for (var i = 0; i < description42.length; i++) {
      if(table42["description"][i]=="متفرقه"){
        system_balance[i]=otherSumTable3 +import_weight[i] - (popionSumTable5 + wiringSumTable5 + meltingSumTable5+cutSumTable5);
      }
      if(table42["description"][i]=="حلقه"){
        print("her is weight  ${import_weight[i]} and balance${system_balance[i]} and ring sum 3 ${ringSumTable3}");
        system_balance[i] =import_weight[i] + ringSumTable3 - ringSumTable5;
        print("her is ${system_balance[i]}");

      }
      if(table42["description"][i]=="مفتول"){
        system_balance[i]=import_weight[i]+wireSumTable3- (caneSumTable5  + wireSumTable5 + pinSumTable5);
      }
      if(table42["description"][i]=="گوی"){
        system_balance[i] = import_weight[i]+ballSumTable3-ballSumTable5;
      }
      if(table42["description"][i]=="لحیم"){
        system_balance[i] =import_weight[i] +solderSumTable3-solderSumTable5;
      }
      if(table42["description"][i]=="زنجیر"){
        system_balance[i] =import_weight[i] + chainSumTable3 - chainSumTable5;
      }
      if(table42["description"][i]=="تکه زنجیر"){
        system_balance[i] =import_weight[i] + piece_chainSumTable3 - piece_chainSumTable5;
      }
      if(table42["description"][i]=="مدبر"){
        system_balance[i] =import_weight[i] + lockSumTable3 - lockSumTable5;
      }
      if(table42["description"][i]=="کارساخت"){
        system_balance[i] =import_weight[i] + work_madeSumTable3 - half_madeSumTable5;
      }
      if(table42["description"][i]=="سرسنجاق"){
        system_balance[i]=import_weight[i]-pinSumTable5;
      }
      updatedRows42.add(PlutoRow(
        cells: {
          'description': PlutoCell(value:description42[i] ),
          'yesterday_balance': PlutoCell(value: yesterday_balance[i]),
          'real_balance': PlutoCell(value: real_balance[i]),
          'system_balance': PlutoCell(value: system_balance[i]),
          'difference': PlutoCell(value: difference[i]),
          'summary': PlutoCell(value: summary42[i]),

        },
      ));


    }
    gridBStateManager.refRows.clear();
    gridBStateManager.insertRows(0, updatedRows42);

    tableData t = new tableData("تکمیل کارگاه 1","","", "", jsonEncode(table41),jsonEncode(table42),"", "","","","","");
    var respo = await AdminApi.postTable(t);

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
        actions: [IconButton(tooltip: "حذف سطر انتخاب شده",
            onPressed: (){
              deleteCurrentRowAlertDialog(context,gridAStateManager );
            }, icon: Icon(Icons.delete)),
          SizedBox(width: 16,),
          IconButton(onPressed: (){
            resetTableAlertDialog(context);

          }, icon: Icon(Icons.cleaning_services_rounded),tooltip: "پاکسازی جدول"),

        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:  Text('جدول 4   ${Jalali.now().formatFullDate()}',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 22.0)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: PlutoDualGrid(
        gridPropsA: PlutoDualGridProps(
          columns: gridAColumns,
          rows: gridARows,
          configuration: const PlutoGridConfiguration(
              enterKeyAction: PlutoGridEnterKeyAction.editingAndMoveRight,

              style: PlutoGridStyleConfig(evenRowColor: Colors.black12,
                cellTextStyle: TextStyle(fontSize: 16),

              )),
          onLoaded: (PlutoGridOnLoadedEvent event) {
            gridAStateManager = event.stateManager;
            fetchTable();
            calculateTableA();
            calculateTableB();
          },
          onChanged: (PlutoGridOnChangedEvent event) {

            if(event.column.readOnly==false){
              calculateTableA();
            }

          },
        ),


        gridPropsB:
        PlutoDualGridProps(
          columns: gridBColumns,
          rows: gridBRows,
          configuration: const PlutoGridConfiguration(
              enterKeyAction: PlutoGridEnterKeyAction.editingAndMoveRight,
              style: PlutoGridStyleConfig(evenRowColor: Colors.black12,
                cellTextStyle: TextStyle(fontSize: 16),

              )),          onChanged: (event)  {
            calculateTableB();
          },
          onLoaded: (PlutoGridOnLoadedEvent event) {
            gridBStateManager = event.stateManager;
          },


        )

        ,),
      floatingActionButton: FloatingActionButton(tooltip: "افزوردن سطر جدید",
          onPressed: () async {
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
            updateTable();


          },child: const Icon(Icons.add)),

    );
  }

  deleteCurrentRowAlertDialog(BuildContext context ,PlutoGridStateManager stateManager) {
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