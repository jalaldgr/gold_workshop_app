import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/orderModel.dart';
import '../models/userModel.dart';

class DesignerApi {



/////////////////////////// workshop1 ////////////////////////


  static Future<String> updateDesigner(userData user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");

    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/designer/update-designer/${user.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: user.toJson()
    );
    return response.body;
  }


  static Future<List<orderData>> getPendingOrdersByDesigner() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    dynamic userID =jsonDecode(prefs.getString('user')!)['id'];
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/designer/get-all-pending-orders/$userID/ارسال به طراح/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      List jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();
    }
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();


  }


  static Future<String> completeOrderDesigner(orderData order) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");

    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/designer/complete-order/${order.id}/برگشت از طراح'),
        headers: {'Authorization': 'Bearer $token'},
        body: order.toJson()
    );
    return response.body;
  }

  static Future<String> SendOrderFileDesigner(orderData order) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    var stringResponse="default response";
    var uri = Uri.parse('${dotenv.env['API_URL']}/designer/send-file/${order.id}/designerFile/');
    var request2 = http.MultipartRequest('POST', uri)
      ..headers.addAll({'Authorization': 'Bearer $token'});

    if(order.designerFile!="" && order.designerFile!="null"){
      http.MultipartFile file = await http.MultipartFile.fromPath('designerFile', "${order.designerFile}");
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
      Uri.parse('${dotenv.env['API_URL']}/designer/get-all-order'),
      headers: {'Authorization': 'Bearer $token'},
    );

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();


  }

}

