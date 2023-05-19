import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class Workshop2HomeScreen extends StatefulWidget {
  Workshop2HomeScreen(this.jwt, this.payload);

  factory Workshop2HomeScreen.fromBase64(String jwt) => Workshop2HomeScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  _Workshop2HomeScreenState createState() => _Workshop2HomeScreenState();
}

class _Workshop2HomeScreenState extends State<Workshop2HomeScreen> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.green),
          backgroundColor: Colors.amber,
        ),
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          ElevatedButton(onPressed: logOut, child: Text("خروج کارگاه 2"))

        ]));
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
    Navigator.of(context).maybePop();
  }


}
