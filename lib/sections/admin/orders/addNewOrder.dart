import 'package:flutter/material.dart';
import 'package:gold_workshop/sections/admin/orders/designerDropDown.dart';

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
  bool instantDeliveryCheckBoxValue = false;
  bool deliveryByCustomerCheckBoxValue = false;
  bool feeCheckBoxValue = false;
  bool deliveryPaperCheckBoxValue = false;

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
                          Expanded(child:
                              DesignerDropDown(callback: onChangeDesignerDropDown,),

                          ),
                          Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "کارگاه 1"),),),
                          Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "کارگاه 2"),),),
                          Expanded(child: TextFormField(decoration: InputDecoration.collapsed(hintText: "توع مشتری"),),),],),),
                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          )
      ,)


    );
  }
}