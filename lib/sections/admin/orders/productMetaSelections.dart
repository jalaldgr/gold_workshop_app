import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../helper/serverApi.dart';

class ProductMetaSelections extends StatefulWidget {
  String? meta;
  final Function callback;
  ProductMetaSelections({super.key , required this.callback, required this.meta});


  @override
  State<ProductMetaSelections> createState() => _ProductMetaSelectionsState();
}


class _ProductMetaSelectionsState extends State<ProductMetaSelections> {
  String languageDropdownValue="فارسی";
  var languageItemList = ["انگلیسی","فارسی"];

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        DropdownButtonFormField(
          decoration: InputDecoration(labelText: "نوع مشتری"),
          value: languageDropdownValue,
          items: languageItemList.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
          onChanged: (String? value) {setState(() {
            languageDropdownValue = value!;
            widget.meta = value;
            widget.callback(value);

          });},
        )

       ],
    );

    }


}