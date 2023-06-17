

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/sections/admin/orders/designerDropDown.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'productMetaSelections.dart';
import 'workshop1DropDown.dart';
import 'workshop2DropDown.dart';

// Define a custom Form widget.
class NewOrderForm extends StatefulWidget {
  orderData order;
  NewOrderForm({super.key,required this.order});

  @override
  NewOrderFormState createState() {
    return NewOrderFormState();
  }
}



// Define a corresponding State class.
// This class holds data related to the form.
class NewOrderFormState extends State<NewOrderForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String customerTypeDropDownValue = 'مشتری';
  var customerTypeDropDownItems = [ 'مشتری','همکار' ];
  String statusDropDownValue = 'در انتظار بررسی';
  var statusDropDownItems = ['در انتظار بررسی','تکمیل نهایی' , 'ارسال به طراح','ارسال به کارگاه','برگشت از طراح','برگشت از کارگاه' ,'لغو شده'];
  String productTypeDropDownValue = 'پلاک اسم';
  var productTypeDropDownItems = ["پلاک اسم","انگشتر","النگو","دستبند","گوشواره","دوره سنگ","سرویس طلا","نیم ست طلا","آویز طلا",
    "پا بند طلا","رو لباسی طلا","جواهرات","ساعت طلا","دستبند چرمی طلا","دستبند مهره ای فانتزی طلا","تک پوش طلا","گردنبند","حلقه ست",
    "اکسسوری طلا","محصولات نفره","آویز ساعت و دستبند طلا","پیرسینگ طلا","زنجیر طلا","سنجاق سینه طلا","مد روز","کودک و نوزاد",
    "طلای مناسبتی","طوق و بنگل طلا","تمیمه","انگشتر مردانه","زنجیر مردانه","دستبند مردانه","انگشتر زنانه","هدایای اقتصادی","برند ها"];
  String orderMetaDropDownValue = 'کد';
  var orderMetaDropDownItems = [ 'کد','وزن','سایز','ابعاد','رنگ','سایر', ];
  bool instantDeliveryCheckBoxValue = false;
  bool deliveryByCustomerCheckBoxValue = false;
  bool feeCheckBoxValue = false;
  bool deliveryPaperCheckBoxValue = false;
  List<DataRow> tableItem=[];

  TextEditingController orderMetaKeyEditTextController=TextEditingController();
  TextEditingController orderMetaValueEditTextController=TextEditingController();
  TextEditingController nameEditTextController=TextEditingController();
  TextEditingController contactEditTextController=TextEditingController();
  TextEditingController descriptionEditTextController=TextEditingController();
  TextEditingController deliverDateEditTextController=TextEditingController();
  TextEditingController imageEditTextController=TextEditingController();
  TextEditingController fileEditTextController=TextEditingController();
  TextEditingController productCodeEditTextController=TextEditingController();
  TextEditingController productWeightTextController=TextEditingController();

  File? _imageFile;



  onSelectedRow( String row) async {
    setState(() {

    });
  }
  onChangeProductMeta(value){
    setState(() {
      widget.order.orderMeta = value;
      print(widget.order.orderMeta);
    });
  }
  onChangeDesignerDropDown(value){
    setState(() {
      widget.order.designerId = value["id"];
      widget.order.designerFullName = value["fullName"];
    });
  }

  onChangeWorkshop1DropDown(value){
    setState(() {
      widget.order.workshop1Id = value["id"];
      widget.order.workshop1fullName = value["fullName"];
    });
  }
  onChangeWorkshop2DropDown(value){
    setState(() {
      widget.order.workshop2Id = value["id"];
      widget.order.workshop2fullName = value["fullName"];
    });
  }



  collectFields(){
    setState(() {
      widget.order.clientFullName = nameEditTextController.text;
      widget.order.clientMobile =  contactEditTextController.text;
      widget.order.description = descriptionEditTextController.text;
      widget.order.deliveryDate = deliverDateEditTextController.text;
      widget.order.weight = productWeightTextController.text;
      widget.order.code = productCodeEditTextController.text;
      widget.order.clientType = customerTypeDropDownValue;
      widget.order.status = statusDropDownValue;
      widget.order.productType = productTypeDropDownValue;

    });
  }
  openDatePicker() async {
    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali.now(),
      lastDate: Jalali(1414, 12),
    );
    deliverDateEditTextController.text = picked!.formatFullDate();
  }
  openFilePicker() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['*'],
    );

    setState(() {
      fileEditTextController.text = "${result?.paths[0]}";
      widget.order.designerFile = "${result?.paths[0]}".replaceAll("\\", "\\\\");
    });
  }
  openImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['*'],
    );

    setState(() {
      imageEditTextController.text = "${result?.paths[0]}";
      widget.order.image = "${result?.paths[0]}".replaceAll("\\", "\\\\");
      _imageFile = File(result!.paths[0]!);
    });
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.pink,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('سفارش جدید',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0)),
        ),
        body: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white38),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(4)
                      ,child:
                      Card(
                        child:Container( padding: EdgeInsets.all(8),
                          child: Row(children: [
                            Expanded(child: TextFormField(decoration: InputDecoration(hintText: "نام مشتری",labelText: "نام مشتری"),controller: nameEditTextController,),),
                            Expanded(child: TextFormField(decoration: InputDecoration(hintText: "شماره تماس",labelText: "شماره تماس"),controller: contactEditTextController,),),
                            Expanded(child: TextFormField(onTap: openDatePicker,decoration: InputDecoration(hintText: "تاریخ تحویل",labelText: "تاریخ تحویل"),controller: deliverDateEditTextController,),),
                            Expanded(child:
                            DropdownButtonFormField(
                              decoration: InputDecoration(labelText: "نوع مشتری"),
                              value: customerTypeDropDownValue,
                              items: customerTypeDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                              onChanged: (String? value) {setState(() {
                                customerTypeDropDownValue = value!;
                                widget.order.clientType = value;
                              });},
                            )),
                            Expanded(child:
                            DropdownButtonFormField(
                              decoration: InputDecoration(labelText: "وضعیت سفارش"),
                              value: statusDropDownValue,
                              items: statusDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                              onChanged: (String? value) {setState(() {
                                statusDropDownValue = value!;
                                widget.order.status = value;
                              });},)

                            )
                          ],),
                        ) ,),
                    ),
                    Padding(padding: EdgeInsets.all(4),
                      child: Card(
                        child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Flexible(flex: 2,
                                    child: Row(children: [
                                      Column(children: [
                                        Row(
                                          children: [
                                            Text("بیعانه"),
                                            Checkbox(
                                                value: feeCheckBoxValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    feeCheckBoxValue = value!;
                                                    widget.order.feeOrder = "${value}";
                                                  });
                                                })
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("کاغذی"),
                                            Checkbox(
                                                value: deliveryPaperCheckBoxValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    deliveryPaperCheckBoxValue = value!;
                                                    widget.order.paperDelivery =
                                                    "${value}";
                                                  });
                                                })
                                          ],
                                        ),
                                      ],),
                                      Column(children: [
                                        Row(
                                          children: [
                                            Text("تحویل فوری"),
                                            Checkbox(
                                                value: instantDeliveryCheckBoxValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    instantDeliveryCheckBoxValue = value!;
                                                    widget.order.instantDelivery =
                                                    "${value}";
                                                  });
                                                })
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text("تحویل مشتری"),
                                            Checkbox(
                                                value: deliveryByCustomerCheckBoxValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    deliveryByCustomerCheckBoxValue =
                                                    value!;
                                                    widget.order.customerDelivery =
                                                    "${value}";
                                                  });
                                                })
                                          ],
                                        ),

                                      ],)




                                    ],)),
                                Flexible(flex: 2,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "توضیحات سفارش",
                                        labelText: "توضیحات سفارش",
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      controller: descriptionEditTextController,
                                    )),
                                Flexible(
                                    flex: 4,
                                    child: Row(
                                      children: [



                                        Expanded(child:DesignerDropDown(callback: onChangeDesignerDropDown,hint: "${widget.order.designerFullName}",),),
                                        Expanded(child:Workshop1DropDown(callback: onChangeWorkshop1DropDown,hint: "${widget.order.workshop1fullName}",),),
                                        Expanded(child:Workshop2DropDown(callback: onChangeWorkshop2DropDown,hint: "${widget.order.workshop2fullName}",),),
                                      ],
                                    ))
                              ],
                            )
                        ),
                      ),),
                    SizedBox(height: 32,),
                    Padding(padding: EdgeInsets.all(4),
                      child:Card(
                        child: Container(padding: EdgeInsets.all(8),
                            child:
                            Row(children: [


                              Expanded(child: DropdownButtonFormField(
                                decoration: InputDecoration(labelText: "نوع محصول"),
                                value: productTypeDropDownValue,
                                items: productTypeDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                                onChanged: (String? value) {setState(() {
                                  productTypeDropDownValue = value!;
                                  widget.order.productType = value;

                                  switch (productTypeDropDownValue){
                                    case "پلاک اسم":
                                      setState(() {
                                        widget.order.orderMeta = {"plate_language": "انگلیسی", "plate_type": "تک حلقه", "plate_hack_type": "براق"}.toString();
                                      });

                                      break;

                                    case "النگو":
                                      setState(() {
                                        widget.order.orderMeta = {"bangle_color": "زرد", "bangl_size": "نوزادی-0"}.toString();
                                      });
                                      break;

                                    case "گوشواره":
                                      setState(() {
                                        widget.order.orderMeta = {"earrings_type": "عصایی", "earrings_hack_type": "براق"}.toString();
                                      });
                                      break;

                                    case "دستبند":
                                      setState(() {
                                        widget.order.orderMeta = {"bracelet_type": "پرچی", "bracelet_leather_type": "طبیعی"}.toString();
                                      });
                                      break;

                                    case "دوره سنگ":
                                      setState(() {
                                        widget.order.orderMeta = {"stone_around_type": "ساده"}.toString();
                                      });
                                      break;
                                    default:
                                      widget.order.orderMeta = {}.toString();


                                  }


                                });},
                              )),
                              Expanded(child: TextFormField(decoration: InputDecoration(hintText: "کد محصول",labelText: "کد محصول"),controller: productCodeEditTextController,),),
                              Expanded(child: TextFormField(decoration: InputDecoration(hintText: "وزن محصول",labelText: "وزن محصول"),controller: productWeightTextController,),),
                              InkWell(
                                onTap: (){openImagePicker();},
                                child:
                                _imageFile != null ? Image.file(_imageFile!,height: 256,  ): const Text('برای انتخاب عکس کلیک کنید'),
                              ),

                            ],)
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(4),
                      child:Card(
                        child: Container(padding: EdgeInsets.all(8),
                          child:  ProductMetaSelections(callback: onChangeProductMeta, meta: widget.order.orderMeta ,productType: productTypeDropDownValue,),
                        ),
                      )
                      ,),
                    Container(padding: EdgeInsets.all(4),
                    child:SizedBox(height: 64,width: size.width,
                      child:
                      ElevatedButton(onPressed: () async {
                        collectFields();
                        print(widget.order.toJson());

                        var res = await AdminApi.addOrder(widget.order);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));

                        Navigator.pop(context);

                      }, child: Text("ثبت سفارش"),)
                      ,)
                      ,)
                    ,

                    // Add TextFormFields and ElevatedButton here.
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}