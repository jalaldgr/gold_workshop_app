
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:gold_workshop/sections/admin/orders/addNewOrder.dart';
import 'package:gold_workshop/sections/admin/orders/editOrder.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../helper/serverApi.dart';



class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {

  String _listState = "orders";
  String _searchKeyword = "keyword";


  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.pink,
          flexibleSpace: Container(),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            IconButton(onPressed: (){setState(() {_listState="orders";});},
              tooltip: "بروزرسانی",
              icon: Icon(Icons.refresh)),

          ],

          title: Container(
            height: 48,
            child:
            EasySearchBar(
              onSearch: (s) => _searchOrders(s),
              title:  Text('لیست سفارش ها   ${Jalali.now().formatFullDate()}',
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0)),
            ),

          ),

        ),
        drawer: SideMenuAdmin(),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body:SingleChildScrollView(child:
          Stack(
            children: [
              Center(
                child: FutureBuilder(
                  future:_listState=="orders"? AdminApi.getOrders():AdminApi.searchOrders(_searchKeyword),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<orderData>> snapshot) =>
                  snapshot.hasData && snapshot.data!.isNotEmpty
                      ?
                  Padding(padding: EdgeInsets.all(4),
                      child:
                      Column(
                        children: [

                          Container(
                            child:ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return _buildOrderItem(
                                    context,
                                    snapshot.data?[index],
                                    index);
                              }),
                          ),
                        ],
                      )
                  )
                      : snapshot.hasError
                      ? Center(
                    child: Text('Error: ${snapshot.error}'),
                  )
                      : snapshot.data != null
                      ? const Center(
                    child: Text("بدون سفارش..."),
                  )
                      : CircularProgressIndicator(),
                ),
              )
            ],),),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          tooltip: "سفارش جدید",
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewOrderForm(order: orderData.fromJson({
                      "clientFullName":"",
                      "plateName":"",
                      "description":"",
                      "image":"",
                      "code":"",
                      "weight":"",
                      "status":"",
                      "workshop1fullName":"",
                      "workshop1Id":"",
                      "workshop1File":"",
                      "workshop2fullName":"",
                      "workshop2Id":"",
                      "workshop2File":"",
                      "designerFullName":"",
                      "designerId":"",
                      "designerFile":"",
                      "createdDate":"",
                      "id":"",
                      "instantDelivery":"",
                      "customerDelivery":"",
                      "paperDelivery":"",
                      "feeOrder":"",
                      "orderMeta":"",
                      "woocommerceOrderId":"",
                      "clientMobile":"",
                      "clientType":"",
                      "productType":""

                    }),)));
          } ,
        )
    );
  }



  _searchOrders(s)async{
    print("trig search");
    if(s.toString().length>3){
      setState(() {
        _listState="search";
        _searchKeyword = s;
      });
    }

  }

  Widget _buildOrderItem(BuildContext context,
       orderData? order,int? index) {
    return InkWell(onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditOrderScreen(order: order!,)));
    },child: Padding(padding: EdgeInsets.all(4),
      child:
      Container( color: (index! % 2 == 0) ? Colors.brown.shade100 : Colors.lightBlue.shade100,height: 128,
        child:
        Card(color: order?.status=="در انتظار بررسی"?Colors.lightGreenAccent.shade100:
        order?.status=="تکمیل نهایی"?Colors.lightGreen:
        order?.status=="ارسال به طراح"?Colors.lightBlueAccent.shade100:
        order?.status=="ارسال به کارگاه"?Colors.amberAccent.shade100:
        order?.status=="برگشت از طراح"?Colors.lightBlue:
        order?.status=="برگشت از کارگاه"?Colors.amber  :
        Colors.redAccent.shade100,
          child: Container(padding: EdgeInsets.all(8),
            child:Row(children: [
              Expanded(child:
              Row(children: [
                Flexible(flex: 9,child:
                    Column(children: [
                      Expanded(child:
                      Row(
                          children: <Widget>[
                            Text("${index+1}"),
                            SizedBox(width: 32,),
                            Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("نام مشتری",style: TextStyle(fontSize: 11),),Text("${order!.clientFullName}")],)),
                            Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("نوع محصول",style: TextStyle(fontSize: 11),),Text("${order!.productType}")],)),
                            Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("تاریخ سفارش",style: TextStyle(fontSize: 11),),Text("${order!.orderDate}")],)),
                            Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("تاریخ تحویل",style: TextStyle(fontSize: 11),),Text("${order!.deliveryDate}")],)),
                          ]
                      )),
                      SizedBox(height: 12,),
                      Expanded(child:
                      Row(
                          children: <Widget>[
                            SizedBox(width: 40,),
                            Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("سفارش گیرنده",style: TextStyle(fontSize: 11),),Text("سفارش گیرنده")],)),
                            Expanded(child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text("وضعیت سفارش",style: TextStyle(fontSize: 11),),Text("${order!.status}")],)),
                            Expanded(child:Row(children: [Text("${order.instantDelivery=="true" ? "✓ تحویل فوری":""}"),],)),
                            Expanded(child:Row(children: [Text("${order.paperDelivery=="true" ? "✓ کاغذی":""}"),],)),
                            Expanded(child:Row(children: [Text("${order.feeOrder=="true" ? "✓ بیعانه":""}"),],)),
                            Expanded(child:Row(children: [Text("${order.customerDelivery=="true" ? "✓ تحویل مشتری":""}"),],)),
                          ],
                      )),
                    ],)


                ),
                Flexible(flex: 3,child:Row(children: [
                  Expanded(child:InkWell(
                      child: Image.network("${dotenv.env['API_URL']}/public/uploads/${order!.image}"),
                      onTap: (){
                        launchUrl(Uri.parse("${dotenv.env['API_URL']}/public/uploads/${order.image}"));
                      })),
                  Expanded(child:
                  OutlinedButton(onPressed: () {
                    launchUrl(Uri.parse("${dotenv.env['API_URL']}/public/uploads/${order.designerFile}"));

                  }, child: Text("فایل طراح"),) ),
                  SizedBox(width: 64,
                    child:Row(children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        tooltip: "حذف",
                        onPressed: () async {

                          if(order.id != null){
                            deleteOrderAlertDialog(context ,order);

                          }
                        },
                      ),
                    ],),),
                ],) )

              ],))
            ],),

          ),
        ),
      )
      ,),);
  }

  deleteOrderAlertDialog(BuildContext context, orderData order) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("انصراف",style: TextStyle(color: Colors.red),),
      onPressed:  () {Navigator.of(context).pop();},
    );
    Widget continueButton = TextButton(
      child: Text("تایید",style: TextStyle(color: Colors.blue,fontSize: 20)),
      onPressed:  () async {
        String response = await AdminApi.deleteOrder(order?.id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response}")));
        setState(()  {
          Navigator.of(context).pop();
        });

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("حذف سفارش"),
      content: Text("آیا از حذف سفارش ${order.clientFullName} اطمینان دارید؟"),
      actions: [
        Column(children: [
          Row(children: [
            Expanded(child: cancelButton ),
            Expanded(child: continueButton )
          ],)
        ],)

      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
