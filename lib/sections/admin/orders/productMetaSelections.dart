import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../helper/serverApi.dart';

class ProductMetaSelections extends StatefulWidget {
  String? meta;
  String? productType;
  final Function callback;
  ProductMetaSelections({super.key , required this.callback, required this.meta,required this.productType});


  @override
  State<ProductMetaSelections> createState() => _ProductMetaSelectionsState();
}


class _ProductMetaSelectionsState extends State<ProductMetaSelections> {
  String languageDropdownValue="فارسی";
  var languageItemList = ["انگلیسی","فارسی"];
  Map<String,String>  _metaKeyValue={};

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        DropdownButtonFormField(
          decoration: InputDecoration(labelText: "حالت پلاک"),
          value: languageDropdownValue,
          items: languageItemList.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
          onChanged: (String? value) {setState(() {
            languageDropdownValue = value!;
            _metaKeyValue["plate_language"]= value;
            widget.callback(_metaKeyValue.toString());
          });},
        )
       ],
    );

    }


}