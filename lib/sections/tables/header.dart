
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../helper/serverApi.dart';
import '../../models/tableModel.dart';

class Header extends StatefulWidget {
  const Header({
    required this.stateManager,
    Key? key,
  }) : super(key: key);

  final PlutoGridStateManager stateManager;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {

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
    updateTable();
  }



  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: handleRemoveCurrentRowButton,
      child: const Text('حذف سطر انتخاب شده',style: TextStyle(color: Colors.black),),
    );
  }




  updateTable() async {
    Map<String,dynamic> table3 = {};

    List description = widget.stateManager.rows.map((e) => e.cells['description']?.value).toList();
    List other = widget.stateManager.rows.map((e) => e.cells['other']?.value).toList();
    List ring = widget.stateManager.rows.map((e) => e.cells['ring']?.value).toList();
    List wire = widget.stateManager.rows.map((e) => e.cells['wire']?.value).toList();
    List ball = widget.stateManager.rows.map((e) => e.cells['ball']?.value).toList();
    List solder = widget.stateManager.rows.map((e) => e.cells['solder']?.value).toList();
    List chain = widget.stateManager.rows.map((e) => e.cells['chain']?.value).toList();
    List piece_chain = widget.stateManager.rows.map((e) => e.cells['piece_chain']?.value).toList();
    List lock = widget.stateManager.rows.map((e) => e.cells['lock']?.value).toList();
    List work_made = widget.stateManager.rows.map((e) => e.cells['work_made']?.value).toList();
    List sum = widget.stateManager.rows.map((e) => e.cells['sum']?.value).toList();


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

    tableData t = new tableData("تکمیل کارگاه 2", "", "", jsonEncode(table3), "","", "", "","","","");

    var respo = await AdminApi.postTable(t);

  }

}