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
  var plateLanguageItemList = ["انگلیسی","فارسی","طبق کاتالوگ"];
  String plateTypeDropdownValue="تک حلقه";
  var plateTypeItemList = ["تک حلقه","دو حلقه","طبق کاتالوگ"];
  String plateHackTypeDropdownValue="براق";
  var plateHackTypeItemList = ["براق","مات","مات و براق","مات اسکاچی","طبق کاتالوگ"];

  String bangleColorDropdownValue="زرد";
  var bangleColorItemList = ["زرد","سفید","زرد و سفید"];
  String bangleSizeDropdownValue="نوزادی-0";
  var bangleSizeTypeItemList = ["نوزادی-0","نوزادی-1","نوزادی-2","نوزادی-3","نوزادی-4","نوزادی-5","بزرگسال-1","بزرگسال-2","بزرگسال-3","بزرگسال-4","بزرگسال-5",];

  String earringsTypeDropDownValUe="عصایی";
  var earringsTypeItemList = ["عصایی","بخیه ای","بیخ گوشی"];
  String earringsHackTypeDropdownValue="براق";
  var earringsHackTypeDropDownItemList=["براق","مات","مات و براق","مات اسکاچی","طبق کاتالوگ"];

  String braceletTypeDropdownValue="پرچی";
  var braceletTypeDropDownItemList=["پرچی","دوختی","پانچی"];

  String braceletLeatherTypeDropdownValue="طبیعی";
  var braceletleatherTypeDropDownItemList=["طبیعی","مصنوعی"];

  String stoneAroundTypeDropdownValue="ساده";
  var stoneAroundTypeDropDownItemList=["ساده","لوکس","طرح دار"];


  TextEditingController plateNameTextController = TextEditingController();
  TextEditingController plateSectionTextController = TextEditingController();
  TextEditingController plateDimensionsTextController = TextEditingController();
  TextEditingController bangleStyleTextController = TextEditingController();
  TextEditingController braceletSectionTextController = TextEditingController();
  TextEditingController braceletDimensionsTextController = TextEditingController();
  TextEditingController earringsDimensionsTextController = TextEditingController();
  TextEditingController stoneHandleTypeTextController = TextEditingController();
  TextEditingController stoneHandleSizeTextController = TextEditingController();

  TextEditingController ringHandleSizeTextController = TextEditingController();
  TextEditingController ringHandleTypeTextController = TextEditingController();
  TextEditingController ringStoneTypeTextController = TextEditingController();

  Map<String,String>  _metaKeyValue={};

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    switch(widget.productType){
      case 'پلاک اسم':
        if(widget.meta!.length>0){
          dynamic meta =json.decode(widget.meta!);
          _metaKeyValue={}; //reset order meta list
          if(meta["نام پلاک"].toString().length>0)plateNameTextController.text = meta["نام پلاک"]??"";
          if(meta["بخش بندی"].toString().length>0)plateSectionTextController.text = meta["بخش بندی"]??"";
          if(meta["ابعاد محصول"].toString().length>0)plateDimensionsTextController.text = meta["ابعاد محصول"]??"";
          if(meta["حالت پلاک"].toString().length>0)plateLanguageDropdownValue = meta["حالت پلاک"]??"فارسی";
          if(meta["نوع حک"].toString().length>0)plateHackTypeDropdownValue = meta["نوع حک"]??"براق";
          if(meta["نوع پلاک"].toString().length>0)plateTypeDropdownValue = meta["نوع پلاک"]??"تک حلقه";

          if(meta["نام پلاک"].toString().length>0)_metaKeyValue["نام پلاک"] = meta["نام پلاک"]??"";
          if(meta["بخش بندی"].toString().length>0)_metaKeyValue["بخش بندی"] = meta["بخش بندی"]??"";
          if(meta["ابعاد محصول"].toString().length>0)_metaKeyValue["ابعاد محصول"]= meta["ابعاد محصول"]??"";
          if(meta["حالت پلاک"].toString().length>0)_metaKeyValue["حالت پلاک"] = meta["حالت پلاک"]??"فارسی";
          if(meta["نوع حک"].toString().length>0)_metaKeyValue["نوع حک"] = meta["نوع حک"]??"براق";
          if(meta["نوع پلاک"].toString().length>0)_metaKeyValue["نوع پلاک"] = meta["نوع پلاک"]??"تک حلقه";
        }
        break;
      case 'النگو':
        if(widget.meta!.length>0) {
          _metaKeyValue={};
          dynamic meta = json.decode(widget.meta!);
          if(meta["نوع طرح"].toString().length>0)bangleStyleTextController.text = meta["نوع طرح"]??"";
          if(meta["رنگ"].toString().length>0)bangleColorDropdownValue = meta["رنگ"]??"زرد";
          if(meta["سایز"].toString().length>0)bangleSizeDropdownValue = meta["سایز"]??"نوزادی-0";

          if(meta["نوع طرح"].toString().length>0)_metaKeyValue["نوع طرح"] = meta["نوع طرح"]??"";
          if(meta["رنگ"].toString().length>0)_metaKeyValue["رنگ"]= meta["رنگ"]??"زرد";
          if(meta["سایز"].toString().length>0)_metaKeyValue["سایز"] = meta["سایز"]??"";


        }
        break;
      case 'دستبند':
        if(widget.meta!.length>0) {
          _metaKeyValue={};
          dynamic meta = json.decode(widget.meta!);
          if(meta["نوع دستبند"].toString().length>0)braceletTypeDropdownValue = meta["نوع دستبند"]??"پرچی";
          if(meta["نوع چرم"].toString().length>0)braceletLeatherTypeDropdownValue = meta["نوع چرم"]??"طبیعی";
          if(meta["ابعاد محصول"].toString().length>0)braceletDimensionsTextController.text = meta["ابعاد محصول"]??"";
          if(meta["بخش بندی"].toString().length>0)braceletSectionTextController.text = meta["بخش بندی"]??"";

          if(meta["نوع دستبند"].toString().length>0)_metaKeyValue["نوع دستبند"] = meta["نوع دستبند"]??"پرچی";
          if(meta["نوع چرم"].toString().length>0)_metaKeyValue["نوع چرم"] = meta["نوع چرم"]??"طبیعی";
          if(meta["بخش بندی"].toString().length>0)_metaKeyValue["بخش بندی"] = meta["بخش بندی"]??"";
          if(meta["ابعاد محصول"].toString().length>0)_metaKeyValue["ابعاد محصول"]= meta["ابعاد محصول"]??"";


        }
        break;
      case 'گوشواره':
        if(widget.meta!.length>0) {
          _metaKeyValue={};
          dynamic meta = json.decode(widget.meta!);
          if(meta["ابعاد محصول"].toString().length>0)earringsDimensionsTextController.text = meta["ابعاد محصول"]??"";
          if(meta["نوع گوشواره"].toString().length>0)earringsTypeDropDownValUe = meta["نوع گوشواره"]??"عصایی";
          if(meta["نوع حک"].toString().length>0)earringsHackTypeDropdownValue = meta["نوع حک"]??"براق";
          if(meta["ابعاد محصول"].toString().length>0)_metaKeyValue["ابعاد محصول"]= meta["ابعاد محصول"]??"";
          if(meta["نوع گوشواره"].toString().length>0)_metaKeyValue["نوع گوشواره"] = meta["نوع گوشواره"]??"عصایی";
          if(meta["نوع حک"].toString().length>0)_metaKeyValue["نوع حک"] = meta["نوع حک"]??"براق";

        }
        break;
      case 'دوره سنگ':
        if(widget.meta!.length>0) {
          _metaKeyValue={};
          dynamic meta = json.decode(widget.meta!);
          if(meta["نوع دسته"].toString().length>0)stoneHandleTypeTextController.text = meta["نوع دسته"]??"";
          if(meta["سایز دسته"].toString().length>0)stoneHandleSizeTextController.text = meta["سایز دسته"]??"";
          if(meta["نوع سنگ"].toString().length>0)stoneAroundTypeDropdownValue = meta["نوع سنگ"]??"ساده";

          if(meta["نوع دسته"].toString().length>0)_metaKeyValue["نوع دسته"] = meta["نوع دسته"]??"";
          if(meta["سایز دسته"].toString().length>0)_metaKeyValue["سایز دسته"] = meta["سایز دسته"]??"";
          if(meta["نوع سنگ"].toString().length>0)_metaKeyValue["نوع سنگ"] = meta["نوع سنگ"]??"ساده";

        }
        break;

      case 'انگشتر':
        if(widget.meta!.length>0) {
          _metaKeyValue={};
          dynamic meta = json.decode(widget.meta!);
          if(meta["نوع دسته"].toString().length>0)ringHandleTypeTextController.text = meta["نوع دسته"]??"";
          if(meta["سایز دسته"].toString().length>0)ringHandleSizeTextController.text = meta["سایز دسته"]??"";
          if(meta["نوع سنگ"].toString().length>0)ringStoneTypeTextController.text = meta["نوع سنگ"]??"";

          if(meta["نوع دسته"].toString().length>0)_metaKeyValue["نوع دسته"] = meta["نوع دسته"]??"";
          if(meta["سایز دسته"].toString().length>0)_metaKeyValue["سایز دسته"] = meta["سایز دسته"]??"";
          if(meta["نوع سنگ"].toString().length>0)_metaKeyValue["نوع سنگ"] = meta["نوع سنگ"]??"";

        }
        break;




    }

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
                  controller: braceletSectionTextController,
                  decoration: InputDecoration(
                      hintText: "بخش بندی", labelText: "بخش بندی"),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: braceletDimensionsTextController,
                  onChanged: (value){
                    _metaKeyValue["ابعاد محصول"] = value;
                    widget.callback(jsonEncode(_metaKeyValue));
                  },
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
                        _metaKeyValue["نوع دستبند"] = value;
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
                        _metaKeyValue["نوع چرم"] = value;
                        widget.callback(jsonEncode(_metaKeyValue));
                      });
                    },
                  )),



            ],
          ),
        ),
        Visibility(
          visible: widget.productType=="انگشتر",
          child:Row(
            children: [

              Expanded(
                child: TextFormField(
                  onChanged: (value){
                    _metaKeyValue["نوع دسته"] = value;
                    widget.callback(jsonEncode(_metaKeyValue));
                  },
                  controller: ringHandleTypeTextController,
                  decoration: InputDecoration(
                      hintText: "نوع دسته", labelText: "نوع دسته"),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: ringHandleSizeTextController,
                  onChanged: (value){
                    _metaKeyValue["سایز دسته"] = value;
                    widget.callback(jsonEncode(_metaKeyValue));
                  },
                  decoration: InputDecoration(
                      hintText: "سایز دسته", labelText: "سایز دسته"),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: ringStoneTypeTextController,
                  onChanged: (value){
                    _metaKeyValue["نوع سنگ"] = value;
                    widget.callback(jsonEncode(_metaKeyValue));
                  },
                  decoration: InputDecoration(
                      hintText: "نوع سنگ", labelText: "نوع سنگ"),
                ),
              ),




            ],
          ),
        ),

      ],
    );

    }


}