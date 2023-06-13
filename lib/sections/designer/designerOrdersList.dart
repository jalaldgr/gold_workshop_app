
import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/designerApi.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';
import 'showDesignerOrder.dart';



class DesignerOrdersList extends StatefulWidget {
  const DesignerOrdersList({Key? key}) : super(key: key);

  @override
  _DesignerOrdersListState createState() => _DesignerOrdersListState();
}

class _DesignerOrdersListState extends State<DesignerOrdersList> {
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
          backgroundColor: Colors.lightGreen,
          actions: <Widget>[IconButton(onPressed: (){setState(() {});}, icon: Icon(Icons.refresh))],
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('لیست سفارش ها',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0)),
        ),
        drawer: SideMenuAdmin(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: FutureBuilder(
                  future: DesignerApi.getOrders(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<orderData>> snapshot) =>
                  snapshot.hasData && snapshot.data!.isNotEmpty
                      ? Column(
                    children: [

                      ListTile(
                        onTap: null,
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                        ),
                        title:
                        Row(mainAxisAlignment: MainAxisAlignment.start,
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
                      ),

                      Container(
                        height: MediaQuery.of(context).size.height * 0.87,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(1.0)),
                        ),
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return _buildPaymentItem(
                                  context,
                                  snapshot.data?[index].clientFullName,
                                  snapshot.data?[index].status,
                                  snapshot.data?[index],
                                  index);
                            }),
                      )
                    ],
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
            ],
          ),
        )

    );
  }




  Widget _buildPaymentItem(BuildContext context,
      String? clientFullname,String? status , orderData? order,int? index) {
    return Padding(padding: EdgeInsets.all(4),
      child:
      Container( color: (index! % 2 == 0) ? Colors.brown.shade50 : Colors.lightBlue.shade50,height: 100,
        child:
        Card(
          child: Row(
              children: <Widget>[
                Expanded(child: Text("${index}")),
                Expanded(child: Text("${order?.clientFullName}")),
                Expanded(child: Text("${order?.productType}")),
                Expanded(child: Text("${order?.deliveryDate}")),
                Expanded(child: Text("${order?.status}")),
                SizedBox(width: 100,
                  child:Row(children: [
                    IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowDesignerOrderScreen(order: order!,)));
                      },
                    ),
                  ],),)
              ]
          ),
        ),
      )

      ,);
  }
}
