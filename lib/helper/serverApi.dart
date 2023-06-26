

import 'dart:convert';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';
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
    String stringResponse="";

    try{
    final WPResponse = await http.get(
      Uri.parse('https://minitala.com/wp-json/wp/v2/sefareshat'),
    );
    List WPJsonResponse = json.decode(WPResponse.body);
    final notCompletedResponse = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/admin/get-not-completed-orders'),
      headers: {'Authorization': 'Bearer $token'},
    );
    List notCompletedJsonResponse = json.decode(notCompletedResponse.body);

    WPJsonResponse.forEach((WPElement) async {
      var title = json.encode(WPElement["title"]);
      bool orderExist = false;
      notCompletedJsonResponse.forEach((notElement) {
        if(WPElement["id"].toString()==notElement["woocommerceOrderId"])orderExist = true;
        // print("notElement is ${notElement}");

      });
      ////////////add wc order to server orders/////////////////
      if(!orderExist) {
        var uri = Uri.parse('${dotenv.env['API_URL']}/admin/create-order');
        var request2 = http.MultipartRequest('POST', uri)
          ..headers.addAll({'Authorization': 'Bearer $token'});


        if (WPElement["meta"]["sefareshDahandeName"][0] != null)
          request2.fields["clientFullName"] =
              WPElement["meta"]["sefareshDahandeName"][0].toString();
        if (WPElement["id"] != null)
          request2.fields["woocommerceOrderId"] = WPElement["id"].toString();
        if (WPElement["date"] != null) request2.fields["orderDate"] =
            Jalali.fromDateTime(DateTime.parse(WPElement["date"]))
                .formatFullDate()
                .toString();
        if (WPElement["meta"]["tozihat"] != null)
          request2.fields["description"] =
              WPElement["meta"]["tozihat"][0].toString();
        if (WPElement["meta"]["codemahsool"] != null) request2.fields["code"] =
            WPElement["meta"]["codemahsool"][0].toString();
        if (WPElement["meta"]["vaznemahsool"] != null)
          request2.fields["weight"] =
              WPElement["meta"]["vaznemahsool"][0].toString();
        if (WPElement["meta"]["noemahsool"] != null)
          request2.fields["productType"] =
              WPElement["meta"]["noemahsool"][0].toString();
        if (WPElement["meta"]["moshtarihamkar"] != null)
          request2.fields["clientType"] =
              WPElement["meta"]["moshtarihamkar"][0].toString();
        if (WPElement["meta"]["tarikhtahvil"] != null)
          request2.fields["deliveryDate"] =
          WPElement["meta"]["tarikhtahvil"][0];
        if (WPElement["meta"]["shomaretamas"] != null)
          request2.fields["clientMobile"] =
              WPElement["meta"]["shomaretamas"][0].toString();
        if (WPElement["meta"]["noetahvil"] != null)
          request2.fields["instantDelivery"] = "true";
        if (WPElement["meta"]["tahvilmoshtari"] != null)
          request2.fields["customerDelivery"] = "true";
        if (WPElement["meta"]["kaghazi"] != null)
          request2.fields["paperDelivery"] = "true";
        if (WPElement["meta"]["beyane"] != null)
          request2.fields["feeOrder"] = "true";
        request2.fields["orderType"] = "سایت";
        request2.fields["status"] = "در انتظار بررسی";
        if (WPElement["meta"]["vaznemahsool"] != null)
          request2.fields["weight"] =
              WPElement["meta"]["vaznemahsool"][0].toString();
        if (WPElement["meta"]["codemahsool"] != null) request2.fields["code"] =
            WPElement["meta"]["codemahsool"][0].toString();

        Map<String, String> _metaKeyValue = {}; // order meta key value
        //collect order meta for every type of product
        if (WPElement["meta"]["namepelak"] != null) _metaKeyValue["نام پلاک"] =
            WPElement["meta"]["namepelak"][0].toString();
        if (WPElement["meta"]["halatpelak"] != null)
          _metaKeyValue["حالت پلاک"] =
              WPElement["meta"]["halatpelak"][0].toString();
        if (WPElement["meta"]["abadmahsool"] != null)
          _metaKeyValue["ابعاد محصول"] =
              WPElement["meta"]["abadmahsool"][0].toString();
        if (WPElement["meta"]["noepelak"] != null) _metaKeyValue["نوع پلاک"] =
            WPElement["meta"]["noepelak"][0].toString();
        if (WPElement["meta"]["noehak"] != null)
          _metaKeyValue["نوع حک"] = WPElement["meta"]["noehak"][0].toString();
        if (WPElement["meta"]["bakhshbandi"] != null)
          _metaKeyValue["بخش بندی"] =
              WPElement["meta"]["bakhshbandi"][0].toString();

        if (WPElement["meta"]["noesangangoshtar"] != null)
          _metaKeyValue["نوع سنگ"] =
              WPElement["meta"]["noesangangoshtar"][0].toString();
        if (WPElement["meta"]["vaznemahsoolangoshtar"] != null)
          request2.fields["weight"] =
              WPElement["meta"]["vaznemahsoolangoshtar"][0].toString();
        if (WPElement["meta"]["sizedasteangoshtar"] != null)
          _metaKeyValue["سایز دسته"] =
              WPElement["meta"]["sizedasteangoshtar"][0].toString();
        if (WPElement["meta"]["noedasteangoshtar"] != null)
          _metaKeyValue["نوع دسته"] =
              WPElement["meta"]["noedasteangoshtar"][0].toString();

        if (WPElement["meta"]["bakhshbandinamdastband"] != null)
          _metaKeyValue["بخش بندی"] =
              WPElement["meta"]["bakhshbandinamdastband"][0].toString();
        if (WPElement["meta"]["vaznemahsooldastband"] != null)
          request2.fields["weight"] =
              WPElement["meta"]["vaznemahsooldastband"][0].toString();
        if (WPElement["meta"]["abadmahsooldastband"] != null)
          _metaKeyValue["ابعاد محصول"] =
              WPElement["meta"]["abadmahsooldastband"][0].toString();
        if (WPElement["meta"]["noedastband"] != null)
          _metaKeyValue["نوع دستبند"] =
              WPElement["meta"]["noedastband"][0].toString();
        if (WPElement["meta"]["noecharmdastband"] != null)
          _metaKeyValue["نوع چرم"] =
              WPElement["meta"]["noecharmdastband"][0].toString();

        if (WPElement["meta"]["codemahsoolgoshvare"] != null)
          request2.fields["code"] =
              WPElement["meta"]["codemahsoolgoshvare"][0].toString();
        if (WPElement["meta"]["vaznemahsoolgoshvare"] != null)
          request2.fields["weight"] =
              WPElement["meta"]["vaznemahsoolgoshvare"][0].toString();
        if (WPElement["meta"]["abadmahsoolgoshvare"] != null)
          _metaKeyValue["ابعاد محصول"] =
              WPElement["meta"]["abadmahsoolgoshvare"][0].toString();
        if (WPElement["meta"]["noegoshvare"] != null)
          _metaKeyValue["نوع گوشواره"] =
              WPElement["meta"]["noegoshvare"][0].toString();
        if (WPElement["meta"]["noehakgoshvare"] != null)
          _metaKeyValue["نوع حک"] =
              WPElement["meta"]["noehakgoshvare"][0].toString();

        if (WPElement["meta"]["codemahsooldoresang"] != null)
          request2.fields["code"] =
              WPElement["meta"]["codemahsooldoresang"][0].toString();
        if (WPElement["meta"]["vaznemahsooldoresang"] != null)
          request2.fields["weight"] =
              WPElement["meta"]["vaznemahsooldoresang"][0].toString();
        if (WPElement["meta"]["abadmahsooldoresang"] != null)
          _metaKeyValue["ابعاد محصول"] =
              WPElement["meta"]["abadmahsooldoresang"][0].toString();
        if (WPElement["meta"]["noedoresang"] != null) _metaKeyValue["نوع سنگ"] =
            WPElement["meta"]["noedoresang"][0].toString();
        if (WPElement["meta"]["noehakgoshvare"] != null)
          _metaKeyValue["نوع حک"] =
              WPElement["meta"]["noehakgoshvare"][0].toString();

        request2.fields["orderMeta"] =
            jsonEncode(_metaKeyValue); // save all product metas

        if (WPElement["_links"]["author"] != null) {
          var url = WPElement["_links"]["author"][0]["href"];
          final response = await http.get(Uri.parse(url));
          var name = json.decode(response.body);
          request2.fields["orderRecipient"] = name["name"];
        }

        if (WPElement["_links"]["wp:featuredmedia"] != null) {
          var url = WPElement["_links"]["wp:featuredmedia"][0]["href"];
          final response = await http.get(Uri.parse(url));
          var image = json.decode(response.body)["guid"]["rendered"];
          http.MultipartFile file = await http.MultipartFile.fromString(
              'image', image);
          request2.files.add(file);
        }



        final response = await request2.send();
        await response.stream.transform(utf8.decoder).listen((value) {
          stringResponse = value;
        });
      }
    });
    }catch(e){print(e);}


    //////////get server orders//////////////
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
    var stringResponse="default response";
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
    var stringResponse="default response";
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


  static Future<tableData> postTable(tableData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.post(
      Uri.parse('${dotenv.env['API_URL']}/admin/post-table/'),
      headers: {'Authorization': 'Bearer $token'},
      body: data.toJson()
    );
    tableData table = tableData.fromJson(json.decode(response.body));
    return  table;
  }

  static Future<List<tableData>> getTables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/admin/get-tables/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((myMap) => tableData.fromJson(myMap)).toList();

  }




  /////////////////////////// Orders ////////////////////////
  static Future<List<orderData>> searchOrders(s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/admin/search/${s}'),
      headers: {'Authorization': 'Bearer $token'},
    );

    List jsonResponse = json.decode(response.body);
    if(jsonResponse.length>0)
      return jsonResponse.map((myMap) => orderData.fromJson(myMap)).toList();
    else
      return jsonResponse.map((myMap) => orderData.fromJson({})).toList();



  }


  static Future<tableData> getTableById(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/admin/get-table-by-id/${id}'),
      headers: {'Authorization': 'Bearer $token'},
    );
    tableData table = tableData.fromJson(json.decode(response.body));
    return  table;
  }


  static Future<tableData> postTableById(tableData data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.post(
        Uri.parse('${dotenv.env['API_URL']}/admin/post-table-by-id/${data.id}'),
        headers: {'Authorization': 'Bearer $token'},
        body: data.toJson()
    );
    tableData table = tableData.fromJson(json.decode(response.body));
    return  table;
  }



  /////////////////////////// Search Orders ////////////////////////
  static Future<List<tableData>> searchTables(s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString("jwt");
    final response = await http.get(
      Uri.parse('${dotenv.env['API_URL']}/admin/search-table/${s}'),
      headers: {'Authorization': 'Bearer $token'},
    );
    List jsonResponse = json.decode(response.body);
    print(response.body);
    if(jsonResponse.length>0)
      return jsonResponse.map((myMap) => tableData.fromJson(myMap)).toList();
    else
      return jsonResponse.map((myMap) => tableData.fromJson({})).toList();

  }



}