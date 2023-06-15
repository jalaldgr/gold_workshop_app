

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/sections/admin/orders/designerDropDown.dart';
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
        print("${result?.paths[0]}");

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
        body: Container(
          decoration: BoxDecoration(color: Colors.white38),
          child:Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(4)
                ,child:Card(
                    child:Container( padding: EdgeInsets.all(8),
                      child: Row(children: [
                        Expanded(child: TextFormField(decoration: InputDecoration(hintText: "نام مشتری",labelText: "نام مشتری"),controller: nameEditTextController,),),
                        Expanded(child: TextFormField(decoration: InputDecoration(hintText: "شماره تماس",labelText: "شماره تماس"),controller: contactEditTextController,),),
                        Expanded(child:Column(
                          children: [
                            Text("نوع مشتری"),
                            DropdownButton(
                              value: customerTypeDropDownValue,
                              items: customerTypeDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                              onChanged: (String? value) {setState(() {
                                customerTypeDropDownValue = value!;
                                widget.order.clientType = value;
                              });},
                            )
                          ],
                        )),
                        Expanded(child: TextFormField(onTap: openDatePicker,decoration: InputDecoration(hintText: "تاریخ تحویل",labelText: "تاریخ تحویل"),controller: deliverDateEditTextController,),),
                      ],),
                    ) ,),
                ),
                Padding(padding: EdgeInsets.all(4),
                 child:Card(
                   child: Container( padding: EdgeInsets.all(8),
                     child: Row(children: [
                       Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "توضیحات"),controller: descriptionEditTextController,)),
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
                       ),

                     ],),
                   ),
                 )
                 

                  ,),
                Padding(padding: EdgeInsets.all(4),
                  child:Card(
                    child: Container(padding: EdgeInsets.all(8),
                    child:
                    Row(children: [
                      Visibility(visible: !selectImage,
                        child: InkWell(
                            child: Image.network("${dotenv.env['API_URL']}/public/uploads/${widget.order.image}",width: 256,),
                            onTap: openImagePicker)
                      ),
                      Visibility(visible: selectImage,
                          child: InkWell(
                              child: _imageFile!=null ?Image.file(_imageFile!,height: 256,  ):Text(""),
                              onTap: openImagePicker)
                      ),

                      Expanded(child:
                      Column(children: [
                        Row(
                          children: [
                            Expanded(child:DropdownButton(
                              value: orderMetaDropDownValue,
                              items: orderMetaDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  orderMetaDropDownValue = value!;
                                  orderMetaEditTextController.text='';});
                                // widget.order
                              },
                            )),
                            Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: ""),controller: orderMetaEditTextController,)),
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
                                'عنوان',
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
                          widget.order.productType = value;
                        });},
                      )),
    Expanded(child:
    DropdownButton(
    value: statusDropDownValue,
    items: statusDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
    onChanged: (String? value) {setState(() {
    statusDropDownValue = value!;
    widget.order.status = value;
    });},)

    )

    ],)
                      ),
                  ),
                ),

                Padding(padding: EdgeInsets.all(4),
                  child:Card(
                    child: Container(padding: EdgeInsets.all(8),
                      child: Row(children: [
                        Expanded(child:DesignerDropDown(callback: onChangeDesignerDropDown,hint: "${widget.order.designerFullName}",),),
                        Expanded(child:Workshop1DropDown(callback: onChangeWorkshop1DropDown,hint: "${widget.order.workshop1fullName}",),),
                        Expanded(child:Workshop2DropDown(callback: onChangeWorkshop2DropDown,hint: "${widget.order.workshop2fullName}",),),
                      ],),
                    ),
                  )
                  ,),
                 Padding(padding: const EdgeInsets.all(4)
                 ,child:SizedBox(width: size.width-4,height: 64,
                     child: ElevatedButton(onPressed: () async {
                       collectFields();
                       print("${widget.order.toJson()}");

                       var res = await AdminApi.updateOrder(widget.order);
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
                       Navigator.pop(context);

                     }, child: Text("بروزرسانی"),),
                   ),
                 )
                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          )
      ,)


    );
  }
}