

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/sections/admin/orders/designerDropDown.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';


// Define a custom Form widget.
class ShowWorkshop1OrderScreen extends StatefulWidget {
  ShowWorkshop1OrderScreen({super.key,required this.order});
  orderData order;



  @override
  ShowWorkshop1OrderScreenState createState() {
    return ShowWorkshop1OrderScreenState();
  }
}


class ShowWorkshop1OrderScreenState extends State<ShowWorkshop1OrderScreen> {

  List<DataRow> tableItem=[DataRow(cells: [DataCell(Text(";کلید")),DataCell(Text("مقدار"))])];


  onChangeDesignerDropDown(value){
    setState(() {
      widget.order.designerId = value["id"];
      widget.order.designerFullName = value["fullName"];
    });
  }





  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.yellow,
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
        body: Container(
          decoration: BoxDecoration(color: Colors.white38),
          child:Center(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(16)
                  ,child:
                  Row(children: [
                    Expanded(child: Column(children: [Text("نام مشتری",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.clientFullName}")],)),
                    Expanded(child: Column(children: [Text("شماره تماس",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.clientMobile}")],)),
                    Expanded(child: Column(children: [Text("نوع محصول",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.productType}")],)),
                    Expanded(child: Column(children: [Text("تاریخ تحویل",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.deliveryDate}")],)),
                  ],),
                ),
                SizedBox(height: 32,),
                Padding(padding: EdgeInsets.all(16),
                  child:Row(children: [
                    Expanded(child: Text("${widget.order.description}")),
                    Expanded(child:
                    Row(children: [
                      Expanded(child:

                      Row(children: [
                        Text("${widget.order.instantDelivery=="true" ? "تحویل فوری":""}"),

                      ],)
                      ),
                      Expanded(
                          child:
                          Row(children: [
                            Text("${widget.order.paperDelivery=="true" ? "کاغذی":""}"),
                          ],)
                      ),
                      Expanded(child:
                      Row(children: [
                        Text("${widget.order.feeOrder=="true" ? "بیعانه":""}"),

                      ],)
                      ),
                      Expanded(child:
                      Row(children: [
                        Text("${widget.order.customerDelivery=="true" ? "تحویل مشتری":""}"),

                      ],)
                      ),],)
                    )

                  ],)

                  ,),
                SizedBox(height: 32,),
                Padding(padding: EdgeInsets.all(16),
                  child:
                  Row(children: [
                    Expanded(child: Text("${widget.order.image}")),
                    Expanded(child:
                    Column(children: [
                      Row(
                        children: []

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
                    Expanded(child: Text("${widget.order.productType}")),
                  ],),),

                Padding(padding: EdgeInsets.all(16),
                  child:
                  Row(children: [
                    Expanded(child: Text("${widget.order.designerFullName}")),
                    Expanded(child: Text("${widget.order.workshop1fullName}")),
                    Expanded(child: Text("${widget.order.workshop2fullName}")),
                  ],)
                  ,),
                ElevatedButton(onPressed: () async {
                  print(widget.order.toJson());

                  // var res = await AdminApi.addOrder(widget.order);
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
                }, child: Text("بروزرسانی"),)
                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          )
          ,)


    );
  }
}