import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../helper/serverApi.dart';

class Workshop2DropDown extends StatefulWidget {
  final String hint;
  final Function callback;
  Workshop2DropDown({super.key , required this.callback, required this.hint});


  @override
  State<Workshop2DropDown> createState() => _Workshop2DropDownState();
}


class _Workshop2DropDownState extends State<Workshop2DropDown> {
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
     var response= (await AdminApi.getWorkshop2sJson());
      setState(() {
        categoryItemlist = jsonDecode(response);
      });

    }

}