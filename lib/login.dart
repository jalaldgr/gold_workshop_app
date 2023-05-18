import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'home.dart';


class LoginPage extends StatefulWidget {
  @override
  LoginScreen createState() => LoginScreen();
}

class LoginScreen extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _is_loged_in = false;
  String dropdownValue = 'مدیر';
  String userRole="admin";

  Future<String> signIn(String username, String password) async {
    String url = "${dotenv.env['API_URL']}/${userRole}/login";
    Map<String, String> body = {"username": username, "password": password};

    http.Response res =
        await http.post(Uri.parse(url), body: body);
    if (res.statusCode == 200 && (res.body.contains("token"))) {
      _is_loged_in=true;
      String token =
          jsonDecode(res.body)['token']; // get token from login response
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('jwt', token);
      prefs.setString('user', res.body);
      return token;
    }
    return res.body;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            DropdownButton<String>(
              // Step 3.
              value: dropdownValue,
              // Step 4.
              items: <String>['مدیر', 'طراح', 'کارگاه 1', 'کارگاه 2']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 30),
                  ),
                );
              }).toList(),
              // Step 5.
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  switch(newValue){

                    case "مدیر":
                      userRole ="admin";
                      break;
                    case "طراح":
                      userRole = "designer";
                      break;
                    case "کارگاه 1":
                      userRole = "workshop1";
                      break;
                    case "کارگاه 2":
                      userRole = "workshop2";
                      break;

                  }
                  print(newValue);
                });
              },
            ),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: "نام کاربری"),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "رمز عبور"),
                obscureText: true,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    String loginResult = await signIn(
                        usernameController.text, passwordController.text);
                    if (_is_loged_in) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomeScreen.fromBase64(loginResult)),
                          (Route<dynamic> route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("${loginResult}"),
                      ));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${e}"),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "ورود",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
