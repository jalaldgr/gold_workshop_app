

import 'dart:convert';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/userModel.dart';

class AdminApi {

/////////////////////////// designer api///////////////////////
    static Future<List<userData>> getDesigners() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/admin/get-all-designer'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      List jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map((myMap) => userData.fromJson(myMap)).toList();
    }
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((myMap) => userData.fromJson(myMap)).toList();


  }

    static Future getDesignersJson() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic token = prefs.getString("jwt");
      final response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/admin/get-all-designer'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return response.body;
      }
    }

    static Future getWorkshop1sJson() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic token = prefs.getString("jwt");
      final response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/admin/get-all-workshop1'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        return response.body;
      }

    }

    static Future<String> updateDesigner(userData user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");

    final response = await http.post(
      Uri.parse('${dotenv.env['API_URL']}/admin/update-designer/${user.id}'),
      headers: {'Authorization': 'Bearer $token'},
      body: user.toJson()
    );
    return response.body;
  }

    static Future<String> deleteDesigner(String id) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic token = prefs.getString("jwt");
      final response = await http.delete(
          Uri.parse('${dotenv.env['API_URL']}/admin/delete-designer/${id}'),
          headers: {'Authorization': 'Bearer $token'},
      );
      return response.body;
    }

    static Future<String> addDesigner(userData user) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic token = prefs.getString("jwt");
      final response = await http.post(
          Uri.parse('${dotenv.env['API_URL']}/admin/register-designer'),
          headers: {'Authorization': 'Bearer $token'},
          body: user.toJson()
      );
      return response.body;
    }


/////////////////////////// workshop1 ////////////////////////
  static Future<List<userData>> getWorkshop1s() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/admin/get-all-workshop1'),
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
        Uri.parse('${dotenv.env['API_URL']}/admin/update-workshop1/${user.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: user.toJson()
    );
    return response.body;
  }

  static Future<String> deleteWorkshop1(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.delete(
      Uri.parse('${dotenv.env['API_URL']}/admin/delete-workshop1/${id}'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.body;
  }

  static Future<String> addWorkshop1(userData user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/admin/register-workshop1'),
        headers: {'Authorization': 'Bearer $token'},
        body: user.toJson()
    );
    return response.body;
  }


  /////////////////////////// workshop2 ////////////////////////
  static Future<List<userData>> getWorkshop2s() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/admin/get-all-workshop2'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode != 200) {
      List jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map((myMap) => userData.fromJson(myMap)).toList();
    }
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((myMap) => userData.fromJson(myMap)).toList();


  }

  static Future getWorkshop2sJson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/admin/get-all-workshop2'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return response.body;
    }

  }

  static Future<String> updateWorkshop2(userData user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");

    print(user.toJson());
    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/admin/update-workshop2/${user.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: user.toJson()
    );
    return response.body;
  }

  static Future<String> deleteWorkshop2(String id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.delete(
      Uri.parse('${dotenv.env['API_URL']}/admin/delete-workshop2/${id}'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.body;
  }

  static Future<String> addWorkshop2(userData user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/admin/register-workshop2'),
        headers: {'Authorization': 'Bearer $token'},
        body: user.toJson()
    );
    return response.body;
  }



  /////////////////////////// Orders ////////////////////////
  static Future<List<orderData>> getOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/admin/get-all-order'),
      headers: {'Authorization': 'Bearer $token'},
    );

    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();


  }

  static Future<String> updateOrder(orderData order) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    var stringResponse="no response";
    var uri = Uri.parse('${dotenv.env['API_URL']}/admin/update-order/${order.id}');
    var request2 = http.MultipartRequest('POST', uri)
      ..headers.addAll({'Authorization': 'Bearer $token'});

    if(order.image!="" && order.image!="null"){
      http.MultipartFile file = await http.MultipartFile.fromPath('image', "${order.image}");
      request2.files.add(file);
    }
    order.toJson().forEach((key, value) {
      request2.fields[key] = value;
    });
    final response = await request2.send();
    response.stream.transform(utf8.decoder).listen((value) {
      stringResponse = value;
    });
    return stringResponse;
  }



  static Future<String> addOrder(orderData order) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    var stringResponse="no response";
    var uri = Uri.parse('${dotenv.env['API_URL']}/admin/create-order');
    var request2 = http.MultipartRequest('POST', uri)
      ..headers.addAll({'Authorization': 'Bearer $token'});

    if(order.image!="" && order.image!="null"){
      http.MultipartFile file = await http.MultipartFile.fromPath('image', "${order.image}");
      request2.files.add(file);
    }
    order.toJson().forEach((key, value) {
      request2.fields[key] = value;
    });
    final response = await request2.send();
    await response.stream.transform(utf8.decoder).listen((value) {
      stringResponse = value;
    });
    return stringResponse;
  }

  static Future<String> deleteOrder(String? id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.delete(
      Uri.parse('${dotenv.env['API_URL']}/admin/delete-order/${id}'),
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.body;
  }


  /////////////////////////// Orders ////////////////////////

  static Future<String> updateAdmin(userData user) async{
      String result="بدون نتیجه";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");

    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/admin/update/${user.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: user.toJson()
    );
    if(response.statusCode==200){
      prefs.setString('user', response.body);
      result = "پروفایل با موفقیت ذخیره شد";
    }
    return result;
  }



  /////////////////////////// Orders ////////////////////////
  static Future<tableData> getTable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/admin/get-table/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    tableData table = tableData.fromJson(json.decode(response.body));
    return  table;
  }



}