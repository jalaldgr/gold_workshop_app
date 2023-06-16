import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../helper/serverApi.dart';

class DesignerDropDown extends StatefulWidget {
  final String hint;
  final Function callback;
  DesignerDropDown({super.key , required this.callback, required this.hint});


  @override
  State<DesignerDropDown> createState() => _DesignerDropDownState();
}


class _DesignerDropDownState extends State<DesignerDropDown> {
  dynamic dropdownvalue;
  List categoryItemlist = [];

  @override
  void initState() {
    _getDesignerList();
  }

  @override
  Widget build(BuildContext context) {


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButtonFormField(
          decoration: InputDecoration(labelText: "طراح"),
          items: categoryItemlist.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item['fullName'].toString()),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              // widget.designerName="${newVal["id"]}";
              dropdownvalue = newVal;
              widget.callback(newVal);
            });
          },
          value: dropdownvalue,
          hint: Text(widget.hint),
        ),
      ],
    );

    }


    _getDesignerList() async {
     var response= (await AdminApi.getDesignersJson());
      setState(() {
        categoryItemlist = jsonDecode(response);
      });

    }

}