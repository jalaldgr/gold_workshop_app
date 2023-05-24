import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';
import '../models/userModel.dart';


class SideMenuAdmin extends StatefulWidget {
  @override
  _SideMenuAdminState createState() => _SideMenuAdminState();
}

class _SideMenuAdminState extends State<SideMenuAdmin> {
  String? _appVersion="";

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
  }

  // fetch userdata from shared preference and construct a User Model to show user's information in drawer header
  Future<userData> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _appVersion = prefs.getString('version')?? " ";// if version is empty, prefs.getString return null value and will make error....
    dynamic user = jsonDecode(prefs.getString(
        "user")!); //convert string to json object. dynamic is flexible variable
    userData userDataModel =
    userData.fromJson(user); //construct UserModel from json object
    return userDataModel;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
          future: fetchUserData(),
          builder: (BuildContext context, AsyncSnapshot<userData> snapshot) =>
              snapshot.hasData
                  ? Column(
                      children: <Widget>[
                        UserAccountsDrawerHeader(
                          accountName: Text(
                              "${snapshot.data?.fullName}",
                              style: const TextStyle(color: Colors.black87)),
                          accountEmail: Text("${snapshot.data?.username}",
                              style: const TextStyle(color: Colors.black87)),
                          decoration:
                              BoxDecoration(color: Colors.amber),

                        ),
                        Expanded(
                          child: ListView(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.payments_rounded),
                                title: Text("پروفایل"),
                                trailing: Icon(Icons.chevron_right),
                                onTap: (){

                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.support),
                                title: Text("لیست سفارش ها"),
                                trailing: Icon(Icons.chevron_right),
                                onTap: (){

                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.account_box),
                                title: Text("جدول های روزانه"),
                                trailing: Icon(Icons.chevron_right),
                                onTap: (){

                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.account_box),
                                title: Text("آرشیو جدول های روزانه"),
                                trailing: Icon(Icons.chevron_right),
                                onTap: (){

                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.account_box),
                                title: Text("لیست طراحان"),
                                trailing: Icon(Icons.chevron_right),
                                onTap: (){

                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.account_box),
                                title: Text("لیست کارگاه های 1"),
                                trailing: Icon(Icons.chevron_right),
                                onTap: (){

                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.account_box),
                                title: Text("لیست کارگاه های 2"),
                                trailing: Icon(Icons.chevron_right),
                                onTap: (){

                                },
                              ),
                              Divider(),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    logOut();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                        (Route<dynamic> route) => false);
                                  });
                                },
                                splashColor: Colors.greenAccent,
                                child: ListTile(
                                  leading: Icon(Icons.logout),
                                  title: Text("خروج"),
                                  trailing: Icon(Icons.chevron_right),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("ورژن اپلیکیشن  ${_appVersion}"),
                            ))
                      ],
                    )
                  : snapshot.hasError
                      ? Center(
                          child: Text(
                              "${snapshot.error}"), //if there is error, show a text with error message
                        )
                      : CircularProgressIndicator()),
    );
  }
}
