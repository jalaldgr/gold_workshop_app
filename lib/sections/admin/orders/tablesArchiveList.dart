
import 'package:flutter/material.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'package:gold_workshop/sections/admin/orders/addNewOrder.dart';
import 'package:gold_workshop/sections/admin/orders/editOrder.dart';
import '../../../helper/serverApi.dart';
import 'showOrder.dart';



class TableArchiveListScreen extends StatefulWidget {
  const TableArchiveListScreen({Key? key}) : super(key: key);

  @override
  _TableArchiveListScreenState createState() => _TableArchiveListScreenState();
}

class _TableArchiveListScreenState extends State<TableArchiveListScreen> {
  TextEditingController fullNameController=TextEditingController();
  TextEditingController userNameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();


  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.pink,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[IconButton(onPressed: (){setState(() {});}, icon: Icon(Icons.refresh))],
          title: const Text('آرشیو جدول ها',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0)),
        ),
        drawer: SideMenuAdmin(),
        backgroundColor: Colors.white,
        body:SingleChildScrollView(child:
          Stack(
            children: [
              Center(
                child: FutureBuilder(
                  future: AdminApi.getOrders(),
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
                                return _buildPaymentItem(
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
                    child: Text("بدون جدول..."),
                  )
                      : CircularProgressIndicator(),
                ),
              )
            ],),)

        ,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
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




  Widget _buildPaymentItem(BuildContext context,
       orderData? order,int? index) {
    return Padding(padding: EdgeInsets.all(4),
      child:
      Container( color: (index! % 2 == 0) ? Colors.brown.shade50 : Colors.lightBlue.shade50,height: 100,
        child:
        Card(color: Colors.blue.shade100,
          child:
          Container(padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Text("ذوب روزانه",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                      Expanded(child: Text("کسر پرداخت",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                      Expanded(child: Text("کسر ذوب",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                      Expanded(child: Text("کسر برش",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                      Expanded(child: Text("اختلاف برش",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                      Expanded(child: Text("مجموع",style: TextStyle(fontWeight: FontWeight.w100),textAlign: TextAlign.center)),
                    ],
                  )
                  ,)
                ,
                SizedBox(height: 4,),
                Container(decoration: BoxDecoration(color: Colors.blue.shade100
                ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text("20",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center)),
                      Expanded(
                          child: Text("20",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center)),
                      Expanded(
                          child: Text("20",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center)),
                      Expanded(
                          child: Text("20",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center)),
                      Expanded(
                          child: Text("20",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center)),
                      Expanded(
                          child: Text(
                            "20",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      )

      ,);
  }
}



