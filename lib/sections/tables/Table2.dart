import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:pluto_grid/pluto_grid.dart';

class Table2Screen extends StatefulWidget {
  final Color headerColor;
  const Table2Screen({Key? key, required this.headerColor}) : super(key: key);

  @override
  _Table2ScreenState createState() => _Table2ScreenState();
}

class _Table2ScreenState extends State<Table2Screen> {


  List<PlutoColumn> columns = [
    PlutoColumn (
      title: 'ردیف',
      field: 'row',
      type: PlutoColumnType.number(),
        enableEditingMode: true,
      width: 100

    ),
    PlutoColumn (
        title: 'توضیحات',
        field: 'description',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100

    ),
    /// Select Column definition
    PlutoColumn(
        title: 'ورود',
        field: 'import',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100


    ),
    PlutoColumn(
        title: 'خروج',
        field: 'export',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100


    ),
    PlutoColumn(
        title: 'مانده نهایی',
        field: 'final_balance',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 200


    ),
    PlutoColumn(
        title: 'مانده واقعی',
        field: 'real_balance',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100


    ),
    PlutoColumn(
        title: 'مانده',
        field: 'balance',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 100


    ),
    PlutoColumn(
        title: 'اختلاف',
        field: 'difference',
        type: PlutoColumnType.number(),
        enableEditingMode: true,
        width: 150


    ),
  ];

  List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'row': PlutoCell(value: 1),
        'description': PlutoCell(value: 2),
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
    tableData t = new tableData("تکمیل کارگاه 1","" , jsonEncode(table2), "","","", "", "","","","");
    var respo = await AdminApi.postTable(t);
    stateManager.setShowLoading(false);
    print(respo.toJson());
  }

  calculateTable() async {

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

  fetchTable() async {
    var tables = await AdminApi.getTable();
    if(tables.table2!.length>10){
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
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.refresh))],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('جدول 2',
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
                'row': PlutoCell(value: 1),
                'description': PlutoCell(value: "rth"),
                'import': PlutoCell(value: 0),
                'export': PlutoCell(value: 0),
                'final_balance': PlutoCell(value: 0),
                'real_balance': PlutoCell(value: 0),
                'balance': PlutoCell(value: 0),
                'difference': PlutoCell(value: 0)

              }
            )
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
  }



  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: handleRemoveCurrentRowButton,
      child: const Text('حذف سطر انتخاب شده',style: TextStyle(color: Colors.black),),
    );
  }
}