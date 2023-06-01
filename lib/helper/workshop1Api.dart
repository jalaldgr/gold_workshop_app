

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/userModel.dart';

class Workshop1Api {



/////////////////////////// workshop1 ////////////////////////
  static Future<List<userData>> getWorkshop1s() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/workshop1/get-workshop1'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      List jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map((myMap) => userData.fromJson(myMap)).toList();
    }
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((myMap) => userData.fromJson(myMap)).toList();


  }

  static Future<String> updateWorkshop1(userData user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");

    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/workshop1/update-workshop1/${user.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: user.toJson()
    );
    return response.body;
  }

  static Future<List<orderData>> getPendingOrdersByWorkshop1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    dynamic userID =jsonDecode(prefs.getString('user')!)['id'];
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/workshop1/get-all-pending-orders/$userID'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      List jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();
    }
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();


  }

}