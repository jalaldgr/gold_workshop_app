

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/sections/admin/orders/designerDropDown.dart';
import 'package:gold_workshop/sections/admin/orders/productMetaSelections.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'workshop1DropDown.dart';
import 'workshop2DropDown.dart';

// Define a custom Form widget.
class EditOrderScreen extends StatefulWidget {
  orderData order;
  EditOrderScreen({super.key,required this.order});

  @override
  EditOrderScreenState createState() {
    return EditOrderScreenState();
  }
}



// Define a corresponding State class.
// This class holds data related to the form.
class EditOrderScreenState extends State<EditOrderScreen> {
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
  TextEditingController productCodeEditTextController=TextEditingController();
  TextEditingController productWeightTextController=TextEditingController();

  TextEditingController descriptionEditTextController=TextEditingController();
  TextEditingController deliverDateEditTextController=TextEditingController();
  TextEditingController imageEditTextController=TextEditingController();
  File? _imageFile ;
  bool selectImage = false;



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
  onChangeProductMeta(value){
    setState(() {
      widget.order.orderMeta = value;
      print(widget.order.orderMeta);
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
      widget.order.code = productCodeEditTextController.text;
      widget.order.weight = productWeightTextController.text;
      if(!selectImage)widget.order.image="";

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
  openImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['*'],
    );
      if(result?.paths[0]!=null){

        setState(() {
          _imageFile = File(result!.paths[0]!);
          widget.order.image = "${result.paths[0]}".replaceAll("\\", "\\\\");
        });
        selectImage = true;
      }

  }

  initialize_form(){
    nameEditTextController.text="${widget.order.clientFullName}";
    contactEditTextController.text="${widget.order.clientMobile}";
    descriptionEditTextController.text="${widget.order.description}";
    deliverDateEditTextController.text="${widget.order.deliveryDate}";
    productWeightTextController.text="${widget.order.weight}";
    productCodeEditTextController.text="${widget.order.code}";


    instantDeliveryCheckBoxValue = widget.order.instantDelivery=="true"? true : false ;
    deliveryByCustomerCheckBoxValue = widget.order.customerDelivery=="true"? true : false ;
    deliveryPaperCheckBoxValue = widget.order.paperDelivery=="true"? true : false ;
    feeCheckBoxValue = widget.order.feeOrder=="true"? true : false ;
    customerTypeDropDownValue = widget.order.clientType!;
    statusDropDownValue = widget.order.status!;
    productTypeDropDownValue = widget.order.productType!;

  }


  @override
  void initState() {
    super.initState();
    initialize_form();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.pink,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('ویرایش سفارش',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Stack(
              children: [
          Container(
          decoration: BoxDecoration(color: widget.order.status=="در انتظار بررسی"?Colors.lightGreenAccent.withOpacity(0.1):
          widget.order.status=="تکمیل نهایی"?Colors.lightGreen.withOpacity(0.3):
          widget.order.status=="ارسال به طراح"?Colors.lightBlueAccent.withOpacity(0.1):
          widget.order.status=="ارسال به کارگاه"?Colors.amberAccent.withOpacity(0.1):
          widget.order.status=="برگشت از طراح"?Colors.lightBlue.withOpacity(0.3):
          widget.order.status=="برگشت از کارگاه"?Colors.amber.withOpacity(0.3)  :
          Colors.redAccent.withOpacity(0.3),
          ),
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(8)
                ,child:Card(
                    child:Container( padding: EdgeInsets.all(16),
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
                Padding(padding: EdgeInsets.all(8),
                 child: Card(
                    child: Container(
                      padding: EdgeInsets.all(16),
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
                Padding(padding: EdgeInsets.all(8),
                  child:Card(
                    child: Container(padding: EdgeInsets.all(16),
                    child:
                    Row(children: [


                      Expanded(child: DropdownButtonFormField(
                        decoration: InputDecoration(labelText: "نوع محصول"),
                        value: productTypeDropDownValue,
                        items: productTypeDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                        onChanged: (String? value) {setState(() {
                          productTypeDropDownValue = value!;
                          widget.order.productType = value;

                        });},
                      )),
                      Expanded(child: TextFormField(decoration: InputDecoration(hintText: "کد محصول",labelText: "کد محصول"),controller: productCodeEditTextController,),),
                      Expanded(child: TextFormField(decoration: InputDecoration(hintText: "وزن محصول",labelText: "وزن محصول"),controller: productWeightTextController,),),
                      Visibility(visible: !selectImage,
                          child: InkWell(
                              child: Image.network("${dotenv.env['API_URL']}/public/uploads/${widget.order.image}",width: 128,),
                              onTap: openImagePicker)
                      ),
                      Visibility(visible: selectImage,
                          child: InkWell(
                              child: _imageFile!=null ?Image.file(_imageFile!,height: 256,  ):Text(""),
                              onTap: openImagePicker)
                      ),

    ],)
                      ),
                  ),
                ),

                Padding(padding: EdgeInsets.all(8),
                  child:Card(
                    child: Container(padding: EdgeInsets.all(16),
                      child:  ProductMetaSelections(callback: onChangeProductMeta, meta: widget.order.orderMeta ,productType: productTypeDropDownValue,),
                    ),
                  )
                  ,),
                SizedBox(height: 32,),
                Padding(padding: const EdgeInsets.all(8)
                  ,child:SizedBox(width: size.width-8,height: 64,
                    child: ElevatedButton(onPressed: () async {
                      collectFields();

                      var res = await AdminApi.updateOrder(widget.order);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
                      Navigator.pop(context);

                    }, child: Text("بروزرسانی"),),
                  ),
                ),
                SizedBox(height: 348,)

                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          )
      ,])


    ));
  }
}