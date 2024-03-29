import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gold_workshop/sections/workshop1/workshop1Home.dart';
import 'package:gold_workshop/sections/workshop2/workshop2Home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'sections/admin/adminHome.dart';
import 'sections/designer/designerHome.dart';


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
  bool _isObscure = true;
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

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Row(children: [
                Expanded(child: DropdownButton<String>(
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
                    });
                  },
                ),)
              ]
              ),
            ),
            SizedBox(height: 16,),
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
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "رمز عبور",
                    suffixIcon: IconButton(
                        icon: Icon(
                            _isObscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                ),
                obscureText: _isObscure,

              ),
            ),
            SizedBox(height: 32,),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    String loginResult = await signIn(
                        usernameController.text, passwordController.text);
                    if (_is_loged_in) {

                      switch(userRole){

                        case "admin":
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AdminHomeScreen.fromBase64(loginResult)),
                                  (Route<dynamic> route) => false);
                          break;
                        case "designer":
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DesignerHomeScreen.fromBase64(loginResult)),
                                  (Route<dynamic> route) => false);
                          break;
                        case "workshop1":
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Workshop1HomeScreen.fromBase64(loginResult)),
                                  (Route<dynamic> route) => false);
                          break;
                        case "workshop2":
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Workshop2HomeScreen.fromBase64(loginResult)),
                                  (Route<dynamic> route) => false);
                          break;

                      }

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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Container(
                  alignment: Alignment.center,
                  height: 64,
                  width: size.width ,
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
