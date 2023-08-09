

import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/helper/designerApi.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:url_launcher/url_launcher.dart';


// Define a custom Form widget.
class ShowDesignerOrderScreen extends StatefulWidget {
  ShowDesignerOrderScreen({super.key,required this.order});
  orderData order;



  @override
  ShowDesignerOrderScreenState createState() {
    return ShowDesignerOrderScreenState();
  }
}


class ShowDesignerOrderScreenState extends State<ShowDesignerOrderScreen> {

  List<DataRow> tableItem=[];

  TextEditingController imageEditTextController=TextEditingController();
  bool _enableFileButton=false;

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
      widget.order.designerFile = "${result?.paths[0]}".replaceAll("\\", "\\\\");
    });
  }



  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 720;
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.lightGreen,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('مشخصات سفارش',
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
                                              : widget.order.status == "برگشت طرح"
                                              ? Colors.pink.withOpacity(0.1)
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
                          Expanded(child: Column(children: [Text("طراح",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.designerFullName}")],)),
                          Expanded(child: Column(children: [Text("تاریخ سفارش",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.orderDate}")],)),
                          Expanded(child: Column(children: [Text("تاریخ تحویل",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.deliveryDate}")],)),
                        ],)
                        ,)

                        ,),
                    ),
                    Padding(padding: EdgeInsets.all(8),
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

                              },child:
                              Image.network(widget.order.image!.contains("https")?"${widget.order.image}":"${dotenv.env['API_URL']}/public/uploads/${widget.order!.image}")
                              )),
                              Expanded(
                                  child:
                                  Column(children: [
                                    Row(
                                      children: [
                                        Expanded(child: Column(children: [Text("نوع محصول",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.productType}")],)),
                                        Expanded(child: Column(children: [Text("کد محصول",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.code}")],)),
                                        Expanded(child: Column(children: [Text("وزن محصول",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.weight}")],)),
                                        Expanded(child: Column(children: [Text("کسر",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.deficiency}")],)),

                                      ],)
                                  ],)
                              ),
                              Expanded(child:Column(children: [
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
                            Expanded(child: SizedBox(child:OutlinedButton(onPressed: "${widget.order.designerFile}".contains("designerFile")? () {
                              launchUrl(Uri.parse("${dotenv.env['API_URL']}/public/uploads/${widget.order.designerFile}"));

                            }:null, child: Text("فایل طراح"),) ,),),
                            Expanded(child: SizedBox(child:OutlinedButton(onPressed:"${widget.order.workshop1File}".contains("workshop1File")? (){
                              launchUrl(Uri.parse("${dotenv.env['API_URL']}/public/uploads/${widget.order.workshop1File}"));

                            }:null, child: Text("فایل کارگاه یک"),) ,),),
                            Expanded(child: SizedBox(child:OutlinedButton(onPressed:"${widget.order.workshop2File}".contains("workshop2File")?  () {
                              launchUrl(Uri.parse("${dotenv.env['API_URL']}/public/uploads/${widget.order.workshop2File}"));

                            }:null, child: Text("فایل کارگاه دو"),) ,),),

                          ],
                        ),

                      )
                      ,),
                    Padding(padding: EdgeInsets.all(8),
                      child:Visibility(visible: widget.order.status=="ارسال به طراح"?true:false,
                        child:Card(
                          child: Container(margin: EdgeInsets.all(16),
                            child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(padding: EdgeInsets.all(16),
                                    child:
                                    TextFormField(
                                      onTap: openImagePicker,
                                      controller: imageEditTextController,
                                      decoration: InputDecoration(
                                          hintText:"${widget.order.designerFile}"==""?"انتخاب فایل":"تغییر فایل",
                                          labelText: "${widget.order.designerFile}"==""?"انتخاب فایل":"تغییر فایل"),
                                      textAlign: TextAlign.center,
                                    )
                                      ,),
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      OutlinedButton(
                                          onPressed:_enableFileButton? () async {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("فایل در حال ارسال است")));
                                            _enableFileButton=false;

                                            var res = await DesignerApi.SendOrderFileDesigner(widget.order);
                                              setState(() {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
                                              });

                                          }:null,// the null disable elevatedButton clicks
                                          child: Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Text("ارسال فایل"))),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      ElevatedButton(
                                          onPressed:"${widget.order.designerFile}".contains("designerFile")? () async {

                                            completeOrderAlertDialog(context);
                                          }:null,
                                          child: Padding(
                                              padding: EdgeInsets.all(16),
                                              child: Text("تکمیل سفارش"))),
                                    ],
                                  )),
                                ],
                              ),
                          ),
                        )
                        ,),
                    ),
                    SizedBox(height: 32,),

                  ],
                ),
              )
              ,)
              ],
          ),
        )




    );
  }

  completeOrderAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("انصراف",style: TextStyle(color: Colors.red),),
      onPressed:  () {
        Navigator.of(context).pop();},
    );
    Widget continueButton = TextButton(
      child: Text("تایید",style: TextStyle(color: Colors.blue,fontSize: 20)),
      onPressed:  () async {
        var res = await DesignerApi.completeOrderDesigner(widget.order);
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
          Navigator.pop(context);
          Navigator.pop(context);
        });

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تکمیل سفارش"),
      content: Text("آیا از تکمیل سفارش اطمینان دارید؟"),
      actions: [
        Column(children: [
          Row(children: [
            Expanded(child: cancelButton ),
            Expanded(child: continueButton )
          ],)
        ],)

      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}