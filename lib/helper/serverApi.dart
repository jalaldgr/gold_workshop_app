

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

    print(user.toJson());
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

}