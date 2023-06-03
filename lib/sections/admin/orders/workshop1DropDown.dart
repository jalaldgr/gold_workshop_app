import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../helper/serverApi.dart';

class Workshop1DropDown extends StatefulWidget {
  final String hint;
  final Function callback;
  Workshop1DropDown({super.key , required this.callback, required this.hint});


  @override
  State<Workshop1DropDown> createState() => _Workshop1DropDownState();
}


class _Workshop1DropDownState extends State<Workshop1DropDown> {
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
        DropdownButton(
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
     var response= (await AdminApi.getWorkshop1sJson());
      setState(() {
        categoryItemlist = jsonDecode(response);
      });

    }

}