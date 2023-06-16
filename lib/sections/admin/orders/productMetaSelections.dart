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

  String plateLanguageDropdownValue="فارسی";
  var plateLanguageItemList = ["انگلیسی","فارسی"];
  String plateTypeDropdownValue="تک حلقه";
  var plateTypeItemList = ["تک حلقه","دو حلقه"];
  String plateHackTypeDropdownValue="براق";
  var plateHackTypeItemList = ["براق","مات","مات و براق"];

  String bangleColorDropdownValue="زرد";
  var bangleColorItemList = ["زرد","سفید","زرد و سفید"];
  String bangleSizeDropdownValue="نوزادی-0";
  var bangleSizeTypeItemList = ["نوزادی-0","نوزادی-1","نوزادی-2","نوزادی-3","نوزادی-4","نوزادی-5","بزرگسال-1","بزرگسال-2","بزرگسال-3","بزرگسال-4","بزرگسال-5",];

  String earringsTypeDropDownValUe="عصایی";
  var earringsTypeItemList = ["عصایی","بخیه ای","بیخ گوشی"];
  String earringsHackTypeDropdownValue="براق";
  var earringsHackTypeDropDownItemList=["براق","مات","مات و براق"];


  Map<String,String>  _metaKeyValue={"plate_language": "انگلیسی", "plate_type": "تک حلقه", "plate_hack_type": "براق"};

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "نام پلاک", labelText: "نام پلاک"),
              ),
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "بخش بندی", labelText: "بخش بندی"),
              ),
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "ابعاد محصول", labelText: "ابعاد محصول"),
              ),
            ),
            Expanded(
                child: DropdownButtonFormField(
              decoration: InputDecoration(labelText: "حالت پلاک"),
              value: plateLanguageDropdownValue,
              items: plateLanguageItemList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  plateLanguageDropdownValue = value!;
                  _metaKeyValue["plate_language"] = value;
                  widget.callback(_metaKeyValue.toString());
                });
              },
            )),
            Expanded(
                child: DropdownButtonFormField(
              decoration: InputDecoration(labelText: "نوع"),
              value: plateTypeDropdownValue,
              items: plateTypeItemList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  plateTypeDropdownValue = value!;
                  _metaKeyValue["plate_type"] = value;
                  widget.callback(_metaKeyValue.toString());
                });
              },
            )),
            Expanded(
                child: DropdownButtonFormField(
              decoration: InputDecoration(labelText: "نوع حک"),
              value: plateHackTypeDropdownValue,
              items: plateHackTypeItemList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  plateHackTypeDropdownValue = value!;
                  _metaKeyValue["plate_hack_type"] = value;
                  widget.callback(_metaKeyValue.toString());
                });
              },
            ))
          ],
        ),

        Row(
          children: [

            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "نوع طرح", labelText: "نوع طرح"),
              ),
            ),
            Expanded(
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: "رنگ"),
                  value: bangleColorDropdownValue,
                  items: bangleColorItemList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      bangleColorDropdownValue = value!;
                      _metaKeyValue["bangle_color"] = value;
                      widget.callback(_metaKeyValue.toString());
                    });
                  },
                )),
            Expanded(
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: "سایز"),
                  value: bangleSizeDropdownValue,
                  items: bangleSizeTypeItemList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      bangleSizeDropdownValue = value!;
                      _metaKeyValue["bangl_size"] = value;
                      widget.callback(_metaKeyValue.toString());
                    });
                  },
                )),
          ],
        ),

        Row(
          children: [

            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "ابعاد محصول", labelText: "ابعاد محصول"),
              ),
            ),
            Expanded(
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: "نوع گوشواره"),
                  value: earringsTypeDropDownValUe,
                  items: earringsTypeItemList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      earringsTypeDropDownValUe = value!;
                      _metaKeyValue["earrings_type"] = value;
                      widget.callback(_metaKeyValue.toString());
                    });
                  },
                )),
            Expanded(
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: "نوع حک"),
                  value: earringsHackTypeDropdownValue,
                  items: earringsHackTypeDropDownItemList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      earringsHackTypeDropdownValue = value!;
                      _metaKeyValue["earrings_hack_type"] = value;
                      widget.callback(_metaKeyValue.toString());
                    });
                  },
                )),

          ],
        ),

      ],
    );

    }


}