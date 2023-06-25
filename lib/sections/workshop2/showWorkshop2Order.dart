

import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../helper/workshop2Api.dart';


// Define a custom Form widget.
class ShowWorkshop2OrderScreen extends StatefulWidget {
  ShowWorkshop2OrderScreen({super.key,required this.order});
  orderData order;



  @override
  ShowWorkshop2OrderScreenState createState() {
    return ShowWorkshop2OrderScreenState();
  }
}


class ShowWorkshop2OrderScreenState extends State<ShowWorkshop2OrderScreen> {

  List<DataRow> tableItem=[DataRow(cells: [DataCell(Text("کلید")),DataCell(Text("مقدار"))])];
  TextEditingController imageEditTextController=TextEditingController();
  bool _enableFileButton=false;


  onChangeDesignerDropDown(value){
    setState(() {
      widget.order.designerId = value["id"];
      widget.order.designerFullName = value["fullName"];
    });
  }
  openImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['*'],
    );
    setState(() {
      if("${result?.paths[0]}"== "null"){
        _enableFileButton=false;
      }else{
        _enableFileButton=true;
      }
      imageEditTextController.text = "${result?.paths[0]}";
      widget.order.workshop2File = "${result?.paths[0]}".replaceAll("\\", "\\\\");
    });
  }

  @override
  void initState() {
    super.initState();

    initOrderMeta();

  }

  initOrderMeta()async{
    Map<String, dynamic> orderMetaList = json.decode(widget.order.orderMeta!);
    orderMetaList.forEach((key, value) {
      tableItem.add(DataRow(cells: [DataCell(Text("${key}")),DataCell(Text("${value}"))]));
    });

  }


  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 720;
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.cyan,
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
        body:SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.order.status == "در انتظار بررسی"
                      ? Colors.lightGreenAccent.withOpacity(0.1)
                      : widget.order.status == "تکمیل نهایی"
                      ? Colors.lightGreen.withOpacity(0.3)
                      : widget.order.status == "ارسال به طراح"
                      ? Colors.lightBlueAccent.withOpacity(0.1)
                      : widget.order.status == "ارسال به کارگاه"
                      ? Colors.amberAccent.withOpacity(0.1)
                      : widget.order.status == "برگشت از طراح"
                      ? Colors.lightBlue.withOpacity(0.3)
                      : widget.order.status == "برگشت از کارگاه"
                      ? Colors.amber.withOpacity(0.3)
                      : Colors.redAccent.withOpacity(0.3),
                ),
              child:Center(
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(8)
                      ,child:
                      Card(child:
                      Container(padding:EdgeInsets.all(16),child:
                      Row(
                        children: [
                          Expanded(child: Column(children: [Text("نام مشتری",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.clientFullName}")],)),
                          Expanded(child: Column(children: [Text("کارگاه 2",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.workshop2fullName}")],)),
                          Expanded(child: Column(children: [Text("تاریخ سفارش",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.orderDate}")],)),
                          Expanded(child: Column(children: [Text("تاریخ تحویل",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.deliveryDate}")],)),
                        ],)
                        ,)

                        ,),
                    ),
                    Padding(padding: EdgeInsets.all(4),
                      child:Card(
                        child:
                        Container(margin:EdgeInsets.all(16),child:
                        // Flex(       direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                        Row(
                          children: [
                            Expanded(child:Column(children: [Text("نوع سفارش",style: TextStyle(fontSize: 14,color: Colors.grey)),Text("${widget.order.orderType}")])),
                            Expanded(child:Column(children: [Text("گیرنده سفارش",style: TextStyle(fontSize: 14,color: Colors.grey)),Text("${widget.order.orderRecipient}")])),

                            Expanded(child:Column(children: [Text("توضیحات",style: TextStyle(fontSize: 14,color: Colors.grey)),Text("${widget.order.description}")])),
                            Expanded(child: Column(children: [
                              Text("${widget.order.instantDelivery=="true" ? "✓ تحویل فوری":""}"),
                              Text("${widget.order.paperDelivery=="true" ? "✓ کاغذی":""}"),
                              Text("${widget.order.feeOrder=="true" ? "✓ بیعانه":""}"),
                              Text("${widget.order.customerDelivery=="true" ? "✓ تحویل مشتری":""}"),
                            ],)),


                          ]
                          ,)
                          ,),

                      )
                      ,),
                    Padding(padding: EdgeInsets.all(8),
                      child:Card(
                        child: Container(margin: EdgeInsets.all(16),
                          child:
                          Row(
                            children: [
                              Expanded(child:
                              InkWell(onTap: (){
                                launchUrl(Uri.parse(widget.order.image!.contains("https")?"${widget.order.image}":"${dotenv.env['API_URL']}/public/uploads/${widget.order!.image}"));

                              },child: Image.network(widget.order.image!.contains("https")?"${widget.order.image}":"${dotenv.env['API_URL']}/public/uploads/${widget.order!.image}"),
                              )),
                              Expanded(
                                  child:
                                  Column(children: [
                                    Row(
                                      children: [
                                        Expanded(child: Column(children: [Text("نوع محصول",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.productType}")],)),
                                        Expanded(child: Column(children: [Text("کد",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.code}")],)),
                                        Expanded(child: Column(children: [Text("محصول",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.weight}")],)),
                                      ],)
                                  ],)
                              ),
                              Expanded(child:
                              Column(children: [

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
                            ],),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(8),
                      child:Card(
                        child: Row(
                          children: [
                            Expanded(child: SizedBox(child:OutlinedButton(onPressed: () {
                              launchUrl(Uri.parse("${dotenv.env['API_URL']}/public/uploads/${widget.order.designerFile}"));

                            }, child: Text("فایل طراح"),) ,),),
                            Expanded(child: SizedBox(child:OutlinedButton(onPressed: () {
                              launchUrl(Uri.parse("${dotenv.env['API_URL']}/public/uploads/${widget.order.workshop1File}"));

                            }, child: Text("فایل کارگاه یک"),) ,),),
                            Expanded(child: SizedBox(child:OutlinedButton(onPressed: () {
                              launchUrl(Uri.parse("${dotenv.env['API_URL']}/public/uploads/${widget.order.workshop2File}"));

                            }, child: Text("فایل کارگاه دو"),) ,),),

                          ],
                        ),

                      )
                      ,),

                    Padding(padding: EdgeInsets.all(8),
                      child:Visibility(visible: widget.order.status=="ارسال به کارگاه"? true:false,
                        child:Card(
                        child: Container(margin: EdgeInsets.all(16),
                          child:
                          Row(
                            children: [
                              Expanded(child:Padding(padding: EdgeInsets.all(8)
                                  ,child: TextFormField(
                                  onTap: openImagePicker,
                                  controller: imageEditTextController,
                                  decoration: InputDecoration(
                                      hintText:"${widget.order.workshop2File}"==""?"انتخاب فایل":"تغییر فایل",
                                      labelText: "${widget.order.workshop2File}"==""?"انتخاب فایل":"تغییر فایل"),
                                ),),),
                              Expanded(child:
                              Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [
                                OutlinedButton(onPressed:_enableFileButton?  () async {

                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فایل در حال ارسال است")));
                                  _enableFileButton=false;
                                  var res = await Workshop2Api.SendOrderFileWorkshop2(widget.order);
                                  setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
                                  });
                                }:null, child: Padding(padding: EdgeInsets.all(16),child: Text("ارسال فایل") )
                                ),
                                SizedBox(height: 16,),
                                ElevatedButton(onPressed:"${widget.order.workshop2File}".contains("workshop2File")? () async {
                                  var res = await Workshop2Api.completeOrderWorkshop2(widget.order);
                                  setState(() {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
                                  Navigator.pop(context);
                                  });
                                }:null, child: Padding(padding: EdgeInsets.all(16),child:  Text("تکمیل سفارش"))
                                ),

                              ],)
                              ),
                            ],
                          ),
                        ),
                      )
                        ,)),
                    SizedBox(height: 32,),
                    // Add TextFormFields and ElevatedButton here.
                  ],
                ),
              )
              ,)
              ],
          ),
        )




    );
  }
}