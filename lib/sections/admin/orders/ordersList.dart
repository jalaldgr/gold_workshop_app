import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/models/userModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:gold_workshop/sections/admin/orders/addNewOrder.dart';
import 'package:gold_workshop/sections/admin/orders/editOrder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/serverApi.dart';
import 'showOrder.dart';



class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
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
          backgroundColor: Colors.pink,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[IconButton(onPressed: (){setState(() {});}, icon: Icon(Icons.refresh))],
          title: const Text('لیست سفارش ها',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0)),
        ),
        drawer: SideMenuAdmin(),
        backgroundColor: Colors.white,
        body:SingleChildScrollView(child:
          Stack(
            children: [
              Center(
                child: FutureBuilder(
                  future: AdminApi.getOrders(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<orderData>> snapshot) =>
                  snapshot.hasData && snapshot.data!.isNotEmpty
                      ?
                  Padding(padding: EdgeInsets.all(4),
                      child:
                      Column(
                        children: [
                          Card(
                            child: Container(padding: EdgeInsets.all(8),
                              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 8,),
                                    Expanded(child: Text("ردیف" ,style: TextStyle(fontStyle: FontStyle.italic),)),
                                    Expanded(child: Text("نام مشتری",style: TextStyle(fontStyle: FontStyle.italic))),
                                    Expanded(child: Text("نوع محصول",style: TextStyle(fontStyle: FontStyle.italic))),
                                    Expanded(child: Text("تاریخ تحویل",style: TextStyle(fontStyle: FontStyle.italic))),
                                    Expanded(child: Text("وضعیت",style: TextStyle(fontStyle: FontStyle.italic))),
                                    SizedBox(width: 100,)
                                  ]
                              ),
                            ),),
                          Container(
                            child:ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return _buildPaymentItem(
                                    context,
                                    snapshot.data?[index],
                                    index);
                              }),
                          ),
                        ],
                      )
                  )
                      : snapshot.hasError
                      ? Center(
                    child: Text('Error: ${snapshot.error}'),
                  )
                      : snapshot.data != null
                      ? const Center(
                    child: Text("بدون طراح..."),
                  )
                      : CircularProgressIndicator(),
                ),
              )
            ],),)

        ,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewOrderForm(order: orderData.fromJson({
                      "clientFullName":"",
                      "plateName":"",
                      "description":"",
                      "image":"",
                      "code":"",
                      "weight":"",
                      "status":"",
                      "workshop1fullName":"",
                      "workshop1Id":"",
                      "workshop1File":"",
                      "workshop2fullName":"",
                      "workshop2Id":"",
                      "workshop2File":"",
                      "designerFullName":"",
                      "designerId":"",
                      "designerFile":"",
                      "createdDate":"",
                      "id":"",
                      "instantDelivery":"",
                      "customerDelivery":"",
                      "paperDelivery":"",
                      "feeOrder":"",
                      "orderMeta":"",
                      "woocommerceOrderId":"",
                      "clientMobile":"",
                      "clientType":"",
                      "productType":""

                    }),)));
          } ,
        )

    );
  }




  Widget _buildPaymentItem(BuildContext context,
       orderData? order,int? index) {
    return Padding(padding: EdgeInsets.all(4),
      child:
      Container( color: (index! % 2 == 0) ? Colors.brown.shade50 : Colors.lightBlue.shade50,height: 100,
        child:
        Card(
            child: Container(padding: EdgeInsets.all(8),
              child:Row(
                children: <Widget>[
                  Expanded(child: Text("${index}")),
                  Expanded(child: Text("${order?.clientFullName}")),
                  Expanded(child: Text("${order?.productType}")),
                  Expanded(child: Text("${order?.deliveryDate}")),
                  Expanded(child: Text("${order?.status}")),
                  SizedBox(width: 150,
                    child:Row(children: [
                      IconButton(onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowOrderScreen(order: order!,)));
                      }, icon: Icon(Icons.remove_red_eye)),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditOrderScreen(order: order!,)));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {

                          if(order?.id != null){
                            String response = await AdminApi.deleteOrder(order?.id);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response}")));
                          }
                          setState(() {});
                        },
                      ),
                    ],),)
                ]
            ),
            ),
        ),
      )

      ,);
  }
}
