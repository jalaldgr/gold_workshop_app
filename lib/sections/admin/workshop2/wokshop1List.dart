import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/models/userModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import '../../../helper/serverApi.dart';



class Workshop2sList extends StatefulWidget {
  const Workshop2sList({Key? key}) : super(key: key);

  @override
  _Workshop2sListState createState() => _Workshop2sListState();
}

class _Workshop2sListState extends State<Workshop2sList> {
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
        title: const Text('کاربران کارگاه 2',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 22.0)),
      ),
      drawer: SideMenuAdmin(),
      backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: Center(
        child: FutureBuilder(
          future: AdminApi.getWorkshop2s(),
          builder: (BuildContext context,
              AsyncSnapshot<List<userData>> snapshot) =>
          snapshot.hasData && snapshot.data!.isNotEmpty
              ? Container(
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
                      snapshot.data?[index].fullName,
                      snapshot.data?[index].username,
                      snapshot.data?[index].id,
                      index);
                }),
          )
              : snapshot.hasError
              ? Center(
            child: Text('Error: ${snapshot.error}'),
          )
              : snapshot.data != null
              ? const Center(
            child: Text("کاربری ثبت نشده..."),
          )
              : CircularProgressIndicator(),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          tooltip: "ساخت کاربر جدید",
          child: const Icon(Icons.add),
          onPressed: () {
            userData user =new userData("", "", "", "", "","");
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
            top: 16,
            left: 16,
            right: 16,
            // this will prevent the soft keyboard from covering the text fields
            bottom: MediaQuery.of(context).viewInsets.bottom + 128,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'نام و نام خانوادگی',
                        labelText: "نام و نام خانوادگی"),
                    controller: fullNameController,
                  )),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'نام کاربری', labelText: "نام کاربری"),
                    controller: userNameController,
                  )),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'پسورد', labelText: "پسورد"),
                    controller: passwordController,
                    obscureText: true,
                  )),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: SizedBox(
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Save new journal

                        if (user.id != "") {
                          userData userUpdated = new userData(
                              userNameController.text,
                              fullNameController.text,
                              "Workshop2",
                              user.id,
                              passwordController.text,
                              "");
                          String response =
                          await AdminApi.updateWorkshop2(userUpdated);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${response}")));
                        }
                        if (user.id == "") {
                          userData userUpdated = new userData(
                              userNameController.text,
                              fullNameController.text,
                              "Workshop2",
                              "",
                              passwordController.text,
                              "");
                          String response =
                          await AdminApi.addWorkshop2(userUpdated);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${response}")));
                        }
                        // Close the bottom sheet
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: Text(user.id == "" ? 'ایجاد کاربر' : 'بروزرسانی'),
                    ),
                  ))
            ],
          ),
        ));
  }



  Widget _buildPaymentItem(BuildContext context, String? fullName,
      String? userName,String? id,int? index) {
    return InkWell(
        onTap: (){
          userData user =new  userData(userName, fullName,"Workshop2",id,"","");
          _showForm(user);
        },
        child: Card(child:
        Padding(padding: EdgeInsets.all(16),
          child: Row(children: [
            Flexible(flex: 11,child: Row(children: [
              Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "نام و نام خانوادگی",
                        style: TextStyle(fontSize: 11),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text("${fullName}")
                    ],
                  )),
              Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "نام کاربری",
                        style: TextStyle(fontSize: 11),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text("${userName}")
                    ],
                  )),


            ],)),
            Flexible(flex: 1,child: IconButton(
              tooltip: "حذف کاربر",
              icon: const Icon(Icons.delete),
              onPressed: () async {

                if(id != null){
                  deleteDesignerAlertDialog(context,id);

                }
              },
            ))
          ],),
        ),));
  }

  deleteDesignerAlertDialog(BuildContext context, String userId) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("انصراف",style: TextStyle(color: Colors.red),),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = TextButton(
      child: Text("تایید",style: TextStyle(color: Colors.blue,fontSize: 20)),
      onPressed:  () async {
        String response = await AdminApi.deleteWorkshop2(userId);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response}")));
        setState(()  {
          Navigator.of(context).pop();
        });

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("حذف کاربر"),
      content: Text("آیا از حذف این کاربر اطمینان دارید؟"),
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
