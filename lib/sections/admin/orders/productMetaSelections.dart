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

  String braceletTypeDropdownValue="پرچی";
  var braceletTypeDropDownItemList=["پرچی","دوختی"];

  String braceletLeatherTypeDropdownValue="طبیعی";
  var braceletleatherTypeDropDownItemList=["طبیعی","مصنوعی"];

  String stoneAroundTypeDropdownValue="ساده";
  var stoneAroundTypeDropDownItemList=["ساده","لوکس","طرح دار"];


  Map<String,String>  _metaKeyValue={};

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {

    print(widget.meta);
    print(widget.productType);
    return Column(
      children: [
        Visibility(
          visible: widget.productType=="پلاک اسم",
          child:
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
            )
        ),

        Visibility
          (visible: widget.productType=="النگو",
          child: Row(
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
        ),

        Visibility(
          visible: widget.productType=="گوشواره",
            child: Row(
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
        )
        ),
        Visibility(
          visible: widget.productType=="دوره سنگ",
          child:  Row(
              children: [

                Expanded(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "نوع سنگ"),
                    value: stoneAroundTypeDropdownValue,
                    items: stoneAroundTypeDropDownItemList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        stoneAroundTypeDropdownValue = value!;
                        _metaKeyValue["stone_type"] = value;
                        widget.callback(_metaKeyValue.toString());
                      });
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "نوع دسته", labelText: "نوع دسته"),
                  ),
                ),            Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "سایز دسته", labelText: "سایز دسته"),
                  ),
                ),


              ],
            ),
        ),
        Visibility(
          visible: widget.productType=="دستبند",
          child:Row(
            children: [

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
                    decoration: InputDecoration(labelText: "نوع دستبند"),
                    value: braceletTypeDropdownValue,
                    items: braceletTypeDropDownItemList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        braceletTypeDropdownValue = value!;
                        _metaKeyValue["bracelet_type"] = value;
                        widget.callback(_metaKeyValue.toString());
                      });
                    },
                  )),
              Expanded(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(labelText: "نوع چرم"),
                    value: braceletLeatherTypeDropdownValue,
                    items: braceletleatherTypeDropDownItemList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        braceletLeatherTypeDropdownValue = value!;
                        _metaKeyValue["bracelet_leather_type"] = value;
                        widget.callback(_metaKeyValue.toString());
                      });
                    },
                  )),



            ],
          ),
        ),
      ],
    );

    }


}