import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/models/userModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:gold_workshop/sections/admin/orders/addNewOrder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/serverApi.dart';
import 'showWorkshop1Orders.dart';



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
          backgroundColor: Colors.yellow,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('لیست سفارش ها',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0)),
        ),
        drawer: SideMenuAdmin(),
        backgroundColor: Colors.white,
        body: Center(
          child: FutureBuilder(
            future: AdminApi.getOrders(),
            builder: (BuildContext context,
                AsyncSnapshot<List<orderData>> snapshot) =>
            snapshot.hasData && snapshot.data!.isNotEmpty
                ? Column(
              children: [

                ListTile(
                onTap: null,
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                ),
                title: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: Text("شماره")),
                      Expanded(child: Text("نام پلاک")),
                      Expanded(child: Text("وضعیت")),
                      Expanded(child: Text("Id")),
                      SizedBox(width: 100,)
                    ]
                ),),

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
                        return _buildPaymentItem(
                            context,
                            snapshot.data?[index].clientFullName,
                            snapshot.data?[index].status,
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
        ),

    );
  }




  Widget _buildPaymentItem(BuildContext context,
      String? clientFullname,String? status , orderData? order,int? index) {
    return Padding(padding: EdgeInsets.all(4),
      child: ListTile(
          title: Row(
              children: <Widget>[
                Expanded(child: Text("${index}")),
                Expanded(child: Text("${order?.status}")),
              ]
          ),
          trailing: SizedBox(width: 100,
            child:Row(children: [
              IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowWorkshop1OrderScreen(order: order!,)));

                },
              ),
            ],),)
      ),);
  }
}
