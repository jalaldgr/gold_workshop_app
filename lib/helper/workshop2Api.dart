

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


}