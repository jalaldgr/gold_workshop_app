

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/sections/admin/orders/designerDropDown.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

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
  var statusDropDownItems = ['در انتظار بررسی','تکمیل نهایی' , 'در حال طراحی','در کارگاه 1','در کارگاه 2','تکمیل طراحی','تکمیل کارگاه 1','تکمیل کارگاه 2' ,'لغو شده'];
  String productTypeDropDownValue = 'پلاک اسم';
  var productTypeDropDownItems = ["پلاک اسم","انگشتر","النگو","دستبند","گوشواره","دوره سنگ","سرویس طلا","نیم ست طلا","آویز طلا",
    "پا بند طلا","رو لباسی طلا","جواهرات","ساعت طلا","دستبند چرمی طلا","دستبند مهره ای فانتزی طلا","تک پوش طلا","گردنبند","حلقه ست",
    "اکسسوری طلا","محصولات نفره","آویز ساعت و دستبند طلا","پیرسینگ طلا","زنجیر طلا","سنجاق سینه طلا","مد روز","کودک و نوزاد",
    "طلای مناسبتی","طوق و بنگل طلا","تمیمه","انگشتر مردانه","زنجیر مردانه","دستبند مردانه","انگشتر زنانه","هدایای اقتصادی","برند ها"];
  String orderMetaDropDownValue = 'وزن';
  var orderMetaDropDownItems = [ 'وزن','کد' ];
  bool instantDeliveryCheckBoxValue = false;
  bool deliveryByCustomerCheckBoxValue = false;
  bool feeCheckBoxValue = false;
  bool deliveryPaperCheckBoxValue = false;
  List<DataRow> tableItem=[];

  TextEditingController orderMetaEditTextController=TextEditingController();
  TextEditingController nameEditTextController=TextEditingController();
  TextEditingController contactEditTextController=TextEditingController();
  TextEditingController descriptionEditTextController=TextEditingController();
  TextEditingController deliverDateEditTextController=TextEditingController();
  TextEditingController imageEditTextController=TextEditingController();
  TextEditingController fileEditTextController=TextEditingController();
  File? _imageFile;



  onSelectedRow( String row) async {
    setState(() {

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
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white38),
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(4)
                      ,child:
                      Card(child:
                        Container(padding: EdgeInsets.all(8),
                          child: Row(children: [
                            Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "نام مشتری"),controller: nameEditTextController,),),
                            Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "شماره تماس"),controller: contactEditTextController,),),
                            Expanded(child: TextFormField(onTap: openDatePicker,decoration: InputDecoration.collapsed(hintText: "تاریخ تحویل"),controller: deliverDateEditTextController,),),
                            Expanded(child:
                            DropdownButton(
                              value: customerTypeDropDownValue,
                              items: customerTypeDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                              onChanged: (String? value) {setState(() {
                                customerTypeDropDownValue = value!;
                              });},
                            )),
                            Expanded(child:
                            DropdownButton(
                              value: statusDropDownValue,
                              items: statusDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                              onChanged: (String? value) {setState(() {
                                statusDropDownValue = value!;
                              });},)

                            ),
                          ],),
                        ),),
                    ),
                    Padding(padding: EdgeInsets.all(4),
                      child:Card(
                        child: Container( padding: EdgeInsets.all(8),
                          child:
                          Row(children: [
                            Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "توضیحات"),controller: descriptionEditTextController,maxLines: null,)),
                            Expanded(child:
                            Row(children: [
                              Expanded(child:

                              Row(children: [
                                Text("تحویل فوری"),
                                Checkbox(
                                    value: instantDeliveryCheckBoxValue,
                                    onChanged: (value) {setState(() {instantDeliveryCheckBoxValue = value!;
                                    widget.order.instantDelivery = "${value}";
                                    });})
                              ],)
                              ),
                              Expanded(
                                  child:
                                  Row(children: [
                                    Text("کاغذی"),
                                    Checkbox(
                                        value: deliveryPaperCheckBoxValue,
                                        onChanged: (value) {setState(() {deliveryPaperCheckBoxValue = value!;
                                        widget.order.paperDelivery = "${value}";
                                        });})
                                  ],)
                              ),
                              Expanded(child:
                              Row(children: [
                                Text("بیعانه"),
                                Checkbox(
                                    value: feeCheckBoxValue,
                                    onChanged: (value) {setState(() {feeCheckBoxValue = value!;
                                    widget.order.feeOrder = "${value}";
                                    });})
                              ],)
                              ),
                              Expanded(child:
                              Row(children: [
                                Text("تحویل مشتری"),
                                Checkbox(
                                    value: deliveryByCustomerCheckBoxValue,
                                    onChanged: (value) {setState(() {deliveryByCustomerCheckBoxValue = value!;
                                    widget.order.customerDelivery = "${value}";
                                    });})
                              ],)
                              ),],)
                            )

                          ],),),
                      )

                      ,),
                    SizedBox(height: 32,),
                    Padding(padding: EdgeInsets.all(4),
                      child:Card(
                        child: Container(padding: EdgeInsets.all(8),
                          child:
                          Row(children: [
                            InkWell(
                              onTap: (){openImagePicker();},
                              child:
                              _imageFile != null ? Image.file(_imageFile!, fit: BoxFit.cover): const Text('برای انتخاب عکس کلیک کنید'),
                            ),

                            Expanded(child:
                            Column(children: [
                              Row(
                                children: [
                                  Expanded(child:DropdownButton(
                                    hint: Text("ویژگی"),
                                    value: orderMetaDropDownValue,
                                    items: orderMetaDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        orderMetaDropDownValue = value!;
                                        orderMetaEditTextController.text='';});
                                      // widget.order
                                    },
                                  )),
                                  Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "مقدار"),controller: orderMetaEditTextController,)),
                                  Expanded(child:IconButton( onPressed: (){
                                    setState(() {
                                      tableItem.add(DataRow(cells: [DataCell(Text("${orderMetaDropDownValue}")),DataCell(Text("${orderMetaEditTextController.text}"))]
                                        // ,onSelectChanged:(b) {onSelectedRow("asd");}
                                      ));

                                    });
                                  }, icon: Icon(Icons.add),),
                                  )
                                ],
                              ),

                              DataTable(
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      'ویژگی',
                                      style: TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'مقدار',
                                      style: TextStyle(fontStyle: FontStyle.italic),
                                    ),
                                  ),

                                ],
                                rows: tableItem,
                              )
                            ],)



                            ),
                            Expanded(child: DropdownButton(
                              value: productTypeDropDownValue,
                              items: productTypeDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                              onChanged: (String? value) {setState(() {
                                productTypeDropDownValue = value!;
                              });},
                            ))
                          ],),
                        ),
                      )
                      
                      ,),

                    Padding(padding: EdgeInsets.all(4),
                      child:Card(
                        child: Container(padding: EdgeInsets.all(8),
                          child:
                          Row(children: [
                            Expanded(child:DesignerDropDown(callback: onChangeDesignerDropDown, hint: "طراح"),),
                            Expanded(child:Workshop1DropDown(callback: onChangeWorkshop1DropDown,hint: "کارگاه 1",),),
                            Expanded(child:Workshop2DropDown(callback: onChangeWorkshop2DropDown,hint: "کارگاه 2",),),
                          ],),
                        ),
                      )

                      ,),
                    ElevatedButton(onPressed: () async {
                      collectFields();
                      print(widget.order.toJson());

                      var res = await AdminApi.addOrder(widget.order);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
                    }, child: Text("ثبت سفارش"),)
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