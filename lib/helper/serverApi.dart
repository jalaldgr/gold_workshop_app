

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../models/userModel.dart';

class AdminApi {


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

    static Future<String> updateDesigner(userData user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");

    print(user.toJson());
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

}