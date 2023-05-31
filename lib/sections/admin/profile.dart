import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/userModel.dart';


class AdminProfileScreen extends StatefulWidget {
  @override
  _AdminProfileScreenState createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
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
        Uri.parse('${dotenv.env['API_URL']}/admin/get/$userID'),
        headers: {'Authorization': 'Bearer $token'},
        );
    print(jsonDecode(response.body));
    userModel=userData.fromSimpleJson(jsonDecode(response.body));
    print("im here");

    return userModel;
  }

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
                        Colors.yellow,
                        Colors.yellowAccent
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
    );
  }
}
