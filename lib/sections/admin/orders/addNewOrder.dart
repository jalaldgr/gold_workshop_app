import 'package:flutter/material.dart';
import 'package:gold_workshop/sections/admin/orders/designerDropDown.dart';

import 'workshop1DropDown.dart';
import 'workshop2DropDown.dart';

// Define a custom Form widget.
class NewOrderForm extends StatefulWidget {
  const NewOrderForm({super.key});

  @override
  NewOrderFormState createState() {
    return NewOrderFormState();
  }
}

onChangeDesignerDropDown(value){
print("in here ${value}");
}

onChangeWorkshop1DropDown(value){
  print("in here ${value}");
}
onChangeWorkshop2DropDown(value){
  print("in here ${value}");
}



// Define a corresponding State class.
// This class holds data related to the form.
class NewOrderFormState extends State<NewOrderForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String customerTypeDropDownValue = 'مشتری';
  var customerTypeDropDownItems = [ 'مشتری','همکار' ];
  String statusDropDownValue = 'در انتظار بررسی';
  var statusDropDownItems = ['در انتظار بررسی','تکمیل نهایی' , 'در حال طراحی','در کارگاه 1','در کارگاه 2','تکمیل طراحی','تکمیل کارگاه 1','تکمیل کارگاه 2' ,'لغو شده'];
  String productTypeDropDownValue = 'پلاک اسم';
  var productTypeDropDownItems = ["پلاک اسم","انگشتر","النگو","دستبند","گوشواره","دوره سنگ","سرویس طلا","نیم ست طلا","آویز طلا","پا بند طلا",
    "پا بند طلا","رو لباسی طلا","جواهرات","ساعت طلا","دستبند چرمی طلا","دستبند مهره ای فانتزی طلا","تک پوش طلا","گردنبند","حلقه ست",
    "اکسسوری طلا","محصولات نفره","آویز ساعت و دستبند طلا","پیرسینگ طلا","زنجیر طلا","سنجاق سینه طلا","مد روز","کودک و نوزاد",
    "طلای مناسبتی","طوق و بنگل طلا","تمیمه","انگشتر مردانه","زنجیر مردانه","دستبند مردانه","انگشتر زنانه","هدایای اقتصادی","برند ها"];
  String orderMetaDropDownValue = 'وزن';
  var orderMetaDropDownItems = [ 'وزن','کد' ];
  TextEditingController orderMetaEditText=TextEditingController();
  bool instantDeliveryCheckBoxValue = false;
  bool deliveryByCustomerCheckBoxValue = false;
  bool feeCheckBoxValue = false;
  bool deliveryPaperCheckBoxValue = false;
  List<DataRow> tableItem=[];

  onSelectedRow( String row) async {
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.yellow,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('سفارش جدید',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0)),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white38),
          child:Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(16)
                ,child:
                  Row(children: [
                    Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "نام مشتری"),),),
                    Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "شماره تماس"),),),
                    Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "تاریخ تحویل"),),),
                    Expanded(child:
                    DropdownButton(
                      value: customerTypeDropDownValue,
                      items: customerTypeDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                      onChanged: (String? value) {setState(() {customerTypeDropDownValue = value!;});},
                    )),
                    Expanded(child:
                    DropdownButton(
                      value: statusDropDownValue,
                      items: statusDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                      onChanged: (String? value) {setState(() {statusDropDownValue = value!;});},)

                      ),
                  ],),
                ),
                SizedBox(height: 32,),
                Padding(padding: EdgeInsets.all(16),
                 child:Row(children: [
                   Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "توضیحات"))),
                   Expanded(child:
                   Row(children: [
                     Expanded(child:

                     Row(children: [
                       Text("تحویل فوری"),
                       Checkbox(
                           value: instantDeliveryCheckBoxValue,
                           onChanged: (value) {setState(() {instantDeliveryCheckBoxValue = value!;
                             // widget.trip?.roundTrip = value;
                           });})
                     ],)
                     ),
                     Expanded(
                         child:
                         Row(children: [
                           Text("کاغذی"),
                           Checkbox(
                               value: deliveryPaperCheckBoxValue,
                               onChanged: (value) {setState(() {deliveryPaperCheckBoxValue = value!;
                                 // widget.trip?.roundTrip = value;
                               });})
                         ],)
                     ),
                     Expanded(child:
                     Row(children: [
                       Text("بعیانه"),
                       Checkbox(
                           value: feeCheckBoxValue,
                           onChanged: (value) {setState(() {feeCheckBoxValue = value!;
                             // widget.trip?.roundTrip = value;
                           });})
                     ],)
                     ),
                     Expanded(child:
                     Row(children: [
                       Text("تحویل مشتری"),
                       Checkbox(
                           value: deliveryByCustomerCheckBoxValue,
                           onChanged: (value) {setState(() {deliveryByCustomerCheckBoxValue = value!;
                             // widget.trip?.roundTrip = value;
                           });})
                     ],)
                     ),],)
                   )

                 ],)

                  ,),
                SizedBox(height: 32,),
                Padding(padding: EdgeInsets.all(16),
                  child:
                  Row(children: [
                    Expanded(child:Text("فایل عکس"),),
                    Expanded(child:Text("فایل طراح"),),
                    Expanded(child:
                        Column(children: [
                          Row(
                            children: [
                              Expanded(child:DropdownButton(
                                value: orderMetaDropDownValue,
                                items: orderMetaDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                                onChanged: (String? value) {setState(() {orderMetaDropDownValue = value!;orderMetaEditText.text='';});},
                              )),
                              Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: ""),controller: orderMetaEditText,)),
                              Expanded(child:IconButton( onPressed: (){
                                  setState(() {
                                    tableItem.add(DataRow(cells: [DataCell(Text("${orderMetaDropDownValue}")),DataCell(Text("${orderMetaEditText.text}"))]
                                        // ,onSelectChanged:(b) {onSelectedRow("asd");}
                                    ));

                                  });
                                }, icon: Icon(Icons.add),),
                              )
                            ],
                          ),

                          DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'ویژگی',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'عنوان',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),

                            ],
                            rows: tableItem,
                          )
                        ],)



                    ),
                    Expanded(child: DropdownButton(
                      value: productTypeDropDownValue,
                      items: productTypeDropDownItems.map((String items) {return DropdownMenuItem(value: items,child: Text(items),);}).toList(),
                      onChanged: (String? value) {setState(() {productTypeDropDownValue = value!;});},
                    ))
                    ],),),

                Padding(padding: EdgeInsets.all(16),
                  child:
                        Row(children: [
                          Expanded(child:DesignerDropDown(callback: onChangeDesignerDropDown,),),
                          Expanded(child:Workshop1DropDown(callback: onChangeWorkshop1DropDown,),),
                          Expanded(child:Workshop2DropDown(callback: onChangeWorkshop2DropDown,),),
                          ],),),
                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          )
      ,)


    );
  }
}