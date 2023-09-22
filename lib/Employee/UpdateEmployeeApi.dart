import 'dart:convert';
import 'package:http/http.dart'as http;

import 'package:flutter/material.dart';
import 'package:mvvmproject/Employee/ViewEmployeeApi.dart';

class UpdateEmployeeApi extends StatefulWidget {


  @override
  State<UpdateEmployeeApi> createState() => _UpdateEmployeeApiState();
}

class _UpdateEmployeeApiState extends State<UpdateEmployeeApi> {

  TextEditingController _name = TextEditingController();
  TextEditingController _salary = TextEditingController();
  TextEditingController _age = TextEditingController();
  data()async{
    Uri uri = Uri.parse("https://dummy.restapiexample.com/api/v1/employee/1");
    var responce = await http.post(uri);
    if(responce.statusCode==200)
      {
        var body = responce.body.toString();
        print(body);
       var json = jsonDecode(body);
        if(json["status"]=="success")
          {
            setState(() {
              _name.text = json[""];
            });
          }
      }
    else
    {
      print("API ERROR");
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UpdateEmployeeApi")
      ),
        body:SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "NAME",
                    border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(10)
                    ),
                  ),
                  controller: _name,
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "SALARY",
                    border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(10)
                    ),
                  ),
                  controller: _salary,
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "AGE",
                    border: OutlineInputBorder(
                        borderRadius:BorderRadius.circular(10)
                    ),
                  ),
                  controller: _age,
                  keyboardType: TextInputType.text,
                ),

                ElevatedButton(
                    onPressed:() async {

                      var name = _name.text.toString();
                      var salary = _salary.text.toString();
                      var age = _age.text.toString();

                      Uri uri = Uri.parse("https://dummy.restapiexample.com/api/v1/create");
                      var responce = await http.post(uri,body: {
                        "name":name,
                        "salary":salary,
                        "age":age
                      });
                      if(responce.statusCode==200)
                      {
                        var body = responce.body.toString();
                        print(body);

                        var json = jsonDecode(body);
                        if(json["status"]=="success")
                        {
                          var msg = json["message"].toString();
                          print(msg);

                        }
                        else
                        {
                          var msg = json["message"].toString();
                          print(msg);
                        }
                      }
                      else
                      {
                        print("API ERROR");
                      }
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewEmployeeApi()));


                      print(name);
                      print(salary);
                      print(age);


                    },
                    child: Text("SUBMIT")
                ),
              ],
            ),
          ),
        )
    );
  }
}
