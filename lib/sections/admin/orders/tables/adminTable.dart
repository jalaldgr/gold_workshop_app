import 'package:flutter/material.dart';
import 'package:gold_workshop/helper/serverApi.dart';
import 'package:gold_workshop/models/tableModel.dart';
import 'package:gold_workshop/sections/admin/draw_menu_admin.dart';

class AdminTableScreen extends StatefulWidget {
  const AdminTableScreen({Key? key}) : super(key: key);

  @override
  _AdminTableScreenState createState() => _AdminTableScreenState();
}

class _AdminTableScreenState extends State<AdminTableScreen> {
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
          title: const Text('جدول های امروز',
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
              FutureBuilder(
                future: AdminApi.getTable(),
                builder: (BuildContext context,
                    AsyncSnapshot<tableData> snapshot) =>
                snapshot.hasData
                    ?
                Padding(padding: EdgeInsets.all(4),
                    child:
                    Column(
                      children: [
                        Card(
                          child: Container(padding: EdgeInsets.all(8),
                            child: Text("${snapshot.data?.status}"),
                          ),
                        ),
                      ],
                    )
                )
                    : snapshot.hasError
                    ? Center(
                      child: Text('Error: ${snapshot.error}'),)
                    : snapshot.data != null
                    ? const Center(
                      child: Text("..."),)
                    : CircularProgressIndicator(),
              )
            ],),)

        ,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        )

    );
  }




}
