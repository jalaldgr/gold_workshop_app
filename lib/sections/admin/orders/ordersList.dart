
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:gold_workshop/sections/admin/orders/addNewOrder.dart';
import 'package:gold_workshop/sections/admin/orders/editOrder.dart';
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
              title: const Text('لیست سفارش ها',
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
                          Card(
                            child: Container(padding: EdgeInsets.all(8),
                              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 8,),
                                    Expanded(child: Text("ردیف" ,style: TextStyle(fontStyle: FontStyle.italic),)),
                                    Expanded(child: Text("نام مشتری",style: TextStyle(fontStyle: FontStyle.italic))),
                                    Expanded(child: Text("نوع محصول",style: TextStyle(fontStyle: FontStyle.italic))),
                                    Expanded(child: Text("تاریخ تحویل",style: TextStyle(fontStyle: FontStyle.italic))),
                                    Expanded(child: Text("وضعیت",style: TextStyle(fontStyle: FontStyle.italic))),
                                    SizedBox(width: 100,)
                                  ]
                              ),
                            ),),
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
      Container( color: (index! % 2 == 0) ? Colors.brown.shade100 : Colors.lightBlue.shade100,height: 100,
        child:
        Card(color: order?.status=="در انتظار بررسی"?Colors.lightGreenAccent.shade100:
        order?.status=="تکمیل نهایی"?Colors.lightGreen:
        order?.status=="ارسال به طراح"?Colors.lightBlueAccent.shade100:
        order?.status=="ارسال به کارگاه"?Colors.amberAccent.shade100:
        order?.status=="برگشت از طراح"?Colors.lightBlue:
        order?.status=="برگشت از کارگاه"?Colors.amber  :
        Colors.redAccent.shade100,
          child: Container(padding: EdgeInsets.all(8),
            child:Row(
                children: <Widget>[
                  Expanded(child: Text("${index}")),
                  Expanded(child: Text("${order?.clientFullName}")),
                  Expanded(child: Text("${order?.productType}")),
                  Expanded(child: Text("${order?.deliveryDate}")),
                  Expanded(child: Text("${order?.status}")),
                  SizedBox(width: 64,
                    child:Row(children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        tooltip: "حذف",
                        onPressed: () async {

                          if(order?.id != null){
                            String response = await AdminApi.deleteOrder(order?.id);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response}")));
                          }
                          setState(() {});
                        },
                      ),
                    ],),)
                ]
            ),
          ),
        ),
      )
      ,),);
  }
}
