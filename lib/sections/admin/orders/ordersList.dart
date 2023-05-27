import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/models/userModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../helper/serverApi.dart';



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
              child: Text("بدون طراح..."),
            )
                : CircularProgressIndicator(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            userData user =new userData("", "", "", "", "");
            _showForm(user);
          } ,
        )

    );
  }

  void _showForm(userData user) async {
    userNameController.text = user.username!;
    fullNameController.text = user.fullName!;
    passwordController.text = "";

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            // this will prevent the soft keyboard from covering the text fields
            bottom: MediaQuery.of(context).viewInsets.bottom + 120,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: 'نام و نام خانوادگی'),
                controller: fullNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'نام کاربری'),
                controller: userNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'پسورد'),
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Save new journal

                  if(user.id != ""){
                    userData userUpdated =new  userData(userNameController.text, fullNameController.text,"Designer",user.id,passwordController.text);
                    String response = await AdminApi.updateDesigner(userUpdated);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response}")));
                  }
                  if(user.id == ""){
                    userData userUpdated =new  userData(userNameController.text, fullNameController.text,"Designer","",passwordController.text);
                    String response = await AdminApi.addDesigner(userUpdated);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response}")));
                  }
                  // Close the bottom sheet
                  Navigator.of(context).pop();
                  setState(() {});
                },
                child: Text(user.id == ""  ? 'ایجاد کاربر' : 'بروزرسانی'),
              )
            ],
          ),
        ));
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
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // userData user =new  userData(userName, fullName,"Workshop1",id,"");
                  // _showForm(user);
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
      ),);
  }
}
