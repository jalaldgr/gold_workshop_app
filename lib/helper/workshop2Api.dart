

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/userModel.dart';

class Workshop2Api {



/////////////////////////// workshop1 ////////////////////////


  static Future<String> updateWorkshop2(userData user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");

    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/workshop2/update-workshop2/${user.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: user.toJson()
    );
    return response.body;
  }
  static Future<List<orderData>> getPendingOrdersByWorkshop2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    dynamic userID =jsonDecode(prefs.getString('user')!)['id'];
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/workshop2/get-all-pending-orders/$userID/در کارگاه 2/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      List jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();
    }
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();


  }


  static Future<String> completeOrderWorkshop2(orderData order) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");

    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/workshop2/complete-order/${order.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: order.toJson()
    );
    return response.body;
  }

  static Future<String> SendOrderFileWorkshop2(orderData order) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    var stringResponse="no response";
    var uri = Uri.parse('${dotenv.env['API_URL']}/workshop2/send-file/${order.id}/workshop2File/');
    var request2 = http.MultipartRequest('POST', uri)
      ..headers.addAll({'Authorization': 'Bearer $token'});

    if(order.workshop2File!="" && order.workshop2File!="null"){
      http.MultipartFile file = await http.MultipartFile.fromPath('workshop2File', "${order.workshop2File}");
      request2.files.add(file);
    }

    final response = await request2.send();
    await response.stream.transform(utf8.decoder).listen((value) {
      stringResponse = value;
    });
    print(stringResponse);
    return stringResponse;

  }

}