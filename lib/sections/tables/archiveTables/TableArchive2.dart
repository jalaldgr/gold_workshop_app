import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:pluto_grid/pluto_grid.dart';

class Table2ArchiveScreen extends StatefulWidget {
  final Color headerColor;
  final tableData table;

  const Table2ArchiveScreen({Key? key, required this.headerColor, required this.table}) : super(key: key);

  @override
  _Table2ArchiveScreenState createState() => _Table2ArchiveScreenState();
}

class _Table2ArchiveScreenState extends State<Table2ArchiveScreen> {


  List<PlutoColumn> columns = [
    PlutoColumn (
      title: 'ردیف',
      field: 'row',
      type: PlutoColumnType.number(),
      enableEditingMode: true,
      width: 70,

    ),
    PlutoColumn (
        title: 'توضیحات',
        field: 'description',
        type: PlutoColumnType.text(),
        enableEditingMode: true,
        width: 100

    ),
    /// Select Column definition
    PlutoColumn(
      title: 'ورود',
      field: 'import',
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
      title: 'خروج',
      field: 'export',
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
      title: 'مانده نهایی',
      field: 'final_balance',
      type: PlutoColumnType.number(format: "#.###"),
      width: 120,
      readOnly: true,
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
      title: 'مانده واقعی',
      field: 'real_balance',
      type: PlutoColumnType.number(format: "#.###"),
      enableEditingMode: true,
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
      title: 'مانده',
      field: 'balance',
      type: PlutoColumnType.number(format: "#.###"),
      width: 100,
      readOnly: true,
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
  ];

  List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 1),
        'description': PlutoCell(value: "مانده روز قبل"),
        'import': PlutoCell(value: 0),
        'export': PlutoCell(value: 0),
        'final_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),

      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 2),
        'description': PlutoCell(value: "کسر برش"),
        'import': PlutoCell(value: 0),
        'export': PlutoCell(value: 0),
        'final_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),

      },
    ),
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 3),
        'description': PlutoCell(value: "کسر ذوب"),
        'import': PlutoCell(value: 0),
        'export': PlutoCell(value: 0),
        'final_balance': PlutoCell(value: 0),
        'real_balance': PlutoCell(value: 0),
        'balance': PlutoCell(value: 0),
        'difference': PlutoCell(value: 0),

      },
    ),
  ];

  /// columnGroups that can group columns can be omitted.
  updateTable() async {
    Map<String,dynamic> table2 = {};
    stateManager.setShowLoading(true);
    List rows = stateManager.rows.map((e) => e.cells['row']?.value).toList();
    List description = stateManager.rows.map((e) => e.cells['description']?.value).toList();
    List import = stateManager.rows.map((e) => e.cells['import']?.value).toList();
    List export = stateManager.rows.map((e) => e.cells['export']?.value).toList();
    List final_balance = stateManager.rows.map((e) => e.cells['final_balance']?.value).toList();
    List real_balance = stateManager.rows.map((e) => e.cells['real_balance']?.value).toList();
    List balance = stateManager.rows.map((e) => e.cells['balance']?.value).toList();
    List difference = stateManager.rows.map((e) => e.cells['difference']?.value).toList();
    table2["row"]=rows.toList();
    table2["description"]=description.toList();
    table2["import"]=import.toList();
    table2["export"]=export.toList();
    table2["final_balance"]=final_balance.toList();
    table2["real_balance"]=real_balance.toList();
    table2["balance"]=balance.toList();
    table2["difference"]=difference.toList();
    tableData t = new tableData("تکمیل کارگاه 1","" , jsonEncode(table2), "","","", "", "","","","",widget.table.id);
    var respo = await AdminApi.postTableById(t);
    stateManager.setShowLoading(false);
   }

  calculateTable() async {
    var tables = await AdminApi.getTableById(widget.table.id);
    dynamic table6 =json.decode(tables.table6!);
    dynamic table2 =json.decode(tables.table2!);
    table6["cut_deference"]=0;

    stateManager.setShowLoading(true);
    List rowNumber = stateManager.rows.map((e) => e.cells['row']?.value).toList();
    List description = stateManager.rows.map((e) => e.cells['description']?.value).toList();
    List import = stateManager.rows.map((e) => e.cells['import']?.value).toList();
    List export = stateManager.rows.map((e) => e.cells['export']?.value).toList();
    List final_balance = stateManager.rows.map((e) => e.cells['final_balance']?.value).toList();
    List real_balance = stateManager.rows.map((e) => e.cells['real_balance']?.value).toList();
    List balance = stateManager.rows.map((e) => e.cells['balance']?.value).toList();
    List difference = stateManager.rows.map((e) => e.cells['difference']?.value).toList();

    List<PlutoRow> updatedRows=[];
    for (var i = 0; i < rowNumber.length; i++) {

      if (i == 0) {// if row 1
        final_balance[i] = import[i]-export[i];
        balance[i]=final_balance[i]-real_balance[i];

        updatedRows.add(PlutoRow(
          cells: {
            'row': PlutoCell(value: rowNumber[i]),
            'description': PlutoCell(value: description[i]),
            'import': PlutoCell(value: import[i]),
            'export': PlutoCell(value: export[i]),
            'final_balance': PlutoCell(value: final_balance[i]),
            'real_balance': PlutoCell(value: real_balance[i]),
            'balance': PlutoCell(value: balance[i]),
            'difference': PlutoCell(value: difference[i]),
          },
        ));
      }else if (i == 1) {// if row 2
        final_balance[i] = import[i]-export[i]+final_balance[i-1];
        balance[i] = final_balance[i]-real_balance[i];
        difference[i] = balance[i];
        updatedRows.add(PlutoRow(
          cells: {
            'row': PlutoCell(value: rowNumber[i]),
            'description': PlutoCell(value: description[i]),
            'import': PlutoCell(value: import[i]),
            'export': PlutoCell(value: export[i]),
            'final_balance': PlutoCell(value: final_balance[i]),
            'real_balance': PlutoCell(value: real_balance[i]),
            'balance': PlutoCell(value: balance[i]  ),
            'difference': PlutoCell(value: balance[i]),
          },
        ));
        table6["cut_deference"] +=difference[i];
      }else if(i==2){ // row is greater than 2
        final_balance[i] = import[i]-export[i]+final_balance[i-1];
        balance[i] = final_balance[i]-real_balance[i];
        difference[i] = balance[i]+difference[i-1];
        updatedRows.add(PlutoRow(
          cells: {
            'row': PlutoCell(value: rowNumber[i]),
            'description': PlutoCell(value: description[i]),
            'import': PlutoCell(value: import[i]),
            'export': PlutoCell(value:export[i]),
            'final_balance': PlutoCell(value: final_balance[i]),
            'real_balance': PlutoCell(value: real_balance[i]),
            'balance': PlutoCell(value: balance[i] ),
            'difference': PlutoCell(value: difference[i]),
          },
        ));
        table6["cut_deference"] +=difference[i];
      }else if(import[i]>0||export[i]>0){
        difference[i] = balance[i]+difference[i-1];
        balance[i] = final_balance[i]-real_balance[i];
        final_balance[i] = import[i]-export[i]+final_balance[i-1];
        updatedRows.add(PlutoRow(
          cells: {
            'row': PlutoCell(value: i+1),
            'description': PlutoCell(value: description[i]),
            'import': PlutoCell(value: import[i]),
            'export': PlutoCell(value:export[i]),
            'final_balance': PlutoCell(value: final_balance[i]),
            'real_balance': PlutoCell(value: real_balance[i]),
            'balance': PlutoCell(value: balance[i]),
            'difference': PlutoCell(value: difference[i]),
          },
        ));
        table6["cut_deference"] +=difference[i];
      }
// update table
      table2["row"][i]=rowNumber[i];
      table2["description"][i]=description[i];
      table2["import"][i]=import[i];
      table2["export"][i]=export[i];
      table2["final_balance"][i]=final_balance[i];
      table2["real_balance"][i]=real_balance[i];
      table2["balance"][i]=balance[i];
      table2["difference"][i]=difference[i];

    }

    stateManager.refRows.clear();
    stateManager.insertRows(0, updatedRows);
    stateManager.setShowLoading(false);
    tableData t = new tableData("تکمیل کارگاه 1","",jsonEncode(table2), "","", "","",  jsonEncode(table6),"","","",widget.table.id);
    var respo = await AdminApi.postTableById(t);

  }

  fetchTable() async {
    var tables = await AdminApi.getTableById(widget.table.id);
    if(tables.table2!.length>117){// an empty rows with only columns name length
      stateManager.setShowLoading(true);
      dynamic table2 =json.decode(tables.table2!);
      List rowNumber = table2["row"];
      List description = table2["description"];
      List import = table2["import"];
      List export = table2["export"];
      List final_balance = table2["final_balance"];
      List real_balance = table2["real_balance"];
      List balance = table2["balance"];
      List difference = table2["difference"];

      List<PlutoRow> updatedRows=[];
      for (var i = 0; i < rowNumber.length; i++) {
        updatedRows.add(PlutoRow(
          cells: {
            'row': PlutoCell(value:rowNumber[i] ),
            'description': PlutoCell(value: description[i]),
            'import': PlutoCell(value: import[i]),
            'export': PlutoCell(value: export[i]),
            'final_balance': PlutoCell(value: final_balance[i]),
            'real_balance': PlutoCell(value: real_balance[i]),
            'balance': PlutoCell(value: balance[i]),
            'difference': PlutoCell(value: difference[i]),
          },
        ));
      }
      stateManager.refRows.clear();
      stateManager.insertRows(0, updatedRows);
      stateManager.setShowLoading(false);
    }


  }
  resetTable(){
    List<PlutoRow> rows = [
      PlutoRow(
        cells: {
          'row': PlutoCell(value: 1),
          'description': PlutoCell(value: "مانده روز قبل"),
          'import': PlutoCell(value: 0),
          'export': PlutoCell(value: 0),
          'final_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),

        },
      ),
      PlutoRow(
        cells: {
          'row': PlutoCell(value: 2),
          'description': PlutoCell(value: "کسر برش"),
          'import': PlutoCell(value: 0),
          'export': PlutoCell(value: 0),
          'final_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),

        },
      ),
      PlutoRow(
        cells: {
          'row': PlutoCell(value: 3),
          'description': PlutoCell(value: "کسر ذوب"),
          'import': PlutoCell(value: 0),
          'export': PlutoCell(value: 0),
          'final_balance': PlutoCell(value: 0),
          'real_balance': PlutoCell(value: 0),
          'balance': PlutoCell(value: 0),
          'difference': PlutoCell(value: 0),

        },
      ),
    ];

    stateManager.refRows.clear();
    stateManager.insertRows(0, rows);
    updateTable();
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
        backgroundColor: widget.headerColor??Colors.pink,
        actions: [IconButton(tooltip: "حذف سطر انتخاب شده",
       onPressed: (){
          stateManager.removeCurrentRow();
          updateTable();
        }, icon: Icon(Icons.delete)),
          SizedBox(width: 16,),
          IconButton(onPressed: (){
            resetTable();

          }, icon: Icon(Icons.cleaning_services_rounded),tooltip: "ریست کردن جدول"),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:  Text('جدول   2${widget.table.date}',
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
            if((event.columnIdx==3 && event.rowIdx==0)||(event.columnIdx==3 && event.rowIdx==2)||
                (event.columnIdx==2 && event.rowIdx==1)||(event.columnIdx==2 && event.rowIdx==2)
                || (event.columnIdx==3 && event.rowIdx==1)
            ){
              stateManager.rows[event.rowIdx].cells[event.column.field]!.value = 0;

            }else if(event.column.readOnly==false){
              calculateTable();
            }

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
                'row': PlutoCell(value: 0 ),
                'description': PlutoCell(value: ""),
                'import': PlutoCell(value: 0),
                'export': PlutoCell(value: 0),
                'final_balance': PlutoCell(value: 0),
                'real_balance': PlutoCell(value: 0),
                'balance': PlutoCell(value: 0),
                'difference': PlutoCell(value: 0)

              }
            )
          ]);
        updateTable();
        },child: const Icon(Icons.add)),

    );
  }

}

