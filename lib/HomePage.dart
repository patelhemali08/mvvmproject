import 'package:flutter/material.dart';
import 'package:mvvmproject/Employee/InsertEmployeeApi.dart';
import 'package:mvvmproject/Employee/UpdateEmployeeApi.dart';
import 'package:mvvmproject/Employee/ViewEmployeeApi.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("HomePage"),
       ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InsertEmployeeApi()));
              },
              title: Text("InsertEmployeeApi"),
            ),
            Divider(color: Colors.black,),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewEmployeeApi()));
              },
              title: Text("ViewEmployeeApi"),
            ),
            Divider(color: Colors.black,),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UpdateEmployeeApi()));
              },
              title: Text("UpdateEmployeeApi"),
            ),
            Divider(color: Colors.black,),
          ],
        ),
      ),
    );
  }
}
