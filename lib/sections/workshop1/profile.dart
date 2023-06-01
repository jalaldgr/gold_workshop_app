import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/helper/workshop1Api.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/serverApi.dart';
import '../../models/userModel.dart';


class Workshop1ProfileScreen extends StatefulWidget {
  @override
  _Workshop1ProfileScreenState createState() => _Workshop1ProfileScreenState();
}

class _Workshop1ProfileScreenState extends State<Workshop1ProfileScreen> {
  TextEditingController fullNameController=TextEditingController();
  TextEditingController userNameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  Future<userData> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic user = jsonDecode(prefs.getString(
        "user")!); //convert string to json object. dynamic is flexible variable
    dynamic token = prefs.getString("jwt");
    dynamic userID =
    jsonDecode(prefs.getString('user')!)['id']; // get driver user id

    userData userModel =
    userData.fromJson(user); //construct UserModel from json object

    final response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/workshop1/get-workshop1/$userID'),
        headers: {'Authorization': 'Bearer $token'},
        );
    userModel=userData.fromSimpleJson(jsonDecode(response.body));
    print(response.body);
    return userModel;
  }

  @override
  void initState() {
    super.initState();
  }


  void _showForm(userData user) async {
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
                userData userUpdated =new  userData(user.username, fullNameController.text,"Workshop1",user.id,passwordController.text);
                String response = await Workshop1Api.updateWorkshop1(userUpdated);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response}")));
                  // Close the bottom sheet
                  Navigator.of(context).pop();
                  setState(() {});
                },
                child: Text('بروزرسانی'),
              )
            ],
          ),
        ));
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('پروفایل',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 22.0)),
      ),
      drawer: SideMenuAdmin(),
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder(
            future: fetchUserData(),
            builder: (BuildContext context, AsyncSnapshot<userData> snapshot) =>
            snapshot.hasData
                ? ListView(
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber,
                        Colors.amberAccent
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0.5, 0.9],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Text(
                        '${snapshot.data?.fullName}',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  child: Column(
                    children: <Widget>[

                    ],
                  ),
                )

              ],
            )
                : snapshot.hasError
                ? Center(
              child: Text("${snapshot.error}"),
            )
                : CircularProgressIndicator()),
      ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {

            SharedPreferences prefs = await SharedPreferences.getInstance();
            dynamic user = jsonDecode(prefs.getString(
                "user")!);
            userData userModel =userData.fromJson(user);
            _showForm(userData(userModel.username, userModel.fullName, "", userModel.id, ""));
          } ,
        )
    );
  }
}
