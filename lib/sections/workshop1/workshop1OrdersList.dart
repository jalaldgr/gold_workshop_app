import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/helper/workshop1Api.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/models/userModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:gold_workshop/sections/admin/orders/addNewOrder.dart';
import 'package:http/http.dart' as http;
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../helper/serverApi.dart';
import 'showWorkshop1Order.dart';



class Workshop1OrdersList extends StatefulWidget {
  const Workshop1OrdersList({Key? key}) : super(key: key);

  @override
  _Workshop1OrdersListState createState() => _Workshop1OrdersListState();
}

class _Workshop1OrdersListState extends State<Workshop1OrdersList> {
  TextEditingController fullNameController=TextEditingController();
  TextEditingController userNameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();


  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.amber,
          actions: <Widget>[IconButton(onPressed: (){setState(() {});}, icon: Icon(Icons.refresh))],
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title:  Text('لیست سفارش ها   ${Jalali.now().formatFullDate()}',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0)),
        ),
        drawer: SideMenuAdmin(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Center(
                child: FutureBuilder(
                  future: Workshop1Api.getOrders(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<orderData>> snapshot) =>
                  snapshot.hasData && snapshot.data!.isNotEmpty
                      ? Column(
                    children: [

                      Container(
                        height: MediaQuery.of(context).size.height * 0.87,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(1.0)),
                        ),
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return _buildOrderItem(
                                  context,
                                  snapshot.data?[index],
                                  index);
                            }),
                      )
                    ],
                  )
                      : snapshot.hasError
                      ? Center(
                    child: Text('Error: ${snapshot.error}'),
                  )
                      : snapshot.data != null
                      ? const Center(
                    child: Text("بدون سفارش..."),
                  )
                      : CircularProgressIndicator(),
                ),
              )
            ],
          ),
        )

    );
  }



  Widget _buildOrderItem(BuildContext context,
      orderData? order,int? index) {
    return InkWell(onTap: () async {
      final value = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowWorkshop1OrderScreen(order: order!,)));
      setState(() {});
    },child: Padding(padding: EdgeInsets.all(4),
      child:
      Container( color: (index! % 2 == 0) ? Colors.brown.shade100 : Colors.lightBlue.shade100,height: 128,
        child:
        Card(color: order?.status=="در انتظار بررسی"?Colors.lightGreenAccent.shade100:
        order?.status=="تکمیل نهایی"?Colors.lightGreen:
        order?.status=="ارسال به طراح"?Colors.lightBlueAccent.shade100:
        order?.status=="ارسال به کارگاه"?Colors.amberAccent.shade100:
        order?.status=="برگشت از طراح"?Colors.lightBlue:
        order?.status=="برگشت از کارگاه"?Colors.amber  :
        Colors.redAccent.shade100,
          child: Container(padding: EdgeInsets.all(8),
            child:Row(children: [
              Expanded(child:
              Row(children: [
                Flexible(flex: 9,child:
                Column(children: [
                  Expanded(child:
                  Row(
                      children: <Widget>[
                        Text("${index+1}"),
                        SizedBox(width: 32,),
                        Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("نام مشتری",style: TextStyle(fontSize: 11),),Text("${order!.clientFullName}")],)),
                        Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("نوع محصول",style: TextStyle(fontSize: 11),),Text("${order!.productType}")],)),
                        Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("تاریخ سفارش",style: TextStyle(fontSize: 11),),Text("${order!.orderDate}")],)),
                        Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("تاریخ تحویل",style: TextStyle(fontSize: 11),),Text("${order!.deliveryDate}")],)),
                      ]
                  )),
                  SizedBox(height: 12,),
                  Expanded(child:
                  Row(
                    children: <Widget>[
                      SizedBox(width: 40,),
                      Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("سفارش گیرنده",style: TextStyle(fontSize: 11),),Text("سفارش گیرنده")],)),
                      Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("وضعیت سفارش",style: TextStyle(fontSize: 11),),Text("${order!.status}")],)),
                      Expanded(child:Row(children: [Text("${order.instantDelivery=="true" ? "✓ تحویل فوری":""}"),],)),
                      Expanded(child:Row(children: [Text("${order.paperDelivery=="true" ? "✓ کاغذی":""}"),],)),
                      Expanded(child:Row(children: [Text("${order.feeOrder=="true" ? "✓ بیعانه":""}"),],)),
                      Expanded(child:Row(children: [Text("${order.customerDelivery=="true" ? "✓ تحویل مشتری":""}"),],)),
                    ],
                  )),
                ],)


                ),
                Flexible(flex: 3,child:Row(children: [
                  Expanded(child:InkWell(
                      child: Image.network(order.image!.contains("https")?"${order.image}":"${dotenv.env['API_URL']}/public/uploads/${order!.image}"),
                      onTap: (){
                        launchUrl(Uri.parse(order.image!.contains("https")?"${order.image}":"${dotenv.env['API_URL']}/public/uploads/${order!.image}"));
                      })),
                  Expanded(child:
                  OutlinedButton(onPressed: () {
                    launchUrl(Uri.parse("${dotenv.env['API_URL']}/public/uploads/${order.designerFile}"));

                  }, child: Text("فایل طراح"),) ),
                ],) )

              ],))
            ],),

          ),
        ),
      )
      ,),);
  }
}
