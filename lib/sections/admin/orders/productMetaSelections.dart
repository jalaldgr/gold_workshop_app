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


  TextEditingController plateNameTextController = TextEditingController();
  TextEditingController plateSectionTextController = TextEditingController();
  TextEditingController plateDimensionsTextController = TextEditingController();
  TextEditingController bangleStyleTextController = TextEditingController();
  TextEditingController braceletSectionTextController = TextEditingController();
  TextEditingController earringsDimensionsTextController = TextEditingController();
  TextEditingController stoneHandleTypeTextController = TextEditingController();
  TextEditingController stoneHandleSizeTextController = TextEditingController();


  Map<String,String>  _metaKeyValue={};

  @override
  void initState() {
    print(widget.meta);
    if(widget.meta!.length>0){
      dynamic meta =json.decode(widget.meta!);
      if(meta["نام پلاک"].toString().length>0)plateNameTextController.text = meta["نام پلاک"]??"";
      if(meta["بخش بندی"].toString().length>0)plateSectionTextController.text = meta["بخش بندی"]??"";
      if(meta["ابعاد محصول"].toString().length>0)plateDimensionsTextController.text = meta["ابعاد محصول"]??"";
      if(meta["نوع طرح"].toString().length>0)bangleStyleTextController.text = meta["نوع طرح"]??"";
      if(meta["ابعاد محصول"].toString().length>0)earringsDimensionsTextController.text = meta["ابعاد محصول"]??"";
      if(meta["نوع دسته"].toString().length>0)stoneHandleTypeTextController.text = meta["نوع دسته"]??"";
      if(meta["سایز دسته"].toString().length>0)stoneHandleSizeTextController.text = meta["سایز دسته"]??"";
      if(meta["بخش بندی"].toString().length>0)braceletSectionTextController.text = meta["بخش بندی"]??"";


    }

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
                    onChanged: (value){
                      _metaKeyValue["نام پلاک"] = value;
                      widget.callback(jsonEncode(_metaKeyValue));
                    },
                    controller: plateNameTextController,
                    decoration: InputDecoration(
                        hintText: "نام پلاک", labelText: "نام پلاک",),

                  ),
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (value){
                      _metaKeyValue["بخش بندی"] = value;
                      widget.callback(jsonEncode(_metaKeyValue));
                    },
                    controller: plateSectionTextController,
                    decoration: InputDecoration(
                        hintText: "بخش بندی", labelText: "بخش بندی"),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (value){
                      _metaKeyValue["ابعاد محصول"] = value;
                      widget.callback(jsonEncode(_metaKeyValue));
                    },
                    controller: plateDimensionsTextController,
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
                          _metaKeyValue["حالت پلاک"] = value;
                          widget.callback(jsonEncode(_metaKeyValue));
                        });
                      },
                    )),
                Expanded(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: "نوع پلاک"),
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
                          _metaKeyValue["نوع پلاک"] = value;
                          widget.callback(jsonEncode(_metaKeyValue));
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
                          _metaKeyValue["نوع حک"] = value;
                          widget.callback(jsonEncode(_metaKeyValue));
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
                  onChanged: (value){
                    _metaKeyValue["نوع طرح"] = value;
                    widget.callback(jsonEncode(_metaKeyValue));
                  },
                  controller: bangleStyleTextController,
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
                        _metaKeyValue["رنگ"] = value;
                        widget.callback(jsonEncode(_metaKeyValue));
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
                        _metaKeyValue["سایز"] = value;
                        widget.callback(jsonEncode(_metaKeyValue));
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
                onChanged: (value){
                  _metaKeyValue["ابعاد محصول"] = value;
                  widget.callback(jsonEncode(_metaKeyValue));
                },
                controller: earringsDimensionsTextController,
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
                      _metaKeyValue["نوع گوشواره"] = value;
                      widget.callback(jsonEncode(_metaKeyValue));
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
                      _metaKeyValue["نوع حک"] = value;
                      widget.callback(jsonEncode(_metaKeyValue));
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
                        _metaKeyValue["نوع سنگ"] = value;
                        widget.callback(jsonEncode(_metaKeyValue));
                      });
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (value){
                      _metaKeyValue["نوع دسته"] = value;
                      widget.callback(jsonEncode(_metaKeyValue));
                    },
                    controller: stoneHandleTypeTextController,
                    decoration: InputDecoration(
                        hintText: "نوع دسته", labelText: "نوع دسته"),
                  ),
                ),            Expanded(
                  child: TextFormField(
                    onChanged: (value){
                      _metaKeyValue["سایز دسته"] = value;
                      widget.callback(jsonEncode(_metaKeyValue));
                    },
                    controller: stoneHandleSizeTextController,
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
                  onChanged: (value){
                    _metaKeyValue["بخش بندی"] = value;
                    widget.callback(jsonEncode(_metaKeyValue));
                  },
                  decoration: InputDecoration(
                      hintText: "بخش بندی", labelText: "بخش بندی"),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: braceletSectionTextController,
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
                        widget.callback(jsonEncode(_metaKeyValue));
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
                        widget.callback(jsonEncode(_metaKeyValue));
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