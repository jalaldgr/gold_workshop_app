

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
      Uri.parse('${dotenv.env['API_URL']}/workshop1/get-all-pending-orders/$userID/در کارگاه/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      List jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();
    }
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();


  }

  static Future<String> sendFileWorkshop1(orderData order) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");

    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/workshop1/send-file/${order.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: order.toJson()
    );
    return response.body;
  }

  static Future<String> completeOrderWorkshop1(orderData order) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");

    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/workshop1/complete-order/${order.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: order.toJson()
    );
    return response.body;
  }

  static Future<String> SendOrderFileWorkshop1(orderData order) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    var stringResponse="default response";
    var uri = Uri.parse('${dotenv.env['API_URL']}/workshop1/send-file/${order.id}/workshop1File/');
    var request2 = http.MultipartRequest('POST', uri)
      ..headers.addAll({'Authorization': 'Bearer $token'});

    if(order.workshop1File!="" && order.workshop1File!="null"){
      http.MultipartFile file = await http.MultipartFile.fromPath('workshop1File', "${order.workshop1File}");
      request2.files.add(file);
    }

    final response = await request2.send();
    await response.stream.transform(utf8.decoder).listen((value) {
      stringResponse = value;
    });
    print(stringResponse);
    return stringResponse;

  }

  static Future<List<orderData>> getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/workshop1/get-all-order'),
      headers: {'Authorization': 'Bearer $token'},
    );

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();


  }


}