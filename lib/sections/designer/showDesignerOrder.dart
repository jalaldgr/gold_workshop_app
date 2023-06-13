

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gold_workshop/helper/designerApi.dart';
import 'package:gold_workshop/models/orderModel.dart';
import 'package:url_launcher/url_launcher.dart';


// Define a custom Form widget.
class ShowDesignerOrderScreen extends StatefulWidget {
  ShowDesignerOrderScreen({super.key,required this.order});
  orderData order;



  @override
  ShowDesignerOrderScreenState createState() {
    return ShowDesignerOrderScreenState();
  }
}


class ShowDesignerOrderScreenState extends State<ShowDesignerOrderScreen> {

  List<DataRow> tableItem=[DataRow(cells: [DataCell(Text("کلید")),DataCell(Text("مقدار"))])];
  TextEditingController imageEditTextController=TextEditingController();


  onChangeDesignerDropDown(value){
    setState(() {
      widget.order.designerId = value["id"];
      widget.order.designerFullName = value["fullName"];
    });
  }
  openImagePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['*'],
    );
    setState(() {
      imageEditTextController.text = "${result?.paths[0]}";
      widget.order.designerFile = "${result?.paths[0]}".replaceAll("\\", "\\\\");
    });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      Uri.parse("${dotenv.env['API_URL']}/public/uploads/${widget.order.image}"),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }


  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width >= 720;
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          backgroundColor: Colors.lightGreen,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('مشخصات سفارش',
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0)),
        ),
        body:SingleChildScrollView(
          child: Stack(
            children: [
              Container(
              decoration: BoxDecoration(color: Colors.white38),
              child:Center(
                child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.all(4)
                      ,child:
                      Card(child:
                      Container(padding:EdgeInsets.all(16),child:
                      Row(
                        children: [
                          Expanded(child: Column(children: [Text("نام مشتری",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.clientFullName}")],)),
                          Expanded(child: Column(children: [Text("طراح",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.designerFullName}")],)),
                          Expanded(child: Column(children: [Text("نوع محصول",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.productType}")],)),
                          Expanded(child: Column(children: [Text("تاریخ تحویل",style: TextStyle(fontSize: 14,color: Colors.grey),),Text("${widget.order.deliveryDate}")],)),
                        ],)
                        ,)

                        ,),
                    ),
                    Padding(padding: EdgeInsets.all(4),
                      child:Card(
                        child:
                        Container(margin:EdgeInsets.all(16),child:
                        // Flex(       direction: isScreenWide ? Axis.horizontal : Axis.vertical,
                        Row(
                          children: [
                            Expanded(child:Column(children: [Text("توضیحات",style: TextStyle(fontSize: 14,color: Colors.grey)),Text("${widget.order.description}")])),
                            Expanded(child: Row(children: [
                              Expanded(child:Row(children: [Text("${widget.order.instantDelivery=="true" ? "✓ تحویل فوری":""}"),],)),
                              Expanded(child:Row(children: [Text("${widget.order.paperDelivery=="true" ? "✓ کاغذی":""}"),],)),
                              Expanded(child:Row(children: [Text("${widget.order.feeOrder=="true" ? "✓ بیعانه":""}"),],)),
                              Expanded(child:Row(children: [Text("${widget.order.customerDelivery=="true" ? "✓ تحویل مشتری":""}"),],)),],
                            )
                            )]
                          ,)
                          ,),

                      )
                      ,),
                    Padding(padding: EdgeInsets.all(4),
                      child:Card(
                        child: Container(margin: EdgeInsets.all(16),
                          child:
                          Row(
                            children: [
                              InkWell(onTap: (){
                                launchUrl(Uri.parse("${dotenv.env['API_URL']}/public/uploads/${widget.order.image}"));

                              },child: Expanded(child: 
                              FadeInImage(width:256,image: NetworkImage("${dotenv.env['API_URL']}/public/uploads/${widget.order.image}"), placeholder: AssetImage("assets/images/placeholder.png"),)),),
                              Expanded(child:
                              Column(children: [
                                Row(
                                    children: []

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
                            ],),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(4),
                      child:Visibility(visible: widget.order.status=="در حال طراحی"?true:false,
                        child:Card(
                          child: Container(margin: EdgeInsets.all(16),
                            child:
                            Row(
                              children: [
                                Expanded(child:TextFormField(onTap: openImagePicker,controller: imageEditTextController,decoration: InputDecoration(hintText: "انتخاب فایل"),),),
                                Expanded(child:
                                Column(crossAxisAlignment: CrossAxisAlignment.stretch,children: [
                                  OutlinedButton(onPressed: () async {
                                    var res = await DesignerApi.SendOrderFileDesigner(widget.order);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
                                    Navigator.pop(context);
                                  }, child: Padding(padding: EdgeInsets.all(16),child: Expanded(child: Text("ارسال فایل")  ,))
                                  ),
                                  SizedBox(height: 16,),
                                  ElevatedButton(onPressed: () async {
                                    var res = await DesignerApi.completeOrderDesigner(widget.order);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${res}")));
                                    Navigator.pop(context);
                                  }, child: Padding(padding: EdgeInsets.all(16),child: Expanded(child: Text("تکمیل سفارش")  ,))
                                  ),
                                ],)
                                ),
                              ],
                            ),
                          ),
                        )
                        ,),
                    ),


                    // Add TextFormFields and ElevatedButton here.
                  ],
                ),
              )
              ,)
              ],
          ),
        )




    );
  }
}